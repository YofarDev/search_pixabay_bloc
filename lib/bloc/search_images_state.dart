part of 'search_images_bloc.dart';



@immutable
sealed class SearchImagesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchImagesState {}

final class SearchLoading extends SearchImagesState {}

final class SearchLoaded extends SearchImagesState {
  final List<PixabayImage> images;
  SearchLoaded(this.images);
}

final class SearchError extends SearchImagesState {
  final String message;
  SearchError(this.message);
}
