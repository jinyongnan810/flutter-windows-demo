class Photo {
  final String id;
  final String url;
  final String downloadUrl;
  final String description;
  final String userName;
  final String userRef;

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
