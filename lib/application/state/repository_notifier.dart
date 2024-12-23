import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/di/reposiroty_di.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

class RepositoryNotifier extends FamilyAsyncNotifier<List<Repository>, String> {
  bool isStarAscending = true; // 昇順か降順かを保持するフラグ

  @override
  Future<List<Repository>> build(String arg) async {
    final searchResponse =
        await ref.read(searchRepositoryGetUsecaseProvider).execute(arg);
    final repositories = searchResponse.items;
    return repositories;
  }

  void toggleSortByStarCount() {
    isStarAscending = !isStarAscending;

    state.whenData((repositories) {
      final sortedRepositories = List<Repository>.from(repositories)
        ..sort((a, b) => isStarAscending
            ? a.stargazersCount.compareTo(b.stargazersCount)
            : b.stargazersCount.compareTo(a.stargazersCount));

      state = AsyncValue.data(sortedRepositories);
    });
  }
}

final repositoryNotifierProvider =
    AsyncNotifierProviderFamily<RepositoryNotifier, List<Repository>, String>(
  RepositoryNotifier.new,
);
