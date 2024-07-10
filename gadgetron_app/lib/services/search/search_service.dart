import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gadgetron_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:gadgetron_app/services/search/models/search.dart';
import 'package:http/http.dart';

/// [SearchService] handles the network requests to the Google Programmable Search Engine via Firebase Functions.
///
/// This class provides a service-oriented architecture for making HTTP requests and processing the responses. It
/// encapsulates the logic for communicating with the Google Programmable Search Engine API via a call to Firebase
/// Functions, offering a simplified interface for performing searches and handling the results.
///
/// The main functionality is provided by the static method `performSearch`, which sends a GET request a Firebase
/// Functions REST API endpoint.
class SearchService {
  /// Performs a search using the Google Programmable Search Engine via a call to a Firebase Functions REST API
  /// endpoint.
  ///
  /// The endpoint used by this function is essentially a wrapper around a call to a Google Programmable Search
  /// Engine API endpoint. The only functionality offered by the Firebase Functions endpoint beyond the call to the
  /// Google Programmable Search Engine is to verify that the request is being made from an authenticated user. Once
  /// authenticated, the Firebase Functions endpoint forwards the request to the Google Programmable Search Engine API.
  /// Then, the response is returned to the client.
  ///
  /// Aside from authentication, the main purpose of using a Firebase Functions call rather than calling the Google
  /// Programmable Search Engine API directly is to avoid exposing the API key to the client. This is important because
  /// the API key is a sensitive piece of information that should not be shared with the client. In other words, the
  /// API key should not be included in the code for this app.
  ///
  /// This method is not used by the user directly. Rather, this `performSearch` method is called from Google Gemini
  /// function calling information. The Gemini model uses this method to perform searches for information in its
  /// responses for which up-to-date, accurate information is required.
  ///
  /// This function returns a `Future<Search>` which is the model class representing the search results. In case of a
  /// successful request, it returns a `Search` object containing the parsed search results. If the request fails, it
  /// throws an exception with details of the failure.
  static Future<Search> performSearch(String query) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/gadgetron-23712/us-central1/performSearch'
        : 'https://us-central1-gadgetron-23712.cloudfunctions.net/performSearch';

    // Get the current user.
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Assemble the URL for the request to the Cloud Function.
    final String url = '$functionUrl?q=$query';

    // Use a GET request to obtain the results of the search.
    Response response;
    try {
      response = await get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $idToken'},
      );
    } catch (e) {
      throw Exception('Search failed with exception, $e');
    }

    // A 200 status means the search was successful.
    if (response.statusCode == HttpStatus.ok) {
      return Search.fromJson(json.decode(response.body) as Map<String, dynamic>);
    }
    // Throw an exception for unsuccessful requests
    else {
      throw Exception(
        'Failed to load search results with status, ${response.statusCode}, and message, ${response.body}',
      );
    }
  }
}
