import 'package:dio/dio.dart';

import 'package:coding_test_yumemi/application/interface/search_repository.dart';
import 'package:coding_test_yumemi/domain/type/search_response.dart';
import 'package:coding_test_yumemi/application/exception/app_exception.dart';
import 'package:coding_test_yumemi/infrastructure/exception/exception_handler.dart';

class GithubSearchRepository implements SearchRepository {
  final Dio _dio;
  final int _perpage = 30;

  GithubSearchRepository()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: Duration(seconds: 10), // 接続タイムアウト
            receiveTimeout: Duration(seconds: 10), // 受信タイムアウト
          ),
        );

  @override
  Future<SearchResponse> getSearchResponse(
    String query,
    int currentPage,
  ) async {
    try {
      final uri = Uri.https(
        'api.github.com',
        '/search/repositories',
        {
          'q': query,
          'page': currentPage.toString(),
          'per_page': _perpage.toString(),
        },
      );

      final response = await _dio.get(uri.toString());
      final searchResponse = SearchResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      return searchResponse;
    } catch (e, stackTrace) {
      final exception = await ExceptionHandler.handleException(e, stackTrace);
      throw exception ?? AppException('検索結果が取得できませんでした。再度お試しください。');
    }
  }
}
