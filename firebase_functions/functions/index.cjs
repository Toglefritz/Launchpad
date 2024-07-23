/**
 * @file index.cjs
 * @brief Entry point for Firebase Cloud Functions.
 *
 * This file defines a series of HTTP endpoints for the Firebase Cloud
 * Functions. Each endpoint calls a corresponding function that encapsulates the
 * business logic for that endpoint. The separate function files are used to
 * modularize and organize the code, making it easier to manage and maintain.
 *
 * The following endpoint is defined in this file:
 * - performSearch: Calls the `performSearch` function to handle search 
 *   requests.
 * - createUserDocument: Firebase Function trigger for creating a user document.
 *   This function is triggered when a new user is created via Firebase and is
 *   not intended to be called directly via HTTP.
 * - generateImage: Uses generative AI technology to create an image based on a
 *   text prompt.
 *
 * @note The function files (like `performSearch.cjs`) contain the actual
 * implementation of the logic, keeping this file clean and focused on
 * defining the endpoints.
 */

const functions = require('firebase-functions');

// Import the functions that handle the business logic for each endpoint.
const performSearch = require('./functions/performSearch.cjs');
const createUserDocument = require('./functions/createUserDocument.cjs');
const generateImage = require('./functions/generateImage.cjs');

/**
 * @brief Endpoint calling the performSearch function.
 *
 * This endpoint handles HTTP requests for performing a search. It delegates
 * the actual search logic to the `performSearch` function defined in a separate
 * file, which encapsulates the business logic for handling search operations.
 */
exports.performSearch = functions.https.onRequest(async (req, res) => {
  await performSearch(req, res);
});

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
 * business logic for generating images using the OpenAI API.
 */
exports.generateImage = functions.https.onRequest(async (req, res) => {
  await generateImage(req, res);
});