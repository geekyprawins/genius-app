import 'package:flutter/material.dart';
import 'package:genius/services/hive_service.dart';
import 'package:genius/models/song/song.dart';
import 'package:genius/widgets/song_tile.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({Key? key}) : super(key: key);

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiveService.getRecents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: Center(
        child: FutureBuilder(
          future: HiveService.getRecents(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final recentSong = Song.fromJson(snapshot.data![index]);
                  return SongTile(
                    song: recentSong,
                    songTitle: recentSong.title,
                    imgUrl: recentSong.headerImageThumbnailURL,
                    artists: recentSong.artistNames,
                    songUrl: recentSong.url,
                  );
                },
                itemCount: snapshot.data?.length,
              );
            }

            return const Text('Nothing to display');
          },
        ),
      ),
    );
  }
}
