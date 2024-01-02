part of 'search_images_bloc.dart';

sealed class SearchImagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchImagesFromQuery extends SearchImagesEvent {
  final String query;
  final bool fetchingMore;
  FetchImagesFromQuery({this.query = '', this.fetchingMore = false});
}

final class ResetSearch extends SearchImagesEvent {}

//final class FetchNextPage extends SearchImagesEvent {}
