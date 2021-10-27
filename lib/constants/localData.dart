import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class LocalData {
  static Future<List<String>> read(String query) async {
    String text;
    try {
      text = await rootBundle.loadString('assets/data/new.txt');
    } catch (e) {
      print("Couldn't read file");
    }
    var codes = text.split('\n');
    var ret = <String>[];
    for (int i = 0; i < codes.length; i++) {
      if (codes[i].contains(query.toUpperCase())) ret.add(codes[i]);
    }
    return ret;
  }
}
