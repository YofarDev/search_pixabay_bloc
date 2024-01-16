import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';
import 'package:search_pixabay_bloc/services/analytics_service.dart';

import '../pages/image_details_page.dart';

class ImageItem extends StatelessWidget {
  final PixabayImage image;

  const ImageItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onImageTap(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Hero(
            tag: image.id,
            child: CachedNetworkImage(
              // In the list we load a smaller format of the image
              imageUrl: image.webformatUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }

// Track the time spent on the image
  void _onImageTap(BuildContext context) async {
    DateTime startTime = DateTime.now();

    await Navigator.of(context)
        .push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ImageDetailsPage(image: image),
      ),
    )
        .then((value) {
      DateTime endTime = DateTime.now();
      int durationInSeconds = endTime.difference(startTime).inSeconds;
      AnalyticsService.logTimeSpentOnImage(
          image.largeImageUrl, durationInSeconds);
    });
  }
}
