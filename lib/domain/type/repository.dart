import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:coding_test_yumemi/domain/type/owner.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  factory Repository({
    required int id,
    required String name,
    required Owner owner,
    required String language,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}
