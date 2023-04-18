import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class ErrorNetworkPage extends StatelessWidget {
  ErrorNetworkPage(
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
              UniconsLine.cloud_slash,
              size: 50,
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
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
