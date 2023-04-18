import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../style/text.dart';

class ErrorApiPage extends StatelessWidget {
  ErrorApiPage(
      {super.key,
      required this.message,
      required this.height,
      required this.width});

  String message;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height / 3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              UniconsLine.annoyed,
              size: 120,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: width / 2,
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: navigationTextHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
