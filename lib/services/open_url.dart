import 'package:url_launcher/url_launcher.dart';

void openURL(String url,bool forceWebView) async {
  String mUrl = url;
  if (await canLaunch(mUrl)) {
    await launch(mUrl,
        enableJavaScript: true,
        forceWebView: forceWebView
       );
  } else {
    throw 'Could not launch $mUrl';
  }
}