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
 *
 * @note The function files (like `performSearch.cjs`) contain the actual
 * implementation of the logic, keeping this file clean and focused on
 * defining the endpoints.
 */

const functions = require('firebase-functions');
const performSearch = require('./functions/performSearch.cjs');

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