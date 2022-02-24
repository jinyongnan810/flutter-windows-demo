import 'package:fluent_ui/fluent_ui.dart';

typedef PhotoSearchDialogCallback = void Function(String searchQuery);

class PhotoSearchDialog extends StatefulWidget {
  const PhotoSearchDialog({Key? key, required this.callback}) : super(key: key);
  final PhotoSearchDialogCallback callback;

  @override
  _PhotoSearchDialogState createState() => _PhotoSearchDialogState();
}

class _PhotoSearchDialogState extends State<PhotoSearchDialog> {
  final _searchTextController = TextEditingController();
  bool _enableSearch = false;

  @override
  void initState() {
    _searchTextController.addListener(() {
      setState(() {
        _enableSearch = _searchTextController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Search Photo'),
      content: TextBox(
        autofocus: true,
        placeholder: 'Enter photo genre...',
        controller: _searchTextController,
        onSubmitted: (content) {
          if (content.isNotEmpty) {
            widget.callback(content);
            Navigator.of(context).pop();
          }
        },
      ),
      actions: [
        FilledButton(
            child: const Text('Search'),
            onPressed: _enableSearch
                ? () {
                    widget.callback(_searchTextController.text);
                    Navigator.of(context).pop();
                  }
                : null),
        Button(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
