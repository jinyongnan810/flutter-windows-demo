import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Photos extends ChangeNotifier {
  Future<void> search(String text) async {
    // https://unsplash.com/documentation#search-photos
    final uri = Uri.parse('https://api.unsplash.com/search/photos?query=$text');
    final _accessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];
    final ordersRes = await http.get(uri, headers: {
      'Accept-Version': 'v1',
      'Authorization': 'Client-ID $_accessKey',
    });
    if (jsonDecode(ordersRes.body) == null) {
      return;
    }
    final Map<String, dynamic> res = jsonDecode(ordersRes.body);
    print(res);
  }
}
