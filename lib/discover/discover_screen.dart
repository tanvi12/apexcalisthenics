import 'dart:ui';
import 'package:Apexcalisthenics/discover/viewmodel/HomeViewModel.dart';
import 'package:Apexcalisthenics/models/exercise.dart';
import 'package:Apexcalisthenics/program_detail/Program_Detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'app_theme.dart';
import 'detail_screen.dart';
import 'loading_widget.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, _) =>
          Theme(
            data: AppTheme.buildLightTheme(),
            child: Container(
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(
                        children: <Widget>[
                          getAppBarUI(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),

                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, i) {
                                      return productsCard(
                                          "New",
                                          model.everydayItems
                                       );
                                    },
                                  ),

                                  ListView.builder(
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.items.length,
                                    itemBuilder: (context, i) {
                                      if (!model.items.keys
                                          .toList()[i]
                                          .toString()
                                          .toLowerCase()
                                          .contains("article"))
                                        return productsCard(
                                            model.items.keys
                                                .toList()[i]
                                                .toString()
                                                .capitalize(),
                                            model.items[
                                            model.items.keys.toList()[i]]);
                                      else
                                        return productsVerticalCard(
                                            model.items.keys
                                                .toList()[i]
                                                .toString()
                                                .capitalize(),
                                            model.items[
                                            model.items.keys.toList()[i]]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme
                  .buildLightTheme()
                  .backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AppTheme
              .buildLightTheme()
              .backgroundColor,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
//                      FocusScope.of(context).requestFocus(FocusNode());
//                      Navigator.push<dynamic>(
//                        context,
//                        MaterialPageRoute<dynamic>(
//                            builder: (BuildContext context) => FiltersScreen(),
//                            fullscreenDialog: true),
//                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: AppTheme
                                    .buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget productsCard(String title, List slideList) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => DetailScreen(title),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                )
              ],
            ),
            Container(
                height: 190.0,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: slideList.length,
                  itemBuilder: (BuildContext context, int i) =>
                      GestureDetector(
                        onTap: (){
                          Exercise exercise = new Exercise(
                              title: slideList[i]['title'],
                              time: "2 weeks",
                              difficult: "Start",
                              image: slideList[i]['img'].toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return ActivityDetail(
                                  exercise: exercise,
                                  tag: 'imageHeader$i',
                                );
                              },
                            ),
                          );

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120.0,
                                  width: 120.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Hero(
                                      tag: title + slideList[i]['img'].toString(),
                                      child: CachedNetworkImage(
                                        imageUrl: slideList[i]['img'].toString(),
                                        placeholder: (context, url) =>
                                            LoadingWidget(
                                              isImage: true,
                                            ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    slideList[i]['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                )),
          ],
        ),
      ),
    );
  }

  Widget productsVerticalCard(String title, List slideList) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => DetailScreen(title),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                )
              ],
            ),
            ListView.builder(
              primary: false,
              padding: EdgeInsets.only(top: 15.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: slideList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Container(
                    height: 150.0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Hero(
                                    tag: slideList[index]['title'],
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        slideList[index]['title'],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          color: Theme
                                              .of(context)
                                              .accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '${slideList[index]['title'].length < 100
                                        ? slideList[index]['title']
                                        : slideList[index]['title'].substring(
                                        0, 100)}...'
                                        .replaceAll(r'\n', '\n')
                                        .replaceAll(r'\r', '')
                                        .replaceAll(r'\"', '"'),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Theme
                                          .of(context)
                                          .textTheme
                                          .caption
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              flex: 1,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                elevation: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: Hero(
                                    tag: slideList[index]['img'],
                                    child: CachedNetworkImage(
                                      imageUrl: slideList[index]['img'],
                                      placeholder: (context, url) =>
                                          Container(
                                            height: 100.0,
                                            width: 100.0,
                                            child: LoadingWidget(
                                              isImage: true,
                                            ),
                                          ),
                                      fit: BoxFit.cover,
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(), //
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme
            .buildLightTheme()
            .backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery
                .of(context)
                .padding
                .top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Apexcalisthenics',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(this.searchUI,);

  final Widget searchUI;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
