import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:coding_test_yumemi/presentation/widget/repository_search_delegate.dart';

class SearchRepositoryPage extends ConsumerWidget {
  const SearchRepositoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appBar_title_searchRepositoryPage,
          style: TextStyle(fontSize: 20.sp),
        ),
        toolbarHeight: 58.h,
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 24.r),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RepositorySearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Image.asset(
          'assets/images/github-mark.png',
          width: 200.r,
          height: 200.r,
        ),
      ),
    );
  }
}
