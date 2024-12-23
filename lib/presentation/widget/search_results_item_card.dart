import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:coding_test_yumemi/domain/type/repository.dart';

class SearchResultsItemCard extends ConsumerWidget {
  const SearchResultsItemCard({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Card(
        elevation: 1.r,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: ListTile(
            title: Text(
              repository.name,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ),
      ),
      onTap: () => context.push(
        '/search_repository_detail_page',
        extra: {'repository': repository},
      ),
    );
  }
}
