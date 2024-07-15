// createUserDocument.cjs
const admin = require('firebase-admin');

/**
 * @brief Creates a Firestore document for a new user.
 *
 * This function is triggered when a new user is created via Firebase 
 * Authentication. It creates a corresponding document in the Firestore 'users' 
 * collection with initial user data such as email, profile picture file name, 
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
  const userEmail = user.email;
  const uid = user.uid;

  // Get the current timestamp as the joined date.
  const joinedDate = admin.firestore.FieldValue.serverTimestamp();

  // Create the user document object.
  const userDoc = {
    // Use the user ID as the document ID.
    userId: uid,

    // The email address with which the user signed up.
    email: userEmail,

    // The filename of the user's profile picture.
    profilePicture: "default",

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