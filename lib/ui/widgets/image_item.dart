import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';

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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ImageDetailsPage(image: image),
          ),
        );
      },
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
}
