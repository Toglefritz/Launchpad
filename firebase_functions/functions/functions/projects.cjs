/**
 * @file projects.cjs
 * @brief This module provides CRUD operations for managing project files in
 * the Firestore database.
 * 
 * The projects managed by these operations conform to the schema.org HowTo
 * schema, with additional fields specific to the Launchpad app. Each project
 * is associated with a user profile and can be  created, read, updated, or
 * deleted through these functions.
 */

const admin = require('firebase-admin');
const db = admin.firestore();

/**
 * @brief Creates a new project in Firestore.
 * 
 * This function creates a new project document in the 'projects' collection
 * and associates the project ID with the user profile by adding it to the
 * 'currentProjects' array in the file for the user's profile in the `users`
 * collection.
 * 
 * @param {Object} req - The HTTP request object containing the user ID and
 * project data.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<string>} - A promise that resolves with the ID of the
 * created project.
 */
exports.createProject = async (req, res) => {
    try {
        // Extract the user ID and project data from the request body.
        const { userId, projectData } = req.body;

        // Check if the required fields are present in the request.
        if (!userId || !projectData) {
            res.status(400).send('Bad Request: userId and projectData are required.');
            return;
        }

        // Extract projectId from projectData.
        const projectId = projectData.projectId;

        // Add the project to the 'projects' collection using the projectId as
        // the document ID.
        await db.collection('projects').doc(projectId).set(projectData);

        // Get the user document.
        const userDocRef = db.collection('users').doc(userId);
        const userDoc = await userDocRef.get();

        if (userDoc.exists) {
            const currentProjects = userDoc.data().currentProjects || [];
            currentProjects.push(projectId);

            // Update the user's profile with the new project ID if the user
            // document exists
            await userDocRef.update({
                currentProjects: currentProjects
            });

            // Send the project ID in the response.
            res.status(201).send({ projectId });
        } else {
            // Handle the case where the user document does not exist
            res.status(404).send('User document not found');
        }
    } catch (error) {
        console.error('Error creating project:', error);

        // Send an error response if the project creation fails.
        res.status(500).send('Error creating project');
    }
};

/**
 * @brief Reads a project from Firestore by project ID.
 * 
 * This function retrieves a project document from the 'projects' collection
 * using the provided project ID. If the project is found, it returns the
 * project data; otherwise, it sends a 404 status.
 * 
 * @param {Object} req - The HTTP request object containing the project ID in
 * params.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<Object>} - A promise that resolves with the project data.
 */
exports.readProject = async (req, res) => {
    try {
        // Extract the project ID from the request parameters.
        const { projectId } = req.query;

        if (!projectId) {
            res.status(400).send('Bad Request: projectId is required.');
            return;
        }

        // Retrieve the project document from Firestore.
        const projectDoc = await db.collection('projects').doc(projectId).get();

        // Send the project data if the project exists; otherwise, send a 404
        // status.
        if (!projectDoc.exists) {
            res.status(404).send('Project not found');
        } else {
            // Send the project data in the response. The project ID is included
            // in the response for convenience.
            const projectData = projectDoc.data();
            res.status(200).send({ projectId, ...projectData });
        }
    } catch (error) {
        console.error('Error reading project:', error);

        // Send an error response if the project read fails.
        res.status(500).send('Error reading project');
    }
};

/**
 * @brief Updates an existing project in Firestore.
 * 
 * This function updates the specified project document in the 'projects'
 * collection with the provided updated data. It only updates the fields
 * included in the request body.
 * 
 * @param {Object} req - The HTTP request object containing the project ID in
 * params and updated data in body.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} - A promise that resolves when the update is
 * complete.
 */
exports.updateProject = async (req, res) => {
    try {
        // Extract the project ID and updated data from the request.
        const { projectId } = req.query;
        const updatedData = req.body;

        // Update the project document with the new data.
        await db.collection('projects').doc(projectId).update(updatedData);

        // Send a success response if the update is successful.
        res.status(200).send('Project updated successfully');
    } catch (error) {
        console.error('Error updating project:', error);

        // Send an error response if the project update fails.
        res.status(500).send('Error updating project');
    }
};

/**
 * @brief Deletes a project from Firestore.
 * 
 * This function deletes the specified project document from the 'projects'
 * collection and removes the project ID from the 'currentProjects' array in the
 * user's profile document.
 * 
 * @param {Object} req - The HTTP request object containing the project ID in
 * params and user ID in body.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} - A promise that resolves when the deletion is
 * complete.
 */
exports.deleteProject = async (req, res) => {
    try {
        // Extract the project ID and user ID from the request.
        const { projectId } = req.query;
        const { userId } = req.body;

        // Delete the project document.
        await db.collection('projects').doc(projectId).delete();

        // Retrieve the user document to get the current array of project IDs
        const userDocRef = db.collection('users').doc(userId);
        const userDoc = await userDocRef.get();

        if (!userDoc.exists) {
            res.status(404).send('User document not found');
            return;
        }

        // Update the user's profile to remove the project ID from the array
        const userData = userDoc.data();
        let currentProjects = userData.currentProjects || [];

        // Remove the projectId from the currentProjects array
        currentProjects = currentProjects.filter(id => id !== projectId);

        // Update the user document with the modified currentProjects array
        await userDocRef.update({ currentProjects });

        // Send a success response if the project is deleted.
        res.status(200).send('Project deleted successfully');
    } catch (error) {
        console.error('Error deleting project:', error);

        // Send an error response if the project deletion fails.
        res.status(500).send('Error deleting project');
    }
};