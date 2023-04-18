import 'package:flutter/cupertino.dart';

import '../../pages/detail_page/view/movie_details.dart';

class PageTransitionDetailCard extends PageRouteBuilder {
  String id;

  PageTransitionDetailCard(
    this.id,
  ) : super(
          pageBuilder: (context, animation, anotherAnimation) =>
              MovieDetailPage(id: id),
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomRight,
              child: SizeTransition(
                sizeFactor: animation,
                child: MovieDetailPage(
                  id: id,
                ),
                axisAlignment: 0,
              ),
            );
          },
        );
}
