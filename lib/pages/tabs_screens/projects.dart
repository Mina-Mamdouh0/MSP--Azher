import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/tabs_screens/items_widgets/project_item.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';

String _url = "https://msp-app-dashboard.herokuapp.com/api/projects/";

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    Key key,
  }) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String category = "mobile";

  Future<List<Project>> projects;
  CategoryType categoryType = CategoryType.mobile;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
        child: getMainListViewUI(),
    );
  }

  Widget getMainListViewUI() {

    List<Widget> mi=[
      getButtonUI(
          CategoryType.mobile, categoryType == CategoryType.mobile),
      Container(
        height: 40,
        width: 1,
        color: Colors.black26,
      ),
      getButtonUI(CategoryType.web, categoryType == CategoryType.web),
      Container(
        height: 40,
        width: 1,
        color: Colors.black26,
      ),
      getButtonUI(
            CategoryType.media, categoryType == CategoryType.media),
      Container(
        height: 40,
        width: 1,
        color: Colors.black26,
      ),
      getButtonUI(CategoryType.Techoons, categoryType == CategoryType.Techoons),
      Container(
        height: 40,
        width: 1,
        color: Colors.black26,
      ),
      getButtonUI(CategoryType.autonomous,categoryType == CategoryType.autonomous),
      Container(
        height: 40,
        width: 1,
        color: Colors.black26,
      ),
    ];


    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 40,
          //width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context,index)=>
            mi[index],
          ),

        ),

        // const SizedBox(height: 16),
        Container(
          height: MediaQuery.of(context).size.height - 130,
          child: FutureBuilder<List<Project>>(
              future: projects,
              builder: (context, snapshot) {
                List<Project> projects = snapshot.data;

                if (snapshot.connectionState != ConnectionState.done) {
                  return new Center(
                    child: SpinKitWave(
                      size: 50,
                      duration: Duration(seconds: 2),
                      color: AppTheme.tab1Secondary.withOpacity(0.5),
                    ),
                  );
                } else {
                  if (!snapshot.hasError && projects.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/images/EmptyState.png",
                              height: 150, width: 250),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No Projects Yet".toUpperCase(),
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
                              "Stay connected, we may have \nsome projects soon!",
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
                              height: 150, width: 250),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No internet connection\nPlease check your internet\nconnection",
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
                  else
                    return DraggableScrollableActuator(
                      child: GridView(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 32, left: 16, right: 16),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          projects.length,
                          (int index) {
                            return ProjectItem(
                              projects[index],
                            );
                          },
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 32.0,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    );
                  //);
                }
              }),
        )
      ],
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    IconData icon;
    if (categoryTypeData == CategoryType.mobile) {
      txt = 'Mobile';
      icon=FontAwesomeIcons.mobile;
    } else if (categoryTypeData == CategoryType.web) {
      txt = 'Web';
      icon=FontAwesomeIcons.laptopCode;
    } else if (categoryTypeData == CategoryType.media) {
      txt = 'Media';
      icon=FontAwesomeIcons.keyboard;
    } else if (categoryTypeData == CategoryType.Techoons) {
      txt = 'Techoons';
      icon=FontAwesomeIcons.java;
    } else if (categoryTypeData == CategoryType.autonomous) {
      txt = 'Independent';
      icon=FontAwesomeIcons.tasks;
    }
    return InkWell(
      splashColor: Colors.white24,
      onTap: () {
        setState(() {
          categoryType = categoryTypeData;
          if (categoryType == CategoryType.mobile) {
            setState(() {
              category = 'mobile';
              projects = API.getProjects(_url, category);
            });
          } else if (categoryType == CategoryType.web) {
            setState(() {
              category = 'web';
              projects = API.getProjects(_url, category);
            });
          } else if (categoryType == CategoryType.media) {
            setState(() {
              category = 'media';
              projects = API.getProjects(_url, category);
            });
          } else if (categoryType == CategoryType.Techoons) {
            setState(() {
              category = 'it';
              projects = API.getProjects(_url, category);
            });
          } else if (categoryType == CategoryType.autonomous) {
            setState(() {
              category = 'autonomous';
              projects = API.getProjects(_url, category);
            });
          }
        });
      },
      child:
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon,),
            SizedBox(width: 10,),
             isSelected?
             Text(
               txt.toUpperCase(),
               textAlign: TextAlign.left,
               style: TextStyle(
                 fontSize: 14,
               letterSpacing: 0.27,
                 color: isSelected
                   ? Colors.black
                     : AppTheme.tab3Secondary,
              ),
            )
                :Container(),
          ],
        ),
      ),
    );
  }

}

enum CategoryType { mobile, web, media, Techoons, autonomous }
