import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/di/reposiroty_di.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

class RepositoryNotifier extends FamilyAsyncNotifier<List<Repository>, String> {
  @override
  Future<List<Repository>> build(String arg) async {
    final searchResponse =
        await ref.read(searchRepositoryGetUsecaseProvider).execute(arg);
    final repositories = searchResponse.items;
    return repositories;
  }
}

final repositoryNotifierProvider =
    AsyncNotifierProviderFamily<RepositoryNotifier, List<Repository>, String>(
  RepositoryNotifier.new,
);
