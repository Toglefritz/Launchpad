/**
 * @file authMiddleware.cjs
 * @brief Middleware function for authenticating Firebase ID tokens.
 *
 * The `authMiddleware.cjs` file contains a middleware function that verifies
 * the Firebase ID token sent in the request headers. This middleware is used
 * to protect Firebase Functions endpoints, ensuring that only authenticated
 * users can access them.
 * 
 * For endpoints that require a value for the `userId` parameter, this 
 * middleware also checks that the `userId` in the request matches the `uid`
 * in the decoded token. This check helps prevent users from accessing data
 * that does not belong to them, even if they posess a valid ID token.
 *
 * @details
 * This file performs the following tasks:
 * - Imports the Firebase Admin SDK authentication module.
 * - Defines an `authenticate` function that:
 *   - Extracts the ID token from the request headers.
 *   - Verifies the ID token using the Firebase Admin SDK.
 *   - Attaches the decoded token to the request object if verification is
 *     successful.
 *   - Sends an unauthorized response if the token is missing or invalid.
 * - Exports the `authenticate` function for use in other parts of the codebase.
 *
 * The `authenticate` function is essential for securing Firebase Functions by
 * verifying the identity of the users making requests. It ensures that only
 * authenticated users can access protected endpoints.
 */

// Import the Firebase Admin SDK.
const { getAuth } = require('firebase-admin/auth');

/**
 * @function authenticate
 * @brief Middleware function to authenticate Firebase ID tokens.
 *
 * This function extracts the ID token from the request headers, verifies it
 * using the Firebase Admin SDK, and attaches the decoded token to the request
 * object. If the token is missing or invalid, an unauthorized response is sent.
 *
 * @param {Object} req - The HTTP request object.
 * @param {Object} res - The HTTP response object.
 * @param {Function} next - The next middleware function in the stack.
 *
 * @return {void}
 */
const authenticate = async (req, res, next) => {
  // If this function is running in the Firebase Emulator Suite, skip
  // authentication.
  if (process.env.FUNCTIONS_EMULATOR === 'true') {
    return next();
  }

  const idToken = req.headers.authorization?.split('Bearer ')[1];
  if (!idToken) {
    return res.status(401).json({ message: 'Unauthorized (no ID token)' });
  }

  try {
    const decodedToken = await getAuth().verifyIdToken(idToken);
    req.user = decodedToken;

    // Check if the userId is provided in the request and matches the one in the token
    const userId = req.body.userId || req.query.userId;
    if (userId && userId !== decodedToken.uid) {
      return res.status(403).json({ message: 'Forbidden (userId mismatch)' });
    }

    next();
  } catch (error) {
    return res.status(401).json({ message: 'Unauthorized (token verification failed)' });
  }
};

// Export the authenticate function
module.exports = authenticate;