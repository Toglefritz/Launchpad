/**
 * @file index.cjs
 * @brief Entry point for Firebase Cloud Functions.
 *
 * This file defines a series of HTTP endpoints for the Firebase Cloud
 * Functions. Each endpoint calls a corresponding function that encapsulates the
 * business logic for that endpoint. The separate function files are used to
 * modularize and organize the code, making it easier to manage and maintain.
 *
 * @note The function files contain the actual implementation of the logic, 
 * keeping this file clean and focused on defining the endpoints.
 */

// Import the Firebase configuration and initialize the Firebase Admin SDK.
require('./config/firebaseConfig.cjs');

// Import the Firebase Functions module.
const functions = require('firebase-functions');

// Import the functions that handle the business logic for each endpoint.
const createUserDocument = require('./functions/createUserDocument.cjs');
const { generateImage, getImage } = require('./functions/generateImage.cjs');
const { createProject, readProject, updateProject, deleteProject, setCurrentStep } = require('./functions/projects.cjs');
const { getCurrentProjects, getAchievements } = require('./functions/users.cjs');
const { toggleDirectionComplete, toggleAchievementComplete } = require('./functions/toggleCompletion.cjs');
const { getProfilePicture, setProfilePicture } = require('./functions/profilePicture.cjs');

// Import the authentication middleware.
const authenticate = require('./middleware/authMiddleware.cjs');
const verifyAppCheck = require('./middleware/verifyAppCheck.cjs');

/**
 * @brief Firebase Function trigger for creating a user document.
 *
 * This Firebase Function is triggered automatically when a new user is created 
 * via Firebase Authentication. It calls the createUserDocument function to 
 * create a corresponding document in Firestore with initial user data.
 *
 * @param {functions.auth.UserRecord} user - The user record object containing 
 * information about the newly created user.
 */
exports.createUserDocument = functions.auth.user().onCreate(async (user) => {
  await createUserDocument(user);
});

/**
 * @brief Endpoint calling the generateImage function.
 *
 * This endpoint handles HTTP requests for creating an image. It calls the 
 * `generateImage` function defined in a separate file, which encapsulates the 
 * business logic for generating images using the OpenAI API. The endpoint will
 * return the name of the file stored in Firebase Storage.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.generateImage = functions.https.onRequest(async (req, res) => {
  // Use verifyAppCheck for authentication.
  verifyAppCheck(req, res, async () => {
    // Verify the Bearer token.
    authenticate(req, res, async () => {
      await generateImage(req, res);
    });
  });
});

/**
 * @brief Endpoint for retrieving an image from Firebase Storage.
 * 
 * This endpoint handles HTTP requests for retrieving an image from Firebase
 * Storage. It calls the `getImage` function defined in a separate file, which
 * encapsulates the business logic for retrieving images. The endpoint accepts
 * a query parameter `fileName` that specifies the name of the image file to
 * retrieve.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.getImage = functions.https.onRequest(async (req, res) => {
  // Use verifyAppCheck for authentication.
  verifyAppCheck(req, res, async () => {
    // Verify the Bearer token.
    authenticate(req, res, async () => {
      await getImage(req, res);
    });
  });
});

/**
 * @brief Endpoint for creating a project.
 *
 * This endpoint handles HTTP requests for creating a project. It calls the 
 * `createProject` function defined in a separate file, which encapsulates the 
 * business logic for creating a project.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.createProject = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await createProject(req, res);
    });
  });
});

/**
 * @brief Endpoint for reading a project.
 *
 * This endpoint handles HTTP requests for reading a project. It calls the 
 * `readProject` function defined in a separate file, which encapsulates the 
 * business logic for reading a project.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.readProject = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await readProject(req, res);
    });
  });
});

/**
 * @brief Endpoint for updating a project.
 *
 * This endpoint handles HTTP requests for updating a project. It calls the 
 * `updateProject` function defined in a separate file, which encapsulates the 
 * business logic for updating a project.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.updateProject = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await updateProject(req, res);
    });
  });
});

/**
 * @brief Endpoint for deleting a project.
 *
 * This endpoint handles HTTP requests for deleting a project. It calls the 
 * `deleteProject` function defined in a separate file, which encapsulates the 
 * business logic for deleting a project.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.deleteProject = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await deleteProject(req, res);
    });
  });
});

/**
 * @brief Endpoint for setting the current step of a project.
 * 
 * This endpoint handles HTTP requests for setting the current step of a project.
 * It calls the `setCurrentStep` function defined in a separate file, which
 * encapsulates the business logic for setting the current step of a project.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.setCurrentStep = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await setCurrentStep(req, res);
    });
  });
});

/**
 * @brief Endpoint for retrieving a list of projects associated with the user.
 *
 * This endpoint handles HTTP requests for retrieving a list of projects 
 * associated with the user. It calls the `getCurrentProjects` function defined 
 * in a separate file, which encapsulates the business logic for retrieving 
 * projects.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.getCurrentProjects = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await getCurrentProjects(req, res);
    });
  });
});

/**
 * @brief Endpoint for toggling the "complete" status of a direction in a project.
 * 
 * This endpoint handles HTTP requests for toggling the "complete" status of a
 * direction in a project. It calls the `toggleDirectionComplete` function defined
 * in a separate file, which encapsulates the business logic for toggling the
 * "complete" status of a direction in a project.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.toggleDirectionComplete = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await toggleDirectionComplete(req, res);
    });
  });
});

/**
 * @brief Endpoint for getting the user's profile picture value.
 * 
 * This endpoint handles HTTP requests for getting the user's profile picture
 * value. It calls the `getProfilePicture` function defined in a separate file,
 * which encapsulates the business logic for getting the user's profile picture
 * value.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.getProfilePicture = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await getProfilePicture(req, res);
    });
  });
});

/**
 * @brief Endpoint for setting the user's profile picture value.
 * 
 * This endpoint handles HTTP requests for setting the user's profile picture
 * value. It calls the `setProfilePicture` function defined in a separate file,
 * which encapsulates the business logic for setting the user's profile picture
 * value.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.setProfilePicture = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await setProfilePicture(req, res);
    });
  });
});

/**
 * @brief Endpoint for toggling the "complete" status of an achievement.
 * 
 * This endpoint handles HTTP requests for toggling the "complete" status of an
 * achievement in a project. It calls the `toggleAchievementComplete` function
 * defined in a separate file, which encapsulates the business logic for toggling
 * the "complete" status of an achievement in a project.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.toggleAchievementComplete = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await toggleAchievementComplete(req, res);
    });
  });
});

/**
 * @brief Endpoint for retrieving the list of achievements earned by the user.
 * 
 * This endpoint handles HTTP requests for retrieving the list of achievements
 * earned by the user. It calls the `getAchievements` function defined in a
 * separate file, which encapsulates the business logic for retrieving the list
 * of achievements earned by the user.
 * 
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 */
exports.getAchievements = functions.https.onRequest((req, res) => {
  verifyAppCheck(req, res, async () => {
    authenticate(req, res, async () => {
      await getAchievements(req, res);
    });
  });
});
