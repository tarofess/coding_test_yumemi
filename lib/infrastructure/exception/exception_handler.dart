import 'dart:async';
import 'dart:io';

import 'package:coding_test_yumemi/application/exception/app_exception.dart';

class ExceptionHandler {
  static Future<AppException?> handleException(
    dynamic e,
    StackTrace? stackTrace,
  ) async {
    if (e is TimeoutException) {
      return AppException('接続がタイムアウトしました。インターネットの接続を確認してください。', e);
    } else if (e is SocketException) {
      return AppException('ネットワーク接続エラーが発生しました。インターネットの接続を確認してください。', e);
    } else if (e is HttpException) {
      return AppException('HTTPエラーが発生しました。インターネットの接続を確認してください。', e);
    } else if (e is FormatException) {
      return AppException('データフォーマットが不正です。正しいデータを入力してください。', e);
    } else if (e is Exception) {
      return null;
    } else {
      return AppException('予期せぬエラーが発生しました。しばらくしてから再度お試しください。', e);
    }
  }
}
