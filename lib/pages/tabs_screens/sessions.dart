import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:msp/models/session.dart';
import 'package:msp/pages/tabs_screens/items_widgets/session_item.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';


String _url = "https://msp-app-dashboard.herokuapp.com/api/courses";

class SessionsScreen extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SessionsScreen({
    Key key,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  Future<List<Session>> sessions;

  @override
  void initState() {
    sessions = API?.getSessions(_url);

    super.initState();
  }

  @override
  void dispose() {
    // _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: getMainListViewUI(),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: API?.getSessions(_url),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: SpinKitWave(
                size: 50,
                duration: Duration(seconds: 2),
                color: AppTheme.tab2Secondary.withOpacity(0.5),
              ),
            );
          default:
            List<Session> sessions = snapshot.data;
            print(sessions.toString());

            if (!snapshot.hasError && sessions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/EmptyState.png",
                      height: 150,
                      width: 250,
                      fit: BoxFit.scaleDown,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "No Sessions Yet".toUpperCase(),
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Stay connected, we may have \nsome sessions soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.6)),
                      ),
                    )
                  ],
                ),
              );
            }
            if (!snapshot.hasData)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/NoInternetState.png",
                        height: 250, width: 250),
                    Text(
                      "No internet connection\nPlease check your internet\nconnection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyBlack.withOpacity(0.6)),
                    )
                  ],
                ),
              );
            else
              return Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 60),
                child: ListView.builder(
                  itemCount: sessions.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    Session session = sessions[index];

                    return SessionItem(session, widget.scaffoldKey);
                  },
                ),
              );
        }
      },
    );
  }
}
