import 'package:captain_marvel/api/marvels_api.dart';
import 'package:captain_marvel/custom/custom_clip_path.dart';
import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/character_json_response.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/pages/comics_page.dart';
import 'package:captain_marvel/pages/comics_with_captain_page.dart';
import 'package:captain_marvel/pages/search_page.dart';
import 'package:captain_marvel/templates/comic_template.dart';
import 'package:captain_marvel/templates/drawer_template.dart';
import 'package:captain_marvel/templates/resizable_shimmer.dart';
import 'package:captain_marvel/templates/shimmer_comic_template.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController listCtrl = new ScrollController();
  ScrollController scrollCtrl = new ScrollController();

  MarvelAPI request = new MarvelAPI();
  ComicData comics;
  bool isComicsLoading = false;
  bool isStarting = false;
  bool isLoadingContent = true;
  bool isAtEdge = false;
  Size dimension;
  List<Widget> widgetList;
  List<Widget> shimmerList;
  List<String> nameList;

  CharacterData captainMarvel;

  void getComics() async {
    await request.getComics(0, 4).then((response) {
      setState(() {
        comics = response;
        widgetList = comics.results.map((comic) {
          return ComicTemplate(
            comic: comic,
          );
        }).toList();

        isComicsLoading = true;
      });
    });
  }

  void getData() async {
    await request.getCharacterData().then((response) {
      setState(() {
        captainMarvel = response.data.results.first;
        isLoadingContent = false;
        nameList = captainMarvel.name.split("(");
        nameList[1] = nameList[1].replaceAll(")", "");
        nameList[0] = nameList[0].trim();
        nameList[1] = nameList[1].trim();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //getData();
    getComics();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    dimension = MediaQuery.of(context).size;
    if (isStarting == true) {
      isStarting = false;
    }

    return Scaffold(
        key: _drawerKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(32, 32, 32, 1),
          leading: InkWell(
              onTap: () {
                _drawerKey.currentState.openDrawer();
              },
              child: Icon(MdiIcons.menu)),
          title: Image.asset(
            "assets/images/marvel_logo.png",
            height: dimension.width * 0.1,
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              child: Container(
                  margin: EdgeInsets.only(right: dimension.width * 0.04),
                  child: Icon(MdiIcons.magnify)),
            )
          ],
        ),
        body: SingleChildScrollView(
          controller: scrollCtrl,
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/home_image.jpg",
                  fit: BoxFit.cover,
                  height: dimension.height * 0.35,
                ),

                Stack(
                  children: [
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(24, 20, 20, 1),
                        ),
                        width: double.infinity,
                        height: dimension.height * 0.25,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: dimension.height * 0.03,
                          left: dimension.width * 0.04,
                          right: dimension.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CAROL DANVERS",
                            style: CustomTextStyle.subTitleWhite(),
                          ),
                          Text(
                            "CAPTAIN MARVEL",
                            style: CustomTextStyle.titleWhite(),
                          ),
                          Text(
                            "Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.",
                            style: CustomTextStyle.bodyBoldWhite(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: dimension.height * 0.03,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: dimension.width * 0.04,
                      right: dimension.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "FOLLOW",
                        style: CustomTextStyle.bodyType2Silver(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              SharedOperations.launchURL(
                                  "https://www.facebook.com/CaptainMarvelOfficial");
                            },
                            child: Icon(
                              MdiIcons.facebook,
                              color: CustomTextStyle.silver(),
                            ),
                          ),
                          SizedBox(
                            width: dimension.width * 0.05,
                          ),
                          InkWell(
                            onTap: () {
                              SharedOperations.launchURL(
                                  "https://twitter.com/captainmarvel");
                            },
                            child: Icon(
                              MdiIcons.twitter,
                              color: CustomTextStyle.silver(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: dimension.height * 0.015,
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: dimension.height * 0.08,
                ),
                Container(
                  height: dimension.height * 0.94,
                  width: double.infinity,
                  color: Color.fromRGBO(24, 20, 20, 1),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: dimension.height * 0.03,
                      left: dimension.width * 0.04,
                      right: dimension.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CAPTAIN MARVEL'S COMICS",
                          style: CustomTextStyle.titleWhite(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.03,
                        ),
                        !isComicsLoading
                            ? Container(
                                height: dimension.height * 0.65,
                                child: AbsorbPointer(
                                  absorbing: isAtEdge,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    controller: listCtrl,
                                    children: List<ShimmerComicTemplate>.filled(
                                        4, ShimmerComicTemplate()),
                                  ),
                                ),
                              )
                            : comics == null
                                ? Container(
                                    height: dimension.height * 0.8,
                                    child: Text("No comics"),
                                  )
                                : AbsorbPointer(
                                    absorbing: isAtEdge,
                                    child: Container(
                                      height: dimension.height * 0.8,
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        controller: listCtrl,
                                        children: widgetList,
                                      ),
                                    ),
                                  ),
                        // SizedBox(
                        //   height: dimension.height * 0.03,
                        // ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: dimension.height * 0.08,
                // ),
                Container(
                  color: Color.fromRGBO(24, 20, 20, 1),
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: dimension.width * 0.04,
                      right: dimension.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: dimension.height * 0.04,
                        ),
                        Text(
                          "FOLLOW MARVEL",
                          style: CustomTextStyle.subTitleWhite(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://www.facebook.com/Marvel/");
                              },
                              child: Icon(MdiIcons.facebook,
                                  color: CustomTextStyle.silver()),
                            ),
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://twitter.com/marvel");
                              },
                              child: Icon(MdiIcons.twitter,
                                  color: CustomTextStyle.silver()),
                            ),
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://www.instagram.com/marvel/");
                              },
                              child: Icon(MdiIcons.instagram,
                                  color: CustomTextStyle.silver()),
                            ),
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://www.youtube.com/marvel");
                              },
                              child: Icon(MdiIcons.youtube,
                                  color: CustomTextStyle.silver()),
                            ),
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://www.snapchat.com/add/marvelhq");
                              },
                              child: Icon(MdiIcons.snapchat,
                                  color: CustomTextStyle.silver()),
                            ),
                            InkWell(
                              onTap: () {
                                SharedOperations.launchURL(
                                    "https://www.pinterest.com/marvelofficial/");
                              },
                              child: Icon(MdiIcons.pinterest,
                                  color: CustomTextStyle.silver()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dimension.height * 0.08,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromRGBO(24, 20, 20, 1),
            child: Container(
              margin: EdgeInsets.only(
                top: dimension.height * 0.05,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: dimension.width * 0.03,
                      ),
                      alignment: Alignment.topLeft,
                      child: Icon(MdiIcons.close, color: Colors.white),
                    ),
                  ),
                  // InkWell(onTap: () {
                  //   Navigator.pushNamed(context, )
                  // }, child: DrawerTemplate(item: "Home")),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ComicsPage.routeName);
                      },
                      child: DrawerTemplate(item: "Captain Marvel's Comics")),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ComicsWithCaptainMarvelPage.routeName);
                      },
                      child:
                          DrawerTemplate(item: "Comics with Captain Marvel's"))
                ],
              ),
            ),
          ),
        ));
  }
}
