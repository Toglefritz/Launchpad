/**
 * @file toggleCompletion.cjs
 * @brief This module provides endpoints used to toggle the "complete" status
 * of directions or achievements in a project.
 */
const admin = require('firebase-admin');
const db = admin.firestore();

/**
 * @brief Toggles the "complete" status of a direction in a project's step.
 * 
 * This function toggles the "complete" status of a direction in a project's
 * step. It retrieves the project document from Firestore, finds the direction
 * by ID, and toggles the "complete" status. The updated project document is
 * then saved back to Firestore.
 *
 * @param {string} projectId - The ID of the project.
 * @param {string} directionId - The ID of the direction to toggle.
 * @returns {Promise<void>} - A promise that resolves when the update is complete.
 */
exports.toggleDirectionComplete = async (req, res) => {
    try {
        // Extract the project ID and direction ID from the request parameters.
        const { projectId, directionId } = req.query;

        // Check if the project ID and direction ID are present in the request.
        if (!projectId || !directionId) {
            res.status(400).send('Bad Request: projectId and directionId are required.');
            return;
        }

        // Get the project document from Firestore.
        const projectRef = db.collection('projects').doc(projectId);
        const projectDoc = await projectRef.get();

        // If the project does not exist, send a 404 response.
        if (!projectDoc.exists) {
            res.status(404).send('Project not found');
            return;
        }

        // Get the project data.
        const projectData = projectDoc.data();

        // Iterate over the steps to find the direction.
        for (let step of projectData.step) {
            for (let direction of step.itemListElement) {
                if (direction.id === directionId) {
                    // Toggle the "complete" status.
                    direction.complete = !direction.complete;

                    // Update the Firestore document.
                    await projectRef.update({ step: projectData.step });

                    // Send a success response.
                    res.status(200).send({ 'complete': direction.complete });
                    return;
                }
            }
        }

        // If the direction is not found, send a 404 response.
        res.status(404).send('Direction not found');
    } catch (error) {
        // Send an error response if the update fails.
        res.status(500).send('Error toggling direction status: ' + error.message);
    }
}

/**
 * @brief Toggles the "complete" status of an achievement in a project.
 * 
 * This function toggles the "complete" status of an achievement in a project.
 * This field is used to track which achievements have been completed by the
 * user. The updated project document is saved back to Firestore.
 *
 * @param {string} projectId - The ID of the project.
 * @param {string} achievementId - The ID of the achievement to toggle.
 * @returns {Promise<void>} - A promise that resolves when the update is complete.
 */
exports.toggleAchievementComplete = async (req, res) => {
    try {
        // Extract the project ID and achievement ID from the request
        // parameters.
        const { projectId, achievementId } = req.query;

        // Check if the project ID and achievement ID are present in the
        // request.
        if (!projectId || !achievementId) {
            res.status(400).send('Bad Request: projectId and achievementId are required.');
            return;
        }

        // Get the project document from Firestore.
        const projectRef = db.collection('projects').doc(projectId);
        const projectDoc = await projectRef.get();

        // If the project does not exist, send a 404 response.
        if (!projectDoc.exists) {
            res.status(404).send('Project not found');
            return;
        }

        // Get the project data.
        const projectData = projectDoc.data();

        // Iterate over the steps to find the direction.
        for (let achievement of projectData.achievement) {
            if (achievement.id === achievementId) {
                // Toggle the "complete" status.
                achievement.complete = !achievement.complete;

                // Update the Firestore document.
                await projectRef.update({ achievement: projectData.achievement });

                // Send a success response.
                res.status(200).send({ 'complete': achievement.complete });
                return;
            }
        }

        // If the achievement is not found, send a 404 response.
        res.status(404).send('Achievement not found');
    } catch (error) {
        // Send an error response if the update fails.
        res.status(500).send('Error toggling achievement status: ' + error.message);
    }
}