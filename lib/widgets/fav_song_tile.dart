import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius/constants.dart';
import 'package:genius/providers/favourites_provider.dart';
import 'package:genius/services/hive_service.dart';
import 'package:genius/widgets/webview_container.dart';
import 'package:provider/provider.dart';
import '../models/song/song.dart';

class FavSongTile extends StatefulWidget {
  const FavSongTile({
    super.key,
    required this.songTitle,
    required this.imgUrl,
    required this.artists,
    required this.songUrl,
    required this.song,
  });
  final String songTitle;
  final String imgUrl;
  final String artists;

  final String songUrl;
  final Song song;

  @override
  State<FavSongTile> createState() => _FavSongTileState();
}

class _FavSongTileState extends State<FavSongTile> {
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            if (widget.imgUrl.isNotEmpty)
              Ink(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imgUrl),
                  ),
                ),
              )
            else
              Container(
                height: 100,
                width: 100,
                color: Colors.blueGrey,
                child: const Icon(
                  Icons.music_note,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () async {
                    await HiveService.putDataInRecents(widget.song.toJson());
                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         WebViewContainer(widget.songUrl, widget.songTitle),
                    //   ),
                    // );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.songTitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'by',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.artists,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              splashRadius: 1,
              onPressed: () {
                favProvider.deleteFavSong(widget.song.id);
              },
              icon: const FaIcon(
                FontAwesomeIcons.trash,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
