import 'package:launchpad_app/services/search/models/cse_image.dart';
import 'package:launchpad_app/services/search/models/cse_thumbnail.dart';

/// `PageMaps` is a structured data format that provides Google with information about the data on a page. It enables
/// website creators to embed data and notes in webpages. Although this information is not visible to website
/// visitors, Custom Search Engines recognize the data and use it to provide more relevant results. Because PageMaps
/// do not require adherence to a specific schema, all of the fields in this class are nullable to account
/// for JSON payloads that may not contain the keys needed for each field.
///
/// See https://developers.google.com/custom-search/docs/structured_data#pagemaps for information about the responses
/// received from CSE searches.
class PageMap {
  /// A list of search result thumbnails for the search result.
  final List<CseThumbnail>? cseThumbnails;

  /// A list of search result images. These are generally larger in size than thumbnails.
  final List<CseImage>? cseImages;

  // TODO(Toglefritz): parse other information like reviews

  /// Creates a [PageMap] object with the specified information.
  PageMap({
    required this.cseThumbnails,
    required this.cseImages,
  });

  /// Returns a [PageMap] object parsed from the JSON returned by the Google Custom Search API.
  factory PageMap.fromJson(Map<String, dynamic> json) {
    return PageMap(
      cseThumbnails: (json['cse_thumbnail'] as List<dynamic>?)
          ?.map((dynamic thumbnail) => CseThumbnail.fromJson(thumbnail as Map<String, dynamic>))
          .toList(),
      cseImages: (json['cse_image'] as List<dynamic>?)
          ?.map((dynamic image) => CseImage.fromJson(image as Map<String, dynamic>))
          .toList(),
    );
  }
}
