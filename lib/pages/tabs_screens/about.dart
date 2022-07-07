import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/committee.dart';
import 'package:msp/pages/tabs_screens/items_widgets/committee_item.dart';
import 'package:msp/services/open_url.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    Key key,
    //this.animationController
  }) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
     {
  double topBarOpacity = 0.0;

  List<Committee> committeesList = List.generate(cTitle.length, (i) {
    return Committee(
      id: i,
      title: cTitle[i],
      image: cImage[i],
      description: cDescription[i],
      color: cColor[i],
    );
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: getMainListViewUI(),
    );
  }

  Widget getMainListViewUI() {
    return Column(children: <Widget>[
      SizedBox(height: 10,),
      Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFbb0000), Color(0xFFFF6161)],
                        stops: [0.0, 0.75],
                      ),
                    ),
                    child: IconButton(
                      tooltip: "YouTube",
                      padding: EdgeInsets.only(right: 2),
                      color: AppTheme.nearlyWhite,
                      iconSize: 18,
                      icon: Icon(FontAwesomeIcons.youtube),
                      onPressed: () => openURL(
                          "https://www.youtube.com/channel/UCnrCvhZJDpijR61BNo0rk9Q",true),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF3b5998), Color(0xFF75A1FF)],
                        stops: [0.0, 0.75],
                      ),
                    ),
                    child: IconButton(
                      tooltip: "Facebook",
                      padding: EdgeInsets.all(0),
                      color: AppTheme.nearlyWhite,
                      iconSize: 18,
                      icon: Icon(FontAwesomeIcons.facebookF),
                      onPressed: () async {
                        String fbProtocolUrl = "https://m.fb.com/AlAzharTC/";
                        String fallbackUrl =
                            "https://www.facebook.com/AlAzharTC/";
                        try {
                          bool launched =
                              await launch(fbProtocolUrl, forceSafariVC: false);

                          if (!launched) {
                            await launch(fallbackUrl, forceSafariVC: false);
                          }
                        } catch (e) {
                          await launch(fallbackUrl, forceSafariVC: false);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFbc2a8d), Color(0xFFFF6BD0)],
                        stops: [0.0, 0.75],
                      ),
                    ),
                    child: IconButton(
                      tooltip: "Instagram",
                      padding: EdgeInsets.all(0),
                      color: AppTheme.nearlyWhite,
                      iconSize: 20,
                      icon: Icon(FontAwesomeIcons.instagram),
                      onPressed: () =>
                          openURL("https://www.instagram.com/mspalazhar/",true),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF007bb6), Color(0xFF4FC7FF)],
                        stops: [0.0, 0.75],
                      ),
                    ),
                    child: IconButton(
                      tooltip: "Linkedin",
                      padding: EdgeInsets.all(0),
                      color: AppTheme.nearlyWhite,
                      iconSize: 18,
                      icon: Icon(FontAwesomeIcons.linkedinIn),
                      onPressed: () => openURL(
                          "https://www.linkedin.com/company/msp-tech-club-al-azhar-university/",true),
                    ),
                  ),
                ),
              ],
            ),
          )),
      SizedBox(
        height: 16.0,
      ),
      Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'MSP Tech Club - Al Azhar University',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppTheme.darkText,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "We are a student community program that promotes advanced technology through education, practice, and innovation. It also provides students with both technical and non-technical sessions needed which is packing their lives with high level of skills and supporting their careers with opportunities.",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Our Mission'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.8,
                          fontSize: 14,
                          color: AppTheme.darkText,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "We have a clear mission is to help the students in the campus and to be there for any kind of support needed whether it’s technical or non-technical and to help them find their most suitable career.",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.6)),
                      )
                    ],
                  ),

                ),

                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Products'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.8,
                          fontSize: 14,
                          color: AppTheme.darkText,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Technical Sessions, Soft Skills, Workshops, Courses and Competitions.",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                        'Our Community'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.8,
                          fontSize: 14,
                          color: AppTheme.darkText,
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      child: Swiper(
                        viewportFraction: 0.8,
                        scale: 0.9,
                        scrollDirection: Axis.horizontal,
                        itemCount: committeesList.length,
                        itemBuilder: (context, i) {
                          return CommitteeItem(committeesList[i]);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
