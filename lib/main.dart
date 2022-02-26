import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:menubar/menubar.dart' as menubar;
import 'package:provider/provider.dart';
import 'package:windows_demo/providers/photos.dart';
import 'package:windows_demo/widgets/photo_display.dart';
import 'package:windows_demo/widgets/photo_search_dialog.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (ctx) => Photos())],
        child: const FluentApp(
            debugShowCheckedModeBanner: false,
            title: 'Image Searcher',
            home: AppHome(
              title: 'Image Searh',
            )));
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
                      builder: (context) => PhotoSearchDialog(callback: (text) {
                            Provider.of<Photos>(context, listen: false)
                                .search(text);
                          }))
                })
      ])
    ]);
    return Container(color: Colors.white, child: const PhotoDisplay());
  }
}
