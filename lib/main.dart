import 'package:captain_marvel/pages/comic_details.dart';
import 'package:captain_marvel/pages/comics_page.dart';
import 'package:captain_marvel/pages/comics_with_captain_page.dart';
import 'package:captain_marvel/pages/home_page.dart';
import 'package:captain_marvel/pages/search_page.dart';
import 'package:captain_marvel/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
    child: CaptainMarvelApp(),
  ));
}

class CaptainMarvelApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Captain Marvel',
      routes: {
        SearchPage.routeName: (ctx) => SearchPage(),
        ComicsPage.routeName: (ctx) => ComicsPage(),
        ComicDetailsPage.routeName: (ctx) => ComicDetailsPage(),
        ComicsWithCaptainMarvelPage.routeName: (ctx) =>
            ComicsWithCaptainMarvelPage()
      },
      theme: ThemeData(
        fontFamily: "RobotoCondensed",
     
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
