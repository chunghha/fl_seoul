import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:supercharged/supercharged.dart';

class DongdaemmonWidget extends StatelessWidget {
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
                        'https://st3.depositphotos.com/6193152/15484/v/600/depositphotos_154841576-stock-video-4k-timelapse-of-the-dongdaemun.jpg',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 4.0),
                  Text('Dongdaemoon Plaza',
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
                          '  The Dongdaemun Design Plaza, also called the DDP, is a major urban development landmark in Seoul, ' +
                              'South Korea designed by Zaha Hadid and Samoo, with a distinctively neofuturistic design characterized ' +
                              'by the powerful, curving forms of elongated structures.',
                          style: GoogleFonts.openSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              textStyle: TextStyle(
                                  color: '#2e3440'.toColor(),
                                  letterSpacing: 1.2)))),
                ])));
  }
}
