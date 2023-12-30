import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:search_pixabay_bloc/models/pixabay_image.dart';

import '../services/search_images_service.dart';

part 'search_images_event.dart';
part 'search_images_state.dart';

class SearchImagesBloc extends Bloc<SearchImagesEvent, SearchImagesState> {
  final SearchImagesService imageSearchService;
  final List<PixabayImage> images = [];
  late String query;
  late int currentPage;
  late bool hasReachedMax;

  SearchImagesBloc(
    this.imageSearchService,
  ) : super(SearchInitial()) {
    on<FetchImagesFromQuery>((event, emit) async {
      final bool firstFetch = event.firstFetch;
      if (firstFetch) {
        emit(SearchLoading());
        _initSearch();
        query = event.query;
      }

      if (query.isEmpty) {
        emit(SearchError("Veuillez saisir un mot clé"));
        return;
      }

      if (hasReachedMax) {
        return;
      }

      try {
        final results = await imageSearchService.fetchImagesFromQuery(query,
            page: currentPage);
        currentPage++;
        hasReachedMax = currentPage >= results.totalPages;
        images.addAll(results.images);
        emit(SearchLoaded(images));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    on<ResetSearch>((event, emit) {
      _initSearch();
      emit(SearchInitial());
    });
  }

  void _initSearch() {
    currentPage = 1;
    hasReachedMax = false;
    images.clear();
  }
}
