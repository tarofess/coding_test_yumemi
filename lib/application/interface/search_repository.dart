import 'package:coding_test_yumemi/domain/type/search_response.dart';

abstract class SearchRepository {
  Future<SearchResponse> getSearchResponse(String query, int currentPage);
}
