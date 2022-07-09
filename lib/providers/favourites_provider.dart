import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/song/song.dart';

class FavouritesProvider with ChangeNotifier {
  addWishListData({
    required String apiPath,
    required int id,
    required String artistNames,
    required String title,
    required String headerImageThumbnailURL,
    required String headerImageURL,
    required String releaseDateForDisplay,
    required String url,
    required String path,
  }) {
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourFavourites")
        .doc(id.toString())
        .set({
      'api_path': apiPath,
      'id': id,
      'artist_names': artistNames,
      'title': title,
      'header_image_thumbnail_url': headerImageThumbnailURL,
      'header_image_url': headerImageURL,
      'release_date_for_display': releaseDateForDisplay,
      'url': url,
      'path': path,
      "favList": true,
    });
  }

///// Get WishList Data ///////
  List<Song> favSongs = [];

  getWishtListData() async {
    List<Song> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("favourite")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourFavourites")
        .get();
    value.docs.forEach(
      (element) {
        Song productModel = Song(
          apiPath: element.get('api_path') as String,
          id: element.get('id') as int,
          artistNames: element.get('artist_names') as String,
          title: element.get('title') as String,
          headerImageThumbnailURL:
              element.get('header_image_thumbnail_url') as String,
          headerImageURL: element.get('header_image_url') as String,
          releaseDateForDisplay:
              element.get('release_date_for_display') as String,
          url: element.get('url') as String,
          path: element.get('path') as String,
        );
        newList.add(productModel);
      },
    );
    favSongs = newList;
    notifyListeners();
  }

  List<Song> get getWishList {
    return favSongs;
  }

////////// Delete WishList /////
  deleteWishtList(id) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(id.toString())
        .delete();
  }
}
