import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/state/repository_notifier.dart';
import 'package:coding_test_yumemi/presentation/widget/search_results_item_card.dart';
import 'package:coding_test_yumemi/presentation/widget/error_message_widget.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

class RepositorySearchResultList extends HookConsumerWidget {
  const RepositorySearchResultList({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryState = ref.watch(repositoryNotifierProvider(query));
    final scrollController = useScrollController();
    final isLoadingMore = useState(false);

    useEffect(() {
      void onScroll() async {
        // スクロールが一番下まで行ったら、追加でデータを読み込む
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (isLoadingMore.value) return; // データの読み込み中に再読み込みを行わないようにする

          try {
            // データの追加読み込み
            isLoadingMore.value = true;
            ref.read(repositoryNotifierProvider(query).notifier).loadMore();
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('データの読み込みに失敗しました。再試行してください。')),
              );
            }
          } finally {
            isLoadingMore.value = false;
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return repositoryState.when(
      data: (repositories) => repositories.isEmpty
          ? _buildEmptyMessage()
          : _buildRepositoryList(ref, scrollController, repositories),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorMessageWidget(message: error.toString()),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        '検索結果がありません >_<',
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  Widget _buildRepositoryList(
    WidgetRef ref,
    ScrollController scrollController,
    List<Repository> repositories,
  ) {
    return SafeArea(
      child: Column(
        children: [
          _buildSortButton(ref),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: repositories.length + 1,
              itemBuilder: (context, index) {
                if (repositories.length == index) {
                  // ListViewの一番下までスクロールした時にローディングを表示する
                  return Padding(
                    padding: EdgeInsets.all(8.r),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return SearchResultsItemCard(
                    key: ValueKey(repositories[index].id),
                    repository: repositories[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortButton(WidgetRef ref) {
    final notifier = ref.read(repositoryNotifierProvider(query).notifier);
    final isStarAscending = notifier.isStarAscending;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            notifier.toggleSortByStarCount();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.blue[100],
          ),
          child: Text(
            isStarAscending ? 'Star数（昇順）' : 'Star数（降順）',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
