import 'package:flutter_book_2/themes.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'User Page',
          style: semiBoldText20,
        ),
      ),
    );
  }
}
