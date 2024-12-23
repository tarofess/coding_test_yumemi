import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/usecase/search_repository_get_usecase.dart';
import 'package:coding_test_yumemi/infrastructure/repository/github_search_repository.dart';

final searchRepositoryGetUsecaseProvider = Provider<SearchRepositoryGetUsecase>(
  (ref) => SearchRepositoryGetUsecase(GithubSearchRepository()),
);
