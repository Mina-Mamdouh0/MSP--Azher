import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:msp/services/open_url.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: CircleAvatar(
                          child: Image(
                            image: AssetImage("assets/images/msp_logo.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "MSP AZHAR ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "MicroSoft Student Partner",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                  Text(
                    "Al_Azhar University",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    height: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),

          //theme
          buildListTile(
            Icons.brightness_2,
            'Theme',
            'Light  Theme',
            Icon(Icons.arrow_forward_ios),
            () {},
          ),

          buildListTile(
            Icons.translate,
            'Translate',
            'English Language',
            Icon(Icons.arrow_forward_ios),
            () {
            },
          ),
          //Developers
          buildListTile(
            Icons.people,
            'Developers',
            'Developers Updates',
            Icon(Icons.arrow_forward_ios),
            () {},
          ),
          //web
          buildListTile(
            Icons.computer_outlined,
            'Web',
            'Go to web Site',
            Icon(Icons.arrow_forward_ios),
            () {},
          ),
          //Share
          buildListTile(
            Icons.share,
            'Share',
            'Share Application',
            Icon(Icons.arrow_forward_ios),
            () => Share.share(
              "https://play.google.com/store/apps/details?id=com.mspazhar.msp",
            ),
          ),
          //About
          buildListTile(
            Icons.account_box_outlined,
            'About',
            'About Application',
            Icon(Icons.arrow_forward_ios),
            () {},
          ),
          //feedBack
          buildListTile(
            Icons.send,
            'Send Feedback',
            'By Account G-Mail',
            Icon(Icons.arrow_forward_ios),
            () => openURL('mailto:abdo.mohamed01550@gmail.com', false),
          ),

          //Support & help
          buildListTile(
            FontAwesomeIcons.stream,
            'Support & help',
            'Submit your problem',
            Icon(Icons.arrow_forward_ios),
            () => openURL('mailto:minaelking424@gmail.com', false),
          ),

        ],
      ),
    );
  }

  ListTile buildListTile(IconData leadingIcon, String title, String subtitle,
      Widget trailingIcon, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      trailing: trailingIcon,
    );
  }
}
