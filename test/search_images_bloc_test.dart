import 'package:mockito/mockito.dart';
import 'package:search_pixabay_bloc/bloc/search_images_bloc.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';
import 'package:search_pixabay_bloc/services/search_images_service.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('SearchImagesBloc', () {
    late MockSearchImagesService mockSearchImagesService;
    late SearchImagesBloc searchImagesBloc;

    setUp(() {
      mockSearchImagesService = MockSearchImagesService();
      searchImagesBloc = SearchImagesBloc(mockSearchImagesService);
    });

    blocTest<SearchImagesBloc, SearchImagesState>(
      'emits [] when nothing is added',
      build: () => searchImagesBloc,
      expect: () => [],
    );

    // TEST FOR FetchImagesFromQuery
    blocTest<SearchImagesBloc, SearchImagesState>(
      'emits [SearchLoading, SearchLoaded] when FetchImagesFromQuery is added',
      build: () => searchImagesBloc,
      act: (bloc) => bloc.add(FetchImagesFromQuery(query: 'cats')),
      expect: () => [
        SearchLoading(),
        SearchLoaded([mockedImage]),
      ],
    );

    // TEST FOR FetchMoreFromSameQuery
    blocTest<SearchImagesBloc, SearchImagesState>(
      'emits [SearchLoaded] with additional images when FetchMoreFromSameQuery is added',
      build: () => searchImagesBloc,
      act: (bloc) => bloc
        ..add(FetchImagesFromQuery(query: 'cats'))
        ..add(FetchMoreFromSameQuery()),
      expect: () => [
        SearchLoading(),
        // After initial fetch
        SearchLoaded([mockedImage]),
        // After fetch more
        SearchLoaded([mockedImage, mockedImage2]),
      ],
    );

    // TEST FOR ResetSearch
    blocTest<SearchImagesBloc, SearchImagesState>(
      'emits [SearchInitial] when ResetSearch is added',
      build: () => searchImagesBloc,
      act: (bloc) => bloc.add(ResetSearch()),
      expect: () => [SearchInitial()],
    );
  });
}

// Mock API service & fake data
class MockSearchImagesService extends Mock implements SearchImagesService {
  @override
  Future<SearchResults> fetchImagesFromQuery(String query,
      {int page = 1}) async {
    if (page == 1) {
      return SearchResults(
          totalPages: 2, currentPage: page, images: [mockedImage]);
    } else {
      return SearchResults(
          totalPages: 2, currentPage: page, images: [mockedImage2]);
    }
  }
}

PixabayImage mockedImage = PixabayImage.fromJson(const {
  "id": 11,
  "pageURL": "https://pixabay.com/en/cute-cat-11/",
  "webformatURL": "https://pixabay.com/get/35bbf209e13e39d2_640.jpg",
  "largeImageURL": "https://pixabay.com/get/ed6a99fd0a76647_1280.jpg",
});

PixabayImage mockedImage2 = PixabayImage.fromJson(const {
  "id": 22,
  "pageURL": "https://pixabay.com/en/ugly-cat-22/",
  "webformatURL": "https://pixabay.com/get/5bbf209e13e39d21_640.jpg",
  "largeImageURL": "https://pixabay.com/get/d6a99fd0a766472_1280.jpg",
});
