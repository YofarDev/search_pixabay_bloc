import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> logSearch(String searchTerm) async {
    await analytics.logEvent(
      name: 'search',
      parameters: <String, dynamic>{
        'search_term': searchTerm,
      },
    );
  }

  static Future<void> logTimeSpentOnImage(
      String imageUrl, int durationInSeconds) async {
    debugPrint('logTimeSpentOnImage: $imageUrl - $durationInSeconds');
    await analytics.logEvent(
      name: 'time_spent_on_image',
      parameters: <String, dynamic>{
        'image_url': imageUrl,
        'duration': durationInSeconds,
      },
    );
  }

  static Future<void> logScrollDepth(int itemsScrolled) async {
    await analytics.logEvent(
      name: 'scroll_depth',
      parameters: <String, dynamic>{
        'items_scrolled': itemsScrolled,
      },
    );
  }
}
