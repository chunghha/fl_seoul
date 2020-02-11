import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:supercharged/supercharged.dart';

class LotteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(9.0, 7.0, 9.0, 0.0),
        child: Container(
            color: '#ebeffa'.toColor(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        'https://www.globalcovenantofmayors.org/wp-content/uploads/2019/02/lotte-world-tower-1791802_1280.jpg',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 4.0),
                  Text('Lotte Tower',
                      style: GoogleFonts.poppins(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          textStyle: TextStyle(color: '#2e3440'.toColor()))),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 2.0),
                      child: Text(
                          '  Lotte World Tower is a 123-floor, 555-metre supertall skyscraper located in Seoul, ' +
                              'South Korea. It opened to the public on April 11, 2017 and is currently the tallest ' +
                              'building in South Korea, and is the 6th tallest building in the world.',
                          style: GoogleFonts.googleSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              textStyle: TextStyle(
                                  color: '#2e3440'.toColor(),
                                  letterSpacing: 1.2)))),
                ])));
  }
}
