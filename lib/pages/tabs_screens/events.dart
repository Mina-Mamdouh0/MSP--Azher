import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msp/models/event.dart';
import 'package:msp/pages/tabs_screens/items_widgets/event_item.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';

String _url = "https://msp-app-dashboard.herokuapp.com/api/events";

class EventsScreen extends StatefulWidget {
  const EventsScreen({
    Key key,
  }) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Future<List<Event>> events;

  @override
  void initState() {
    events = API?.getEvents(_url);
    super.initState();
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
    return FutureBuilder<List<Event>>(
      future: events,
      builder: (BuildContext context, snapshot) {
        List<Event> events = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: SpinKitWave(
                size: 50,
                duration: Duration(seconds: 2),
                color: AppTheme.tab1Secondary.withOpacity(0.5),
              ),
            );
          default:
            if (!snapshot.hasError && events.isEmpty) {
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
                    Text(
                      "No Events Yet".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyBlack.withOpacity(0.8)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Stay connected, we may have \nsome events soon!",
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
                padding: const EdgeInsets.only(bottom: 60,top: 10),
                child: ListView.builder(
                  itemCount: events.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var event = events[index];
                    // widget.animationController.forward();

                    return EventItem(
                      event,
                    );
                  },
                ),
              );
        }
      },
    );
  }
}
