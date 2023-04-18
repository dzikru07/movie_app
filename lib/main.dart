import 'package:flutter/material.dart';
import 'package:movie_app/routes/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRoute _appRoute = AppRoute();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _appRoute.onGenerateRoute,
    );
  }
}
