part of 'search_images_bloc.dart';

sealed class SearchImagesEvent {}

final class FetchImagesFromQuery extends SearchImagesEvent {
  final String query;
  final bool firstFetch;
  FetchImagesFromQuery({this.query = '', this.firstFetch = true});
}

final class ResetSearch extends SearchImagesEvent {}

//final class FetchNextPage extends SearchImagesEvent {}
