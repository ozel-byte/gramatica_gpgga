import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gpgga/src/Pages/home_page.dart';

class RunMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage());
  }
}
