import 'package:json_annotation/json_annotation.dart';
part 'song.g.dart';

@JsonSerializable()
class Song {
  @JsonKey(name: 'api-path')
  final String apiPath;
  final int id;
  @JsonKey(name: 'artist-names')
  final String artistNames;
  final String title;
  @JsonKey(name: 'header_image_thumbnail_url')
  final String headerImageThumbnailURL;
  @JsonKey(name: 'header_image_url')
  final String headerImageURL;
  @JsonKey(name: 'release_date_for_display')
  final String releaseDateForDisplay;
  final String url;
  final String path;

  Song({
    required this.apiPath,
    required this.id,
    required this.artistNames,
    required this.title,
    required this.headerImageThumbnailURL,
    required this.headerImageURL,
    required this.releaseDateForDisplay,
    required this.url,
    required this.path,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
