import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart' show Card, BorderSide;
import 'package:url_launcher/link.dart';
import 'package:windows_demo/models/photo.dart';

class PhotoDetail extends StatefulWidget {
  final Photo photo;
  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  @override
  _PhotoDetailState createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Card(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.successPrimaryColor)),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 750),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 400, minWidth: 400),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.photo.url,
                      imageSemanticLabel: widget.photo.description,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.photo.description),
          )
        ],
      )),
    ));
  }
}
