import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:coding_test_yumemi/domain/type/repository.dart';

part 'search_response.freezed.dart';
part 'search_response.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  factory SearchResponse({
    required int totalCount,
    required bool incompleteResults,
    required List<Repository> items,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}
