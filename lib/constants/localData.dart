import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class LocalData {
  static Future<List<String>> read(String query) async {
    String text;
    try {
      text = await rootBundle.loadString('assets/data/codes.txt');
    } catch (e) {
      print("Couldn't read codes textfile");
    }
    var codes = text.split('\n');

    try {
      text = await rootBundle.loadString('assets/data/locations.txt');
    } catch (e) {
      print("Couldn't read locations textfile");
    }
    var locations = text.split('\n');

    var ret = <String>[];
    for (int i = 0; i < locations.length; i++) {
      if (locations[i].contains(query.toUpperCase()) ||
          codes[i].contains(query.toUpperCase()))
        ret.add(locations[i] + " - " + codes[i].trim());
    }

    ret.shuffle();
    return ret;
  }

  String codeToLocation(String val) {}
}
