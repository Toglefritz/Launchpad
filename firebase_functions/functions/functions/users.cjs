/**
 * @file users.cjs
 * @brief This module provides endpoints for user management operations.
 * 
 * Each user in the Launchpad app is associated with a file in the Firestore
 * database that contains user-specific data. These endpoints allow users to
 * interact with information stored in their user profile, such as updating
 * their profile data or retrieving their projects.
 */

const admin = require('firebase-admin');
const db = admin.firestore();

/**
 * @brief Retrieves a list of projects associated with the user.
 * 
 * This function retrieves the list of project IDs associated with the user
 * profile from the 'currentProjects' array in the user document.
 * 
 * @param {Object} req - The HTTP request object containing the user ID and
 * project data.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<string>} - A promise that resolves with the ID of the
 * created project.
 */
exports.getCurrentProjects = async (req, res) => {
    try {
        // Extract the user ID from the request parameters.
        const { userId } = req.query;

        // Check if the user ID is present in the request.
        if (!userId) {
            res.status(400).send('Bad Request: userId is required.');
            return;
        }

        // Get the user document.
        const userDocRef = db.collection('users').doc(userId);
        const userDoc = await userDocRef.get();

        // If the user document exists, retrieve the list of current projects.
        if (userDoc.exists) {
            const currentProjects = userDoc.data().currentProjects || [];

            // If the user has no projects, send a 204 No Content response.
            if (currentProjects.length === 0) {
                res.status(204).send('No projects found.');
                return;
            } 
            // Else, send the list of project IDs in the response.
            else {

            // Send the list of project IDs in the response.
            res.status(200).send(currentProjects);
        }
        } else {
            // If the user document does not exist, send a 404 Not Found 
            // response.
            res.status(404).send('User not found.');
        }
    } catch (error) {
        console.error('Error getting user projects:', error);

        // Send a 500 Internal Server Error response.
        res.status(500).send('Internal Server Error');
    }
}

/**
 * @brief Retrieves the list of achievements earned by the user.
 * 
 * This function retrieves the list of achievements earned by the user from the
 * 'achievements' array in the user document. Each achievement in this array
 * is represented as an object with the following fields:
 * - id: The ID of the achievement.
 * - date: The date and time when the achievement was earned.
 * 
 * The function sends the list of achievements in the response.
 * 
 * @param {Object} req - The HTTP request object containing the user ID.
 * @param {Object} res - The HTTP response object.
 */
exports.getAchievements = async (req, res) => {
    try {
        // Extract the user ID from the request parameters.
        const { userId } = req.query;

        // Check if the user ID is present in the request.
        if (!userId) {
            res.status(400).send('Bad Request: userId is required.');
            return;
        }

        // Get the user document.
        const userDocRef = db.collection('users').doc(userId);
        const userDoc = await userDocRef.get();

        // If the user document exists, retrieve the list of achievements.
        if (userDoc.exists) {
            const achievements = userDoc.data().achievements || [];

            // If the user has no achievements, send a 204 No Content response.
            if (achievements.length === 0) {
                res.status(204).send('No achievements found.');
            } else {
                // Send the list of achievements in the response.
                res.status(200).send(achievements);
            }
        } else {
            // If the user document does not exist, send a 404 Not Found 
            // response.
            res.status(404).send('User not found.');
        }
    } catch (error) {
        console.error('Error getting user achievements:', error);

        // Send a 500 Internal Server Error response.
        res.status(500).send('Internal Server Error');
    }
}