import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/pixabay_image.dart';
import '../utils/constants.dart';

class SearchImagesService {
  Future<SearchResults> fetchImagesFromQuery(String query,
      {required int page}) async {
    final String url =
        'https://pixabay.com/api/?key=${Constants.pixabayApiKey}&q=$query&page=$page';

    final http.Response response = await http.get(
      Uri.parse(url),
    );

    // To get the total pages number, we divide the total hits by the number of images per page (20)
    final int totalPages = (jsonDecode(response.body)['totalHits'] / 20).ceil();

    debugPrint("http request : $url // total pages : $totalPages");

    return SearchResults(
        images: _parseImages(response.body),
        totalPages: totalPages,
        currentPage: page);
  }

  List<PixabayImage> _parseImages(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    final List<dynamic> hits = parsed['hits'];
    return hits.map((dynamic json) => PixabayImage.fromJson(json)).toList();
  }
}


