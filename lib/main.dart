import 'package:fluent_ui/fluent_ui.dart';
import 'package:menubar/menubar.dart' as menubar;
import 'package:windows_demo/widgets/photo_search_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Searcher',
        home: AppHome(
          title: 'Image Searh',
        ));
  }
}

class AppHome extends StatelessWidget {
  final String title;
  const AppHome({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    menubar.setApplicationMenu([
      menubar.Submenu(label: 'Search', children: [
        menubar.MenuItem(
            label: 'Search...',
            onClicked: () => {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          PhotoSearchDialog(callback: (text) {}))
                })
      ])
    ]);
    return Container(
        color: Colors.white,
        child: const Center(
          child: Text('Search for Photos using the Search menu'),
        ));
  }
}
