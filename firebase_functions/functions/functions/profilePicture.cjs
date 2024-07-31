const admin = require('firebase-admin');
const db = admin.firestore();

/**
 * @brief Returns the profile picture identifier from the user document
 * 
 * The Launchpad app has a pre-prepared set of profile pictures among which a
 * user can choose via their account settings. Their choice is saved in the
 * Firestore database, as a field within the user document. This function
 * retrieves the profile picture identifier from the user document and sends it
 * in the response.
 * 
 * @param {Object} req - The HTTP request object containing the user ID.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} - A promise that resolves when the response is sent.
 */
exports.getProfilePicture = async (req, res) => {
    try {
        // Extract the user ID from the request
        const userId = req.query.userId;
        if(!userId) {
            res.status(400).send('Bad Request: userId is required.');
            return;
        }
        
        // Retrieve the user document from Firestore
        const userDoc = await db.collection('users').doc(userId).get();

        // If the user document does not exist, send a 404 response
        if (!userDoc.exists) {
            res.status(404).send('User document not found');
        } else {
            // Get the value of the "profilePicture" field
            const profilePicture = userDoc.get('profilePicture');

            // Send the profile picture identifier in the response
            res.status(200).send({ profilePicture });
        }
    } catch (error) {
        // Send an error response if there is an issue getting the profile picture
        console.error('Error getting profile picture:', error);
        res.status(500).send('Error getting profile picture');
    }
};

/**
 * @brief Sets the profile picture identifier in the user document
 * 
 * The Launchpad app allows users to choose a profile picture from a predefined
 * set. This function updates the profile picture identifier in the user's
 * Firestore document based on the input received.
 * 
 * @param {Object} req - The HTTP request object containing the user ID and the new profile picture identifier.
 * @param {Object} res - The HTTP response object.
 * @returns {Promise<void>} - A promise that resolves when the response is sent.
 */
exports.setProfilePicture = async (req, res) => {
    try {
        // Extract the user ID and new profile picture identifier from the request
        const userId = req.query.userId;
        const newProfilePicture = req.body.profilePicture;
        
        if (!userId || !newProfilePicture) {
            res.status(400).send('Bad Request: userId and profilePicture are required.');
            return;
        }

        // Update the user document with the new profile picture identifier
        const userDocRef = db.collection('users').doc(userId);
        await userDocRef.set({ profilePicture: newProfilePicture }, { merge: true });

        // Send a success response
        res.status(200).send('Profile picture updated successfully');
    } catch (error) {
        // Send an error response if there is an issue updating the profile picture
        console.error('Error setting profile picture:', error);
        res.status(500).send('Error setting profile picture');
    }
};