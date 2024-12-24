import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:coding_test_yumemi/domain/type/repository.dart';

class SearchRepositoryDetailPage extends ConsumerWidget {
  const SearchRepositoryDetailPage({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appBar_title_searchRepositoryDetailPage,
          style: TextStyle(fontSize: 20.sp),
        ),
        toolbarHeight: 58.h,
      ),
      body: Center(
        child: _buildRepositoryDetailItems(context),
      ),
    );
  }

  Widget _buildRepositoryDetailItems(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOwnerImage(),
        SizedBox(height: 24.h),
        _buildItemText(AppLocalizations.of(context)!.label_repositoryName,
            repository.name),
        SizedBox(height: 8.h),
        _buildItemText(
          AppLocalizations.of(context)!.label_projectLanguage,
          repository.language ?? AppLocalizations.of(context)!.label_none,
        ),
        SizedBox(height: 8.h),
        _buildItemText(
          AppLocalizations.of(context)!.label_starCount,
          repository.stargazersCount.toString(),
        ),
        SizedBox(height: 8.h),
        _buildItemText(
          AppLocalizations.of(context)!.label_watcherCount,
          repository.watchersCount.toString(),
        ),
        SizedBox(height: 8.h),
        _buildItemText(
          AppLocalizations.of(context)!.label_forkCount,
          repository.forksCount.toString(),
        ),
        SizedBox(height: 8.h),
        _buildItemText(
          AppLocalizations.of(context)!.label_issueCount,
          repository.openIssuesCount.toString(),
        ),
      ],
    );
  }

  Widget _buildOwnerImage() {
    return ClipOval(
      child: SizedBox(
        width: 200.r,
        height: 200.r,
        child: CachedNetworkImage(
          imageUrl: repository.owner.avatarUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildItemText(String leadingText, String value) {
    return Text(
      '$leadingText: $value',
      style: TextStyle(fontSize: 14.sp),
    );
  }
}
