import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'corona_provider.dart';
import 'home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoronaProvider(),
        )
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
          title: 'Covid 19 App',
        ),
    );
  }
}
