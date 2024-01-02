import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_images_bloc.dart';
import '../../res/app_strings.dart';
import '../widgets/list_images.dart';

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
        context.read<SearchImagesBloc>().add(FetchMoreFromSameQuery());
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
            hintText: hintSearch,
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
                return ListImages(
                    images: images, scrollController: _scrollController);

              case SearchError():
                return Center(
                  child: Text(state.message),
                );
            }
          },
        ),
      );

  Widget _noResults() => const Center(
        child: Text(noResults),
      );

  void _onSearchSubmitted(String value) {
    context.read<SearchImagesBloc>().add(FetchImagesFromQuery(query: value));
  }
}
