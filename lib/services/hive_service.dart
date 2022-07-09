import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';

import 'package:flutter/material.dart';
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

  static Map<String, dynamic> jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }

  static Future<List<Map<String, dynamic>>> getRecents() async {
    print("inside GET");
    final prefs = await SharedPreferences.getInstance();
    // var recentsBox = await Hive.openBox('recents');
    // List<Map<String, dynamic>> recentData = [];
    // final myValues = recentsBox.values.toList();
    // for (var i = 0; i < myValues.length; i++) {
    //   final res = myValues[i] as Map<String, dynamic>;
    //   recentData.add(res);
    // }

    // return Future(() => recentData);
    final List<String> items = await prefs.getStringList('recents') ?? [];
    var recents = <Map<String, dynamic>>[];
    for (final s in items) {
      recents.add(Map<String, dynamic>.from(json.decode(s) as Map));
    }
    return Future(() => recents);
  }
}
