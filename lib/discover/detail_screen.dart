import 'dart:io';
import 'dart:ui';
import 'package:Apexcalisthenics/discover/viewmodel/DetailViewModel.dart';
import 'package:Apexcalisthenics/models/exercise.dart';
import 'package:Apexcalisthenics/program_detail/Program_Detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'app_theme.dart';
import 'loading_widget.dart';

class DetailScreen extends StatefulWidget {
  String title;

  DetailScreen(this.title);

  @override
  _DetailScreenState createState() => _DetailScreenState(title);
}

class _DetailScreenState extends State<DetailScreen> {
  final ScrollController _scrollController = ScrollController();

  String title;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  Map<String, String> selectedItems = new Map();

  _DetailScreenState(this.title);

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailViewModel>.reactive(
      viewModelBuilder: () => DetailViewModel(),
      onModelReady: (model) => model.initialise(title.toLowerCase()),
      builder: (context, model, _) =>
          Theme(
            data: AppTheme.buildLightTheme(),
            child: Container(
              child: Scaffold(
                appBar: AppBar(
                  leading: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Platform.isAndroid
                                  ? Icons.arrow_back
                                  : Icons.arrow_back_ios,
                              color: AppTheme
                                  .buildLightTheme()
                                  .primaryColor,
                            )),
                      )),
                  backgroundColor: AppTheme
                      .buildLightTheme()
                      .backgroundColor,
                  title: Expanded(
                      child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: AppTheme
                                  .buildLightTheme()
                                  .primaryColor,
                            ),
                          ))),
                  actions: [
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                    {
                                      List<String> keys = model.tags.keys
                                          .toList();
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.only(
                                            top: 12.0),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.maxFinite,
                                                height:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    .60,
                                                child: ListView.builder(
                                                    itemCount: keys.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context,
                                                        index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(keys[index]
                                                              .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors
                                                                      .black26)),
                                                          ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: model
                                                                .tags[
                                                            keys[index]
                                                                .toString()]
                                                                .toList()
                                                                .length,
                                                            itemBuilder: (
                                                                context, i) {
                                                              String val = model
                                                                  .tags[
                                                              keys[index]
                                                                  .toString()]
                                                                  .toList()[i]
                                                                  .toString();
                                                              return CheckboxListTile(
                                                                activeColor:
                                                                Colors.black,
                                                                contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                                title: Text(
                                                                    val),
                                                                value: selectedItems
                                                                    .containsValue(
                                                                    model
                                                                        .tags[keys[
                                                                    index]
                                                                        .toString()]
                                                                        .toList()[i]
                                                                        .toString()),
                                                                onChanged: (
                                                                    bool) {
                                                                  setState(() {
                                                                    String key =
                                                                    keys[index]
                                                                        .toString();

                                                                    if (selectedItems
                                                                        .values
                                                                        .toList()
                                                                        .contains(
                                                                        val)) {
                                                                      selectedItems
                                                                          .remove(
                                                                          key);
                                                                    } else {
                                                                      selectedItems
                                                                          .putIfAbsent(
                                                                          key,
                                                                              () =>
                                                                          null);
                                                                      selectedItems[key] =
                                                                          model
                                                                              .tags[keys[
                                                                          index]
                                                                              .toString()]
                                                                              .toList()[i]
                                                                              .toString();
                                                                    }
                                                                  });
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              "RESET",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectedItems.clear();
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("APPLY",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              model.applyFilter(
                                                  title, selectedItems.values
                                                  .toList());
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  });
                            },
                          );
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
                body: model.items.length == 0
                    ? Container(
                  child: Center(
                    child: Text(
                      'No result found...',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
                    : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                primary: false,
                                padding: EdgeInsets.only(top: 15.0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.items.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: Container(
                                      height: 150.0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Card(
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
                                                tag: title +
                                                    model.items[index]['img'],
                                                child: CachedNetworkImage(
                                                  imageUrl: model.items[index]
                                                  ['img'],
                                                  placeholder:
                                                      (context, url) =>
                                                      Container(
                                                        height: 150.0,
                                                        width: 150.0,
                                                        child: LoadingWidget(
                                                          isImage: true,
                                                        ),
                                                      ),
                                                  fit: BoxFit.cover,
                                                  height: 150.0,
                                                  width: 150.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Flexible(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Hero(
                                                  tag: title +
                                                      model.items[index]
                                                      ['title'],
                                                  child: Material(
                                                    type: MaterialType
                                                        .transparency,
                                                    child: Text(
                                                      '${model
                                                          .items[index]['title']
                                                          .replaceAll(
                                                          r'\', '')}',
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color:
                                                        Theme
                                                            .of(context)
                                                            .textTheme
                                                            .title
                                                            .color,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '${model.items[index]['title']
                                                      .length < 100
                                                      ? model
                                                      .items[index]['title']
                                                      : model
                                                      .items[index]['title']
                                                      .substring(0, 100)}...'
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
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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


  Widget getAppBarUI(DetailViewModel model) {
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
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Platform.isAndroid
                    ? Icon(Icons.arrow_back)
                    : Icon(Icons.arrow_back_ios),
              ),
            ),
            Container(
              height: AppBar().preferredSize.height,
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return StatefulBuilder(builder: (context, setState) {
                      {
                        List<String> keys = model.tags.keys.toList();
                        return AlertDialog(
                          contentPadding: EdgeInsets.only(top: 12.0),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * .60,
                                  child: ListView.builder(
                                      itemCount: keys.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(keys[index].toString(),
                                                style: TextStyle(
                                                    color: Colors.black26)),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: model
                                                  .tags[keys[index].toString()]
                                                  .toList()
                                                  .length,
                                              itemBuilder: (context, i) {
                                                String val = model.tags[
                                                keys[index].toString()]
                                                    .toList()[i]
                                                    .toString();
                                                return CheckboxListTile(
                                                  activeColor: Colors.black,
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                  title: Text(val),
                                                  value: selectedItems
                                                      .containsValue(model.tags[
                                                  keys[index]
                                                      .toString()]
                                                      .toList()[i]
                                                      .toString()),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      String key = keys[index]
                                                          .toString();

                                                      selectedItems.putIfAbsent(
                                                          key, () => null);
                                                      selectedItems[key] = model
                                                          .tags[keys[index]
                                                          .toString()]
                                                          .toList()[i]
                                                          .toString();
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "Reset",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedItems.clear();
                                });
                              },
                            ),
                            FlatButton(
                              child: Text("Apply",
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (selectedItems.values
                                    .toList()
                                    .length > 0)
                                  model.applyFilter(
                                      title, selectedItems.values.toList());
                              },
                            )
                          ],
                        );
                      }
                    });
                  },
                );
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
