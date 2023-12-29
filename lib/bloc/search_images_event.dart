part of 'search_images_bloc.dart';

sealed class SearchImagesEvent {}

final class FetchImagesFromQuery extends SearchImagesEvent {
  final String query;
  FetchImagesFromQuery(this.query);
}

final class ResetSearch extends SearchImagesEvent {}

final class FetchNextPage extends SearchImagesEvent {}
