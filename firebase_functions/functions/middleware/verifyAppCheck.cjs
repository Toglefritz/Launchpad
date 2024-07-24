// Import Firebase Admin SDK
const admin = require('firebase-admin');

/**
 * Middleware to verify Firebase AppCheck tokens.
 * @param {Request} req - The request object from Express.js
 * @param {Response} res - The response object from Express.js
 * @param {Function} next - The next middleware function in the stack.
 */
const verifyAppCheck = async (req, res, next) => {
    // If this function is running in the Firebase Emulator Suite, skip
    // authentication.
    if (process.env.FUNCTIONS_EMULATOR === 'true') {
        return next();
    }

    // Extract the AppCheck token from the request headers
    const appCheckToken = req.headers['x-appcheck-token'];

    if (!appCheckToken) {
        return res.status(401).send('AppCheck token is required');
    }

    try {
        // Verify the AppCheck token
        const appCheckClaims = await admin.appCheck().verifyToken(appCheckToken);
        // Attach the claims to the request object for further use
        req.appCheckClaims = appCheckClaims;
        next();
    } catch (error) {
        console.error('Error verifying AppCheck token:', error);
        return res.status(403).send('Invalid AppCheck token');
    }
};

module.exports = verifyAppCheck;