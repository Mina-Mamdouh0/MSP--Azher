import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:msp/models/event.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

import '../../home.dart';

String _location = "";

class EventItem extends StatelessWidget {
  final Event event;

  EventItem(
    this.event,
  );

  Widget _buildEventCard(BuildContext context, Event event) {
    return Container(
      height: 90.0,
      margin: new EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: new LinearGradient(
          colors: [AppTheme.tab1Primary, AppTheme.tab1Secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 60,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipOval(
                        child: Image.memory(
                          getImageFromAPI(event.img),
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    event.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.nearlyWhite,
                      fontSize: 18,
                      // shadows: [
                      //   Shadow(
                      //     color: AppTheme.nearlyBlack,
                      //     offset: Offset(0.8, 0.8),
                      //   )
                      //],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    convertDateTime(event.date, event.time),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            event.topics.isNotEmpty
                ? Container(
                    width: 62,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Column(
                          children: <Widget>[
                            Text(
                              event.topics.length.toString(),
                              style: TextStyle(
                                color: AppTheme.white.withOpacity(0.8),
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "Topics".toUpperCase(),
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
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, detailedEventRoute,
          arguments: [event, _location]),
      child: _buildEventCard(context, event),
    );
  }
}

convertDateTime(String date, String time) {
  // Converting date & time ex.:
  // from  ->  2020-01-27 06:59
  // to    ->  27/01/2020 - 06:59 AM
  return DateFormat("dd/MM/yyyy - hh:mm a").format(
    DateTime.parse("$date $time"),
  );
}

Future<Address> getAddress(String url) async {
  final String finalURL = await http.read(url).then((value) => value);

  /// Getting coordinates from Google Maps location [link]
  // Example: https://www.google.com/maps/place/Al-Azhar+University/@30.0591754,31.3114623,17z/data=!3m1...

  // We jsut want to get this [two doubles] ╮
  //                              ╭─────────┴─────────╮
  // [...ace/Al-Azhar+University/@30.0591754,31.3114623,17z/data=!3m1...]
  // so we split this location string into 3 parts.

  // first we split "/@"
  final part1 = finalURL.split("/@");
  // Result:
  // 0= "...ace/Al-Azhar+University" | 1= "30.0591754,31.3114623,17z/data=!3m1..."

  // then we split (1) "/data".
  final part2 = part1[1].split("/data");
  // Result:
  // 0= "30.0591754,31.3114623,17z" | 1= "=!3m1..."

  // finally we split (0) ",".
  final part3 = part2[0].split(",");
  // Result:
  // 0= "30.0591754" | 1= "31.3114623" | 2= "17z"

  /// Finally we get the coordinates,
  /// latitude (0) & longitude (1) from [part3].

  double latitude = double.parse(part3[0]);
  double longitude = double.parse(part3[1]);

  /// our geographic location [coordinates]
  final coordinates = new Coordinates(latitude, longitude);
  // getting list of possible addresses.
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);

  /// Fianlly return the first element from the [addresses] list.
  return addresses.first;
}
