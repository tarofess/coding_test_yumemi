import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/presentation/page/search_repository_page.dart';
import 'package:coding_test_yumemi/presentation/page/search_repository_detail_page.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SearchRepositoryPage(),
      ),
      GoRoute(
        path: '/search_repository_detail_page',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final repository = extra['repository'] as Repository;
          return SearchRepositoryDetailPage(repository: repository);
        },
      ),
    ],
  );
});
