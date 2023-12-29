import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/pixabay_image.dart';
import '../utils/constants.dart';

class SearchImagesService {
  Future<SearchedResults> fetchImagesFromQuery(String query,
      {required int page}) async {
    final String url =
        'https://pixabay.com/api/?key=${Constants.pixabayApiKey}&q=$query&page=$page';

    final http.Response response = await http.get(
      Uri.parse(url),
    );

    final int totalPages = (jsonDecode(response.body)['totalHits'] / 20).ceil();

    debugPrint("http request : $url // total pages : $totalPages");

    return SearchedResults(
        images: _parseImages(response.body),
        totalPages: totalPages,
        currentPage: page);
  }

  List<PixabayImage> _parseImages(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    //print(parsed)
    final List<dynamic> hits = parsed['hits'];
    return hits.map((dynamic json) => PixabayImage.fromJson(json)).toList();
  }
}

class SearchedResults {
  List<PixabayImage> images;
  int totalPages;
  int currentPage;

  SearchedResults({
    required this.images,
    required this.totalPages,
    required this.currentPage,
  });
}
