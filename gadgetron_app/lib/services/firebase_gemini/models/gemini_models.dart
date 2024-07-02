import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:gadgetron_app/services/firebase_gemini/gemini_service.dart';

/// An enumeration of Google Gemini LLM models that can be used in the [GeminiService] to return responses to prompts.
///
/// > The Gemini family of models are considered multimodal because they are capable of processing information from
/// > multiple modalities, including images, videos, and text. For example, you can send a Gemini model a photo of a
/// > plate of cookies and ask it to give you a recipe for those cookies.
///   - https://firebase.google.com/docs/vertex-ai/gemini-models?authuser=0
///
/// Note that this enumeration does not include all models available in the Gemini family. The models included in this
/// enumeration are those that are most likely to be used in the Gadgetron app.
enum GeminiModel {
  /// Gemini 1.5 Flash is a multimodal model that supports the same input and output types as 1.5 Pro
  /// (as well as total token count), but 1.5 Flash is specifically designed for high-volume, cost-effective
  /// applications.
  gemini15Flash('gemini-1.5-flash'),

  /// Gemini 1.5 Pro is a multimodal model that supports adding image, audio, video, and PDF files in text or chat
  /// prompts for a text or code response. Also, it supports long-context understanding with up to 1 million tokens.
  gemini15Pro('gemini-1.5-pro');

  /// An identifier for the model passed to the [FirebaseVertexAI] instance to get the model.
  final String modelIdentifier;

  /// Creates an instance of [GeminiModel].
  const GeminiModel(this.modelIdentifier);
}
