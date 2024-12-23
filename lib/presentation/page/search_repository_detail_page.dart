import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:coding_test_yumemi/domain/type/repository.dart';

class SearchRepositoryDetailPage extends ConsumerWidget {
  const SearchRepositoryDetailPage({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'リポジトリの詳細',
          style: TextStyle(fontSize: 20.sp),
        ),
        toolbarHeight: 58.h,
      ),
      body: Center(
        child: _buildRepositoryDetailItems(),
      ),
    );
  }

  Widget _buildRepositoryDetailItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOwnerImage(),
        SizedBox(height: 24.h),
        _buildItemText('リポジトリ名', repository.name),
        SizedBox(height: 8.h),
        _buildItemText('プロジェクト言語', repository.language ?? 'なし'),
        SizedBox(height: 8.h),
        _buildItemText('Star数', repository.stargazersCount.toString()),
        SizedBox(height: 8.h),
        _buildItemText('Watcher数', repository.watchersCount.toString()),
        SizedBox(height: 8.h),
        _buildItemText('Fork数', repository.forksCount.toString()),
        SizedBox(height: 8.h),
        _buildItemText('Issue数', repository.openIssuesCount.toString()),
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
