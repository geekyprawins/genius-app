import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songTitle,
    required this.imgUrl,
    required this.artists,
  });
  final String songTitle;
  final String imgUrl;
  final String artists;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            if (imgUrl.isNotEmpty)
              Ink(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imgUrl),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songTitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'by',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            artists,
                            // style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
