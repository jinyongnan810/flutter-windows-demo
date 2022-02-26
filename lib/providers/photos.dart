import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:windows_demo/models/photo.dart';

class Photos extends ChangeNotifier {
  List<Photo> _photos = [];
  List<Photo> get photos {
    return [..._photos];
  }

  Future<void> search(String text) async {
    // https://unsplash.com/documentation#search-photos
    final uri = Uri.parse('https://api.unsplash.com/search/photos?query=$text');
    final _accessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];
    final photosRes = await http.get(uri, headers: {
      'Accept-Version': 'v1',
      'Authorization': 'Client-ID $_accessKey',
    });
    final Map<String, dynamic> res = jsonDecode(photosRes.body);
    final List<dynamic> results = res['results'];
    final List<Photo> photos =
        results.map((photo) => Photo.fromJson(photo)).toList();
    _photos = photos;
    notifyListeners();
  }
}
