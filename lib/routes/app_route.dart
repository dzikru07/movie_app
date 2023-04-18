import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';

import '../component/bottom_bar/bottom_nav.dart';
import '../component/transition/detail_page_transition.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case '/card/detail':
        return PageTransitionDetailCard(args.toString());
      default:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
    }
  }
}
