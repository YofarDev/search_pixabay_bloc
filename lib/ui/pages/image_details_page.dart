// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:search_pixabay_bloc/models/pixabay_image.dart';

class ImageDetailsPage extends StatelessWidget {
  final PixabayImage image;

  const ImageDetailsPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _imageItem(image),
            _backButton(context),
          ],
        ),
      ),
    );
  }

  Widget _imageItem(PixabayImage image) => Hero(
        tag: image.largeImageUrl,
        child: CachedNetworkImage(
          imageUrl: image.largeImageUrl,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      );

  Widget _backButton(BuildContext context) => Positioned(
        top: 16,
        left: 16,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      );
}
