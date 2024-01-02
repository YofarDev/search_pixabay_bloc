part of 'search_images_bloc.dart';

@immutable
sealed class SearchImagesState extends Equatable {
  @override
  List<List<PixabayImage>> get props => [];
}

final class SearchInitial extends SearchImagesState {}

final class SearchLoading extends SearchImagesState {}

final class SearchLoaded extends SearchImagesState {
  final List<PixabayImage> images;

  SearchLoaded(this.images);

  @override
  List<List<PixabayImage>> get props => [images];

  @override
  String toString() => 'SearchLoaded { images: ${images.length} }';
}



final class SearchError extends SearchImagesState {
  final String message;
  SearchError(this.message);
}
