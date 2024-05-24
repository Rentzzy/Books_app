import 'package:flutter/material.dart';
import 'package:flutter_book_2/models/book_provider.dart';
import 'package:flutter_book_2/screens/bottom_nav_bar.dart';
import 'package:flutter_book_2/screens/home/home_page.dart';
import 'package:flutter_book_2/screens/home/pages/book_details.dart';
import 'package:flutter_book_2/screens/save/save_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        title: 'E-book App',
        debugShowCheckedModeBanner: false,
        routes: {
          BottomNavBar.nameRoute: (context) => const BottomNavBar(),
          HomePage.nameRoute: (context) => const HomePage(),
          BookDetail.nameRoute: (context) => const BookDetail(),
          BookmarkPage.nameRoute: (context) => BookmarkPage(),
        },
        initialRoute: BottomNavBar.nameRoute,
      ),
    );
  }
}
