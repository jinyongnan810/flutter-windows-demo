import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:windows_demo/models/photo.dart';
import 'package:windows_demo/providers/photos.dart';
import 'package:windows_demo/widgets/split.dart';

class PhotoDisplay extends StatefulWidget {
  const PhotoDisplay({Key? key}) : super(key: key);

  @override
  _PhotoDisplayState createState() => _PhotoDisplayState();
}

class _PhotoDisplayState extends State<PhotoDisplay> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final photosProvider = Provider.of<Photos>(context);
    final photos = photosProvider.photos;
    final selectedPhoto = photosProvider.selectedPhoto;
    return photos.isEmpty
        ? const Center(child: Text('No photos found'))
        : Split(
            axis: Axis.horizontal,
            initialFirstFraction: 0.2,
            firstChild: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: TreeView(
                    items: photos.map((p) => _buildPhotoListItem(p)).toList(),
                  ),
                )),
            secondChild: Center(
                child: selectedPhoto == null
                    ? Container()
                    : Image.network(selectedPhoto.url)),
          );
  }

  TreeViewItem _buildPhotoListItem(Photo photo) {
    void selectPhoto(Photo photo) {
      final photosProvider = Provider.of<Photos>(context, listen: false);
      photosProvider.selectPhoto(photo);
    }

    return TreeViewItem(
        key: ValueKey(photo.id),
        onInvoked: (ctx) async => selectPhoto(photo),
        content: Semantics(
          button: true,
          label: 'Photo by ${photo.userName}',
          excludeSemantics: true,
          child: Text('Photo by ${photo.userName}'),
        ));
  }
}
