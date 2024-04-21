import 'package:flutter/material.dart';
import 'package:flutter_htl_charts/pages/graph.dart';
import 'package:flutter_htl_charts/pages/start.dart';
import 'package:flutter_htl_charts/provider/pathProvider.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PathProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UrlProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Sensor Data',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => Start(),
          '/graph': (context) => Graph(),
        },
      ),
    );
  }
}
