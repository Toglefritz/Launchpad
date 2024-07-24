const functions = require('firebase-functions');
const authenticate = require('../middleware/authMiddleware.cjs');
const verifyAppCheck = require('../middleware/verifyAppCheck.cjs');
const axios = require('axios');

/**
 * @brief Generates an image using the OpenAI DALL-E 3 API based on the provided
 * prompt.
 *
 * This function sends a POST request to the OpenAI API to generate an image.
 * The generated image data is returned in the response. The function handles
 * errors by logging them and throwing the error to be handled by the caller.
 *
 * @param {string} prompt The text prompt to generate the image.
 * @return {Promise<Object>} A promise that resolves to the response data
 * containing the generated image.
 *
 * @throws {Error} Throws an error if the API request fails.
 *
 * @see https://platform.openai.com/docs/guides/images/usage?lang=curl
 */

/**
 * Successful response from the OpenAI API:
 * 
 * {
 *   "created": 1721699361,
 *   "data": [
 *       {
 *           "revised_prompt": "A detailed visual representation of a snack typically enjoyed, but with an unusual twist. Imagine a stack of printed circuit boards (PCBs), usually found in electronic devices, arranged on a plate. The green and copper patterns of the circuit boards create a fascinating texture. Next to the PCBs, imagine a vibrant, freshly made salsa in a small bowl. The salsa has a notable contrast with red tomatoes, green cilantro, diced onions and jalapenos, and it is topped off with a drizzle of lime. Let this unusual but interesting snack combination come to life.",
 *           "url": "https://oaidalleapiprodscus.blob.core.windows.net/private/org-8hMnm06D7WpvdLPOS6a3DzbK/launchpad-demo/img-rd1AEDVmo8fFgQUq96eeVxsg.png?st=2024-07-23T00%3A49%3A21Z&se=2024-07-23T02%3A49%3A21Z&sp=r&sv=2023-11-03&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-07-23T00%3A14%3A55Z&ske=2024-07-24T00%3A14%3A55Z&sks=b&skv=2023-11-03&sig=1B8kBWNPrnGNII6UxOvLQH%2Bb4scvmaVV52R8uqG79dc%3D"
 *       }
 *   ]
 * }
 * 
 */

// TODO(Toglefritz): Convert this call to use Gemini when the API is available.
async function generateImage(req, res) {
  // Use verifyAppCheck for authentication.
  verifyAppCheck(req, res, async () => {
    // Verify the authentication token.
    authenticate(req, res, async () => {
      // Get the prompt from the request body.
      const { prompt } = req.body;
      if (!prompt) {
        return res.status(400).send('Bad Request: Missing prompt');
      }

      // Retrieve the OpenAI API key from Firebase Functions config.
      const key = functions.config().openai.key;

      // The URL for the OpenAI API Generations API.
      const url = 'https://api.openai.com/v1/images/generations';

      try {
        // Perform the POST request to the Generations API.
        const response = await axios.post(
          url,
          {
            model: "dall-e-3",
            prompt: prompt,
            n: 1
          },
          {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${key}`
            }
          }
        );

        // A 200 status means the search was successful
        if (response.status === 200) {
          // Send the search results back to the client
          res.status(200).json(response.data);
        } else {
          // Handle non-200 statuses by sending an error message
          res.status(response.status).send(`Failed to generate image with status, ${response.status}, and message, ${response.data}`);
        }
      } catch (error) {
        // Handle errors in the request
        console.error('Error generating image:', error);
        res.status(500).send(`Image generation failed with exception, ${error.message}`);
      }
    });
  });
}

module.exports = generateImage;