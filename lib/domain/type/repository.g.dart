// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryImpl _$$RepositoryImplFromJson(Map<String, dynamic> json) =>
    _$RepositoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      language: json['language'] as String,
      stargazersCount: (json['stargazersCount'] as num).toInt(),
      watchersCount: (json['watchersCount'] as num).toInt(),
      forksCount: (json['forksCount'] as num).toInt(),
      openIssuesCount: (json['openIssuesCount'] as num).toInt(),
    );

Map<String, dynamic> _$$RepositoryImplToJson(_$RepositoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
      'language': instance.language,
      'stargazersCount': instance.stargazersCount,
      'watchersCount': instance.watchersCount,
      'forksCount': instance.forksCount,
      'openIssuesCount': instance.openIssuesCount,
    };
