// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      apiPath: json['api_path'] as String,
      id: json['id'] as int,
      artistNames: json['artist_names'] as String,
      title: json['title'] as String,
      headerImageThumbnailURL: json['header_image_thumbnail_url'] as String,
      headerImageURL: json['header_image_url'] as String,
      releaseDateForDisplay: json['release_date_for_display'] as String,
      url: json['url'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'api_path': instance.apiPath,
      'id': instance.id,
      'artist_names': instance.artistNames,
      'title': instance.title,
      'header_image_thumbnail_url': instance.headerImageThumbnailURL,
      'header_image_url': instance.headerImageURL,
      'release_date_for_display': instance.releaseDateForDisplay,
      'url': instance.url,
      'path': instance.path,
    };
