import 'package:coding_test_yumemi/application/interface/search_repository.dart';
import 'package:coding_test_yumemi/domain/type/search_response.dart';

class SearchRepositoryGetUsecase {
  final SearchRepository _searchRepository;

  SearchRepositoryGetUsecase(this._searchRepository);

  Future<SearchResponse> execute(String query, int currentPage) async {
    return await _searchRepository.getSearchResponse(query, currentPage);
  }
}
