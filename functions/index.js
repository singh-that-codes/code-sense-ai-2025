const logger = require("firebase-functions/logger"); // ✅ Optional logging

const functions = require('firebase-functions');
const { GoogleGenerativeAI } = require('@google/generative-ai');
const cors = require('cors')({ origin: true });

const genAI = new GoogleGenerativeAI("AIzaSyBiv1a8uFiKO3FvZTCGggbC0OOGFLGsLnI");

exports.analyzeCode = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const code = req.body.code;
    if (!code) return res.status(400).send("Missing code");

    try {
      const model = genAI.getGenerativeModel({ model: "gemini-pro" });
      const result = await model.generateContent([
        `Perform a static code analysis for this code and list the possible issues, vulnerabilities, code smells, and optimization suggestions:\n\n${code}`
      ]);

      const response = await result.response;
      const text = response.text();
      res.send({ analysis: text });
    } catch (err) {
      console.error(err);
      res.status(500).send("Gemini analysis failed");
    }
  });
});
