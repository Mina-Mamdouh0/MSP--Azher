import 'dart:core';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/playlist.dart';
import 'package:msp/models/session.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/services/open_url.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

class SessionItem extends StatelessWidget {
  final Session session;

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SessionItem(this.session,

      this.scaffoldKey);

  Widget _buildSessionCard(BuildContext context, Session session) {
    return Container(
      height: 100.0,
      margin: new EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: new BoxDecoration(

        borderRadius: BorderRadius.circular(30.0),
        gradient: new LinearGradient(
          colors: [
            AppTheme.tab2Primary,
            AppTheme.tab2Secondary,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: FutureBuilder(
          future: API.fetchPlaylist(session, scaffoldKey),
          builder: (context, snapshot) {
            PlayList playlist = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitThreeBounce(
                size: 30,
                duration: Duration(seconds: 2),
                color: AppTheme.nearlyWhite.withOpacity(0.5),
              );
            } else if (playlist != null) {
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(
                        context, detailedSessionRoute,
                        arguments: session),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 65,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              playlist.items[0].imageDefault,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          child: AutoDirection(
                            text: session.name,
                            child: Text(
                              session.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppTheme.nearlyWhite,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    color: AppTheme.nearlyBlack,
                                    offset: Offset(0.8, 0.8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        playlist.items.isNotEmpty &&
                            playlist.items.length != null
                            ? Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  playlist.items.length
                                      .toString(),
                                  style: TextStyle(
                                    color: AppTheme.white
                                        .withOpacity(0.8),
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  "Videos".toUpperCase(),
                                  style: TextStyle(
                                    color: AppTheme.nearlyWhite,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    height: 2,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppTheme.nearlyWhite,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    color: AppTheme.nearlyBlack,
                                    offset: Offset(0.8, 0.8),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Failed to load in-app player for this playlist, open on YouTube instead?",
                              style: TextStyle(
                                color: AppTheme.tab4Secondary,
                                fontSize: 12.0,
                                shadows: [
                                  Shadow(
                                    color: AppTheme.nearlyBlack,
                                    offset: Offset(0.5, 0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () => openURL(session.courseLink,true),
                          icon: Icon(
                            FontAwesomeIcons.youtube,
                            color: AppTheme.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSessionCard(context, session);
  }
}
