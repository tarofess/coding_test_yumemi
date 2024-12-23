import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/application/state/repository_notifier.dart';
import 'package:coding_test_yumemi/presentation/widget/search_results_item_card.dart';
import 'package:coding_test_yumemi/presentation/widget/error_message_widget.dart';
import 'package:coding_test_yumemi/domain/type/repository.dart';

class RepositorySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, size: 24.r),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 24.r),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildResults(BuildContext context) {
    return RepositorySearchResults(query: query);
  }
}

class RepositorySearchResults extends HookConsumerWidget {
  const RepositorySearchResults({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryState = ref.watch(repositoryNotifierProvider(query));

    return repositoryState.when(
      data: (repositories) => repositories.isEmpty
          ? _buildEmptyMessage()
          : _buildRepositoryList(ref, repositories),
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

  Widget _buildRepositoryList(WidgetRef ref, List<Repository> repositories) {
    return SafeArea(
      child: Column(
        children: [
          _buildSortButton(ref),
          Expanded(
            child: ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (context, index) => SearchResultsItemCard(
                key: ValueKey(repositories[index].id),
                repository: repositories[index],
              ),
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
