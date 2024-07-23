const functions = require('firebase-functions');
const authenticate = require('../middleware/authMiddleware.cjs');
const axios = require('axios');

/**
 * @brief Handles search requests by calling the Google Programmable Search
 * Engine API.
 *
 * This function processes incoming HTTP requests to perform a search operation.
 * It verifies the authentication token from the request header, retrieves the
 * search query parameters, and calls the Google Programmable Search Engine API
 * to fetch search results. The results are then returned to the client.
 *
 * @param req The HTTP request object.
 *            - req.query.q: The search query string.
 * @param res The HTTP response object.
 *
 * @details
 * The function workflow is as follows:
 * - Verify the authentication token using the `authenticate` middleware.
 * - Retrieve the search query (`q`) from the request parameters.
 * - Retrieve the `cx` (Custom Search Engine ID) and `searchEngineKey` (API key)
 *   from Firebase Functions config.
 * - Assemble the URL for the Programmable Search Engine REST API request.
 * - Perform a GET request to the API.
 * - If the request is successful (HTTP status 200), return the search results
 *   in the response.
 * - If the request is unsuccessful, return an error message with the
 *   appropriate status code.
 * - Handle any exceptions that occur during the request and return a 500 status
 *   with the error message.
 *
 * @note The `authenticate` middleware ensures that only authenticated requests
 * can access this function. The actual search logic is encapsulated in this
 * function, making it reusable and easier to maintain.
 */
async function performSearch(req, res) {
  // Verify the authentication token.
  authenticate(req, res, async () => {
    // Retrieve the search query from the request
    const query = req.query.q;

    // Retrieve the cx and API key from Firebase Functions config
    const cx = functions.config().search.cx;
    const searchEngineKey = functions.config().search.key;

    // The base URL for the Programmable Search Engine REST API
    const baseUrl = 'https://www.googleapis.com/customsearch/v1';

    // Assemble the URL for the REST API request
    const url = `${baseUrl}?q=${encodeURIComponent(query)}&cx=${cx}&key=${searchEngineKey}`;

    try {
      // Perform the GET request to the search API
      const response = await axios.get(url);

      // A 200 status means the search was successful
      if (response.status === 200) {
        // Send the search results back to the client
        res.status(200).json(response.data);
      } else {
        // Handle non-200 statuses by sending an error message
        res.status(response.status).send(`Failed to load search results with status, ${response.status}, and message, ${response.data}`);
      }
    } catch (error) {
      // Handle errors in the request
      res.status(500).send(`Search failed with exception, ${error.message}`);
    }
  });
}

module.exports = performSearch;