import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:supercharged/supercharged.dart';

class SeoulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 2.0),
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
                          style: GoogleFonts.gelasio(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              textStyle: TextStyle(
                                  color: '#2e3440'.toColor(),
                                  letterSpacing: 1.2)))),
                ])));
  }
}
