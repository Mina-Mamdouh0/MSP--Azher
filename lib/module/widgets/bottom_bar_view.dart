import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/tabIcon_data.dart';
import 'package:msp/ui/app_theme.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PhysicalShape(
            color: AppTheme.white,
            elevation: 16.0,
            clipper: TabClipper(radius: 38.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            minWidth: 60,
                            onPressed: () {
                              setState(() {
                                index = 0;
                                widget.changeIndex(0);
                              });
                            },
                            child: Column(children: [
                              Icon(
                                Icons.calendar_today,
                                color: (index == 0)
                                    ? Color(0xFF0077b5)
                                    : Color(0xFF86888a),
                                size: 25,
                              ),
                              Text(
                                "Events",
                                style: TextStyle(
                                    color: (index == 0)
                                        ? Color(0xFF0077b5)
                                        : Color(0xFF86888a),
                                    fontSize: 13),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            minWidth: 60,
                            onPressed: () {
                              setState(() {
                                index = 1;
                                widget.changeIndex(1);
                              });
                            },
                            child: Column(children: [
                              Icon(
                                Icons.school_rounded,
                                color: (index == 1)
                                    ? Color(0xFF0077b5)
                                    : Color(0xFF86888a),
                                size: 25,
                              ),
                              Text(
                                "Sessions",
                                style: TextStyle(
                                    color: (index == 1)
                                        ? Color(0xFF0077b5)
                                        : Color(0xFF86888a),
                                    fontSize: 12),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(width: 50),
                        Expanded(
                          child: MaterialButton(
                            minWidth: 60,
                            onPressed: () {
                              setState(() {
                                index = 2;
                                widget.changeIndex(2);
                              });
                            },
                            child: Column(children: [
                              Icon(
                                Icons.auto_fix_high,
                                color: (index == 2)
                                    ? Color(0xFF0077b5)
                                    : Color(0xFF86888a),
                                size: 25,
                              ),
                              Text(
                                "Projects",
                                style: TextStyle(
                                    color: (index == 2)
                                        ? Color(0xFF0077b5)
                                        : Color(0xFF86888a),
                                    fontSize: 13),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            minWidth: 60,
                            onPressed: () {
                              setState(() {
                                index = 3;
                                widget.changeIndex(3);
                              });
                            },
                            child: Column(children: [
                              Icon(
                                FontAwesomeIcons.addressCard,
                                color: (index == 3)
                                    ? Color(0xFF0077b5)
                                    : Color(0xFF86888a),
                                size: 25,
                              ),
                              Text(
                                "About",
                                style: TextStyle(
                                    color: (index == 3)
                                        ? Color(0xFF0077b5)
                                        : Color(0xFF86888a),
                                    fontSize: 13),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          )
        ]);
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons(
      {Key key, this.selectedIndex, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  final int selectedIndex;
  final TabIconData tabIconData;
  final Function removeAllSelect;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  Color circlesColor = AppTheme.nearlyDarkBlue;

  @override
  void initState() {
    switch (widget.selectedIndex) {
      case 0:
        circlesColor = AppTheme.tab1Primary;
        break;
      case 1:
        circlesColor = AppTheme.tab2Primary;
        break;
      case 2:
        circlesColor = AppTheme.tab3Primary;
        break;
      case 3:
        circlesColor = AppTheme.tab4Primary;
        break;
    }

    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.6, end: 0.7).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController,
                          curve:
                              Interval(0.1, 1.0, curve: Curves.fastOutSlowIn))),
                  child: Image.asset(
                    widget.tabIconData.isSelected
                        ? widget.tabIconData.selectedImagePath
                        : widget.tabIconData.imagePath,
                    scale: 1,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 6,
                  right: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.2, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: circlesColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.5, 0.8,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: circlesColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 10,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController,
                            curve: Interval(0.5, 0.6,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: circlesColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
