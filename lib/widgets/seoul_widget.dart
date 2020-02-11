import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:supercharged/supercharged.dart';

class SeoulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(9.0, 7.0, 9.0, 0.0),
        child: Container(
            color: '#ebeffa'.toColor(),
            child: SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl:
                                'https://images.adsttc.com/media/images/52aa/607b/e8e4/4ee8/8f00/0048/slideshow/cityhallct107.jpg',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(height: 4.0),
                          Text('Seoul City Hall',
                              style: GoogleFonts.poppins(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                  textStyle:
                                      TextStyle(color: '#2e3440'.toColor()))),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 2.0),
                              child: Text(
                                  '  Seoul, the capital of South Korea, is a huge metropolis where modern skyscrapers, ' +
                                      'high-tech subways and pop culture meet Buddhist temples, palaces and street markets. ' +
                                      'Notable attractions include futuristic Dongdaemun Design Plaza, a convention hall with ' +
                                      'curving architecture and a rooftop park; Gyeongbokgung Palace, which once had more than ' +
                                      '7,000 rooms; and Jogyesa Temple, site of ancient locust and pine trees.',
                                  style: GoogleFonts.googleSans(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      textStyle: TextStyle(
                                          color: '#2e3440'.toColor(),
                                          letterSpacing: 1.2)))),
                          SizedBox(
                            height:
                                72.0, // just to scroll with this SingleChildScrollView
                          ),
                        ])))));
  }
}
