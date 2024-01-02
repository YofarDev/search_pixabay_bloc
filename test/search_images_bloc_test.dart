import 'package:mockito/mockito.dart';
import 'package:search_pixabay_bloc/bloc/search_images_bloc.dart';
import 'package:search_pixabay_bloc/models/pixabay_image.dart';
import 'package:search_pixabay_bloc/services/search_images_service.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';



class MockSearchImagesService extends Mock implements SearchImagesService {
  @override
  Future<SearchResults> fetchImagesFromQuery(String query,
      {int page = 1}) async {
    return SearchResults(totalPages: 1, currentPage: page, images: [
      PixabayImage.fromJson(const {
        "id": 195893,
        "pageURL": "https://pixabay.com/en/cute-cat-195893/",
        "webformatURL": "https://pixabay.com/get/35bbf209e13e39d2_640.jpg",
        "largeImageURL": "https://pixabay.com/get/ed6a99fd0a76647_1280.jpg",
      })
    ]);
  }
}

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
      act: (bloc) =>
          bloc.add(FetchImagesFromQuery(query: 'cats', fetchingMore: false)),
      expect: () => [
        SearchLoading(),
        SearchLoaded(const []),
      ],
    );

    // TEST FOR ResetSearch
    blocTest<SearchImagesBloc, SearchImagesState>(
      'emits [SearchInitial] when ResetSearch is added',
      build: () => searchImagesBloc,
      act: (bloc) => bloc.add(ResetSearch()),
      expect: () => [
        SearchInitial(),
      ],
    );
  });
}
