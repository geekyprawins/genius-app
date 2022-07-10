import 'package:flutter/material.dart';
import 'package:genius/services/hive_service.dart';
import 'package:genius/models/song/song.dart';
import 'package:genius/widgets/fav_song_tile.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/favourites_provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key, required this.fp}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
  final FavouritesProvider fp;
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  FavouritesProvider? favProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HiveService.getFromPrefs(Constants.favourites);
  }

  @override
  Widget build(BuildContext context) {
    favProvider = widget.fp;
    favProvider!.getFavSongsData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final recentSong = favProvider!.getFavSongs[index];
            return FavSongTile(
              song: recentSong,
              songTitle: recentSong.title,
              imgUrl: recentSong.headerImageThumbnailURL,
              artists: recentSong.artistNames,
              songUrl: recentSong.url,
            );
          },
          itemCount: favProvider!.getFavSongs.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
