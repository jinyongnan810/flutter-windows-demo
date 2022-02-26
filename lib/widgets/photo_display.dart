import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_demo/models/photo.dart';
import 'package:windows_demo/providers/photos.dart';

class PhotoDisplay extends StatefulWidget {
  const PhotoDisplay({Key? key}) : super(key: key);

  @override
  _PhotoDisplayState createState() => _PhotoDisplayState();
}

class _PhotoDisplayState extends State<PhotoDisplay> {
  @override
  Widget build(BuildContext context) {
    final photosProvider = Provider.of<Photos>(context);
    final photos = photosProvider.photos;
    return photos.isEmpty
        ? const Center(child: Text('No photos found'))
        : ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return ListTile(
                title: Text("${photo.userName}'s photo"),
                subtitle: Text(photo.description),
                leading: Image.network(photo.url),
              );
            },
          );
  }
}
