import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';
import 'package:search_pixabay_bloc/res/app_strings.dart';

import '../services/analytics_service.dart';
import '../services/search_images_service.dart';

part 'search_images_event.dart';
part 'search_images_state.dart';

class SearchImagesBloc extends Bloc<SearchImagesEvent, SearchImagesState> {
  final SearchImagesService imageSearchService;
  late String query;
  late int currentPage;
  late int totalPages;
  late bool hasReachedMax;

  SearchImagesBloc(
    this.imageSearchService,
  ) : super(SearchInitial()) {
    /**************************************************************************
     *  FETCH IMAGES FROM QUERY
     *************************************************************************/
    on<FetchImagesFromQuery>((event, emit) async {
      emit(SearchLoading());
      _initSearch();
      query = event.query;

      // Check if query is empty
      if (query.isEmpty) {
        emit(SearchError(emptySearchQueryError));
        return;
      }
  
      // Log search query
      AnalyticsService.logSearch(query);

      try {
        // Fetch images from query and current page (default is 1)
        final results = await imageSearchService.fetchImagesFromQuery(query,
            page: currentPage);
        totalPages = results.totalPages;
        hasReachedMax = currentPage >= totalPages;

        emit(SearchLoaded(results.images));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    /**************************************************************************
     *  FETCH MORE IMAGES FROM SAME QUERY
     *************************************************************************/
    on<FetchMoreFromSameQuery>((event, emit) async {
      debugPrint(
          "hasReachedMax: $hasReachedMax // currentPage: $currentPage // totalPages: $totalPages // query: $query");

      if (hasReachedMax) return;
      currentPage++;
      hasReachedMax = currentPage >= totalPages;

      final results = await imageSearchService.fetchImagesFromQuery(query,
          page: currentPage);

      // Append new results to old ones
      emit(SearchLoaded([...state.props.first, ...results.images]));
    });

    /**************************************************************************
     *  RESET SEARCH
     *************************************************************************/
    on<ResetSearch>((event, emit) {
      _initSearch();
      emit(SearchInitial());
    });
  }

  void _initSearch() {
    query = '';
    currentPage = 1;
    hasReachedMax = false;
  }
}
