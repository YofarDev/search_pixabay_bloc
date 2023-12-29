import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';
import 'package:search_pixabay_bloc/ui/pages/image_details_page.dart';

import '../../bloc/search_images_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<SearchImagesBloc>().add(FetchNextPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          _searchField(),
          Expanded(child: _searchResults()),
        ]),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: 'Chercher sur Pixabay',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      context.read<SearchImagesBloc>().add(ResetSearch());
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null),
        onSubmitted: _onSearchSubmitted);
  }

  Widget _searchResults() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<SearchImagesBloc, SearchImagesState>(
          builder: (context, state) {
            switch (state) {
              case SearchInitial():
                return Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Opacity(
                          opacity: 0.3,
                          child: SizedBox(
                              width: 200,
                              child: Image.asset('assets/pixabay.jpg')),
                        )));

              case SearchLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case SearchLoaded():
                final images = state.images;
                if (images.isEmpty) {
                  return _noResults();
                }
                return _listImages(images);

              case SearchError():
                return Center(
                  child: Text(state.message),
                );
            }
          },
        ),
      );

  Widget _listImages(List<PixabayImage> images) => ListView.builder(
      controller: _scrollController,
      itemCount: images.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: index == 0 ? 8 : 0),
          child: _imageItem(images[index]),
        );
      });

  Widget _noResults() => const Center(
        child: Text('Aucun résultat'),
      );

  Widget _imageItem(PixabayImage image) => InkWell(
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
              tag: image.largeImageUrl,
              child: CachedNetworkImage(
                imageUrl: image.largeImageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      );

  void _onSearchSubmitted(String value) {
    context.read<SearchImagesBloc>().add(FetchImagesFromQuery(value));
  }
}
