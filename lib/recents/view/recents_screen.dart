import 'package:flutter/material.dart';
import 'package:genius/services/hive_service.dart';
import 'package:genius/models/song/song.dart';
import 'package:genius/widgets/song_tile.dart';

import '../../constants.dart';
import '../../providers/favourites_provider.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({Key? key, required this.fp}) : super(key: key);

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
  final FavouritesProvider fp;
}

class _RecentsScreenState extends State<RecentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiveService.getFromPrefs(Constants.recents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: Center(
        child: FutureBuilder(
          future: HiveService.getFromPrefs(Constants.recents),
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
                    isFav: false,
                    song: recentSong,
                    songTitle: recentSong.title,
                    imgUrl: recentSong.headerImageThumbnailURL,
                    artists: recentSong.artistNames,
                    songUrl: recentSong.url,
                    fp: widget.fp,
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
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
