import 'package:file_selector/file_selector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Photo {
  final String id;
  final String url;
  final String downloadUrl;
  final String description;
  final String userName;
  final String userRef;
  Future<void> save() async {
    final path = await getSavePath(
      suggestedName: '$id.jpg',
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'JPG',
          extensions: ['jpg'],
          mimeTypes: ['image/jpeg'],
        ),
      ],
    );
    if (path != null) {
      final _accessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];
      final bytes = await http.readBytes(Uri.parse(downloadUrl), headers: {
        'Accept-Version': 'v1',
        'Authorization': 'Client-ID $_accessKey',
      });
      final photoFile = XFile.fromData(bytes, mimeType: 'image/jpeg');
      await photoFile.saveTo(path);
    }
  }

  Photo(
      {required this.id,
      required this.url,
      required this.downloadUrl,
      required this.description,
      required this.userName,
      required this.userRef});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['urls']['regular'],
      downloadUrl: json['links']['download'],
      description: json['description'] ?? 'No description',
      userName: json['user']['name'],
      userRef: json['user']['username'],
    );
  }
}
