import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/di/reposiroty_di.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

class RepositoryNotifier extends FamilyAsyncNotifier<List<Repository>, String> {
  bool isStarAscending = true; // 昇順か降順かを保持するフラグ
  bool _hasMoreData = true; // スクロールした時にデータがあるかどうかを保持するフラグ
  int _currentPage = 1; // 無限スクロールのための現在保持しているページ数

  @override
  Future<List<Repository>> build(String arg) async {
    return await _fetchRepositories(arg);
  }

  Future<List<Repository>> _fetchRepositories(String query) async {
    final searchResponse = await ref
        .read(searchRepositoryGetUsecaseProvider)
        .execute(query, _currentPage);

    final repositories = searchResponse.items;
    _hasMoreData = repositories.isNotEmpty; // 追加で読み込むデータがあるかどうかを判定
    return repositories;
  }

  Future<void> loadMore() async {
    if (!_hasMoreData) return; // 追加で読み込むデータがない場合は何もしない

    // 新しいデータを追加読み込み
    _currentPage++;
    final newRepositories = await _fetchRepositories(arg);

    state.whenData((currentRepositories) {
      state = AsyncValue.data([...currentRepositories, ...newRepositories]);
    });
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
