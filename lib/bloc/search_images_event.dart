part of 'search_images_bloc.dart';

sealed class SearchImagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchImagesFromQuery extends SearchImagesEvent {
  final String query;
  FetchImagesFromQuery({this.query = ''});
}

final class FetchMoreFromSameQuery extends SearchImagesEvent {}

final class ResetSearch extends SearchImagesEvent {}
