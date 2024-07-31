// createUserDocument.cjs
const admin = require('firebase-admin');

/**
 * @brief Creates a Firestore document for a new user.
 *
 * This function is triggered when a new user is created via Firebase 
 * Authentication. It creates a corresponding document in the Firestore 'users' 
 * collection with initial user data such as a rofile picture file name, 
 * joined date, and empty arrays for achievements, current projects, and 
 * completed projects.
 *
 * @param {admin.auth.UserRecord} user - The user record object containing 
 * information about the newly created user.
 * @returns {Promise<FirebaseFirestore.WriteResult>} A promise that resolves 
 * with the result of the Firestore write operation.
 */
async function createUserDocument(user) {
  // Extract user information from the user record.
  const uid = user.uid;

  // Get the current timestamp as the joined date.
  var joinedDate = '';
  if (process.env.FUNCTIONS_EMULATOR === 'true') {
    joinedDate = new Date();
  } else {
    const joinedDate = admin.firestore.FieldValue.serverTimestamp();
  }

      // Generate a random number betweeen 1 and 9 (inclusive) to assign a profile 
    // picture to the user.
    const imageId = Math.floor(Math.random() * 9) + 1;

  // Create the user document object.
  const userDoc = {
    // Use the user ID as the document ID.
    userId: uid,

    // The filename of the user's profile picture.
    profilePicture: `profile_picture_${imageId}.png`,

    // The date and time when the user joined (the timestamp of when this 
    // function is called).
    joinedDate: joinedDate,

    // Arrays to store user achievements, current projects, and completed 
    // projects.
    achievements: [],
    currentProjects: [],
    completedProjects: []
  };

  // Set the user document in the Firestore 'users' collection.
  return admin.firestore().collection('users').doc(uid).set(userDoc);
}

module.exports = createUserDocument;