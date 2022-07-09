import 'package:flutter/material.dart';
import 'package:genius/services/hive_service.dart';
import 'package:genius/models/song/song.dart';
import 'package:genius/widgets/song_tile.dart';

import '../../constants.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiveService.getFromPrefs(Constants.favourites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: Center(
        child: FutureBuilder(
          future: HiveService.getFromPrefs(Constants.favourites),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final recentSong = Song.fromJson(snapshot.data![index]);
                  return SongTile(
                    isFav: true,
                    song: recentSong,
                    songTitle: recentSong.title,
                    imgUrl: recentSong.headerImageThumbnailURL,
                    artists: recentSong.artistNames,
                    songUrl: recentSong.url,
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }
            return const Text('Nothing to display');
          },
        ),
      ),
    );
  }
}
