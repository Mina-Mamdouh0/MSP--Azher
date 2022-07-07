import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem(
    this.project,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, detailedProjectRoute,
          arguments: this.project),
      child: SizedBox(
        height: 280,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: new LinearGradient(
                          colors: [
                            AppTheme.tab3Primary,
                            AppTheme.tab3Secondary
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, right: 10, left: 10),
                                  child: AutoDirection(
                                    text: project.title,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: MemoryImage(
                                                  getImageFromAPI(
                                                      project.image),
                                                ))),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            project.title,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              letterSpacing: 0.27,
                                              color: AppTheme.nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 16, right: 10, bottom: 8),
                                  child: AutoDirection(
                                    text: project.description,
                                    child: Text(
                                      project.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 12,
                                        letterSpacing: 0.27,
                                        color: AppTheme.nearlyWhite
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
