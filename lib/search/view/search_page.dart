import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:genius/constants.dart';
import 'package:genius/models/song.dart';

import '../../widgets/song_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final dio = Dio();
  String? _searchTerm;
  final TextEditingController _searchCtrl = TextEditingController();

  Future<List<Song>> performSearch(String q) async {
    final songs = <Song>[];
    final response = await dio.get(
      Constants.searchUrl,
      queryParameters: {'q': q},
      options: Options(headers: Constants.headers),
    );
    final jsonData = response.data as Map<String, dynamic>;
    final results = jsonData['response']['hits'];
    var r = results as Iterable;
    for (var i = 0; i < List.from(r).length; i++) {
      Map<String, dynamic> res =
          r.toList()[i]['result'] as Map<String, dynamic>;
      songs.add(Song.fromJson(res));
    }
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      // onChanged: (v) {
                      //   setState(() {
                      //     _searchTerm = v;
                      //   });
                      // },
                      controller: _searchCtrl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search any song',
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a search term';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            setState(() {
                              _searchTerm = _searchCtrl.text;
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                            performSearch(_searchTerm!);
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 5,
                        ),
                        child: const Text('Search'),
                      ),
                    ),
                  ],
                ),
              ),
              if (_searchTerm == null)
                Expanded(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.search,
                        size: 120,
                        color: Colors.black12,
                      ),
                      Text(
                        'No results to display',
                        style: TextStyle(
                          color: Colors.black12,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                )
              else
                FutureBuilder(
                  future: performSearch(_searchTerm!),
                  builder: (context, AsyncSnapshot<List<Song>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final song = snapshot.data![index];
                            return SongTile(
                              songTitle: song.title,
                              imgUrl: song.headerImageThumbnailURL,
                              artists: song.artistNames,
                            );
                          },
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      );
                    }
                    return Text('Error: ${snapshot.error}');
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
