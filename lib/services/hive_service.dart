import 'dart:convert';

import 'package:genius/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class HiveService {
  static Future openRecentsBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return;
  }

  static Future<void> putDataInRecents(Map<String, dynamic> data) async {
    // await openRecentsBox();
    // var recentsBox = await Hive.openBox('recents');
    // await recentsBox.add(data).then((value) => print('Added to hive!'));
    // return;
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = await prefs.getStringList('recents') ?? [];
    items.add(jsonEncode(data));
    await prefs.setStringList('recents', items);
  }

  static Future<void> manageFavourites(
    bool isLiked,
    Map<String, dynamic> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(Constants.favourites) ?? [];
    if (isLiked) {
      items.add(jsonEncode(data));
    } else {
      items.remove(jsonEncode(data));
    }
    await prefs.setStringList(Constants.favourites, items);
  }

  static Future<List<Map<String, dynamic>>> getFromPrefs(String pref) async {
    final prefs = await SharedPreferences.getInstance();
    // var recentsBox = await Hive.openBox('recents');
    // List<Map<String, dynamic>> recentData = [];
    // final myValues = recentsBox.values.toList();
    // for (var i = 0; i < myValues.length; i++) {
    //   final res = myValues[i] as Map<String, dynamic>;
    //   recentData.add(res);
    // }

    // return Future(() => recentData);
    final List<String> items = await prefs.getStringList(pref) ?? [];
    var recents = <Map<String, dynamic>>[];
    for (final s in items) {
      recents.add(Map<String, dynamic>.from(json.decode(s) as Map));
    }
    return Future(() => recents);
  }

  static Future<bool> checkFav(Map<String, dynamic> data) async {
    bool isLiked;
    final items = await HiveService.getFromPrefs(Constants.favourites);
    if (items.contains(data)) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    return isLiked;
  }
}
