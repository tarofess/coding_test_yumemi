// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResponseImpl _$$SearchResponseImplFromJson(Map<String, dynamic> json) =>
    _$SearchResponseImpl(
      totalCount: (json['totalCount'] as num).toInt(),
      incompleteResults: json['incompleteResults'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => Repository.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchResponseImplToJson(
        _$SearchResponseImpl instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'incompleteResults': instance.incompleteResults,
      'items': instance.items,
    };
