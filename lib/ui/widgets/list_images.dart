import 'package:flutter/material.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';

import 'image_item.dart';

class ListImages extends StatelessWidget {
  final List<PixabayImage> images;
  final ScrollController scrollController;

  const ListImages({
    Key? key,
    required this.images,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: images.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: index == 0 ? 8 : 0),
            child: ImageItem(image: images[index]),
          );
        });
  }
}
