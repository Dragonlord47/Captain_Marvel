import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/provider/app_provider.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicDetailsPage extends StatelessWidget {
  static String routeName = "/detailsPage";
  String authorString = "";
  String artistString = "";
  String editor = "";
  String charactersString = "";
  String variantString = "";
  bool isStarting = true;

  String getSeries(List<Series> series) {
    String data = "";
    for (var item in series) {
      data += item.name + ", ";
    }
    data = data.trim();
    data = data.length > 1 ? data.substring(0, data.length - 1) : data;
    return data;
  }

  void getCreatorsString(List<CreatorsItem> authors) {
    for (CreatorsItem item in authors) {
      if (item.role == Role.WRITER) {
        authorString += item.name + ", ";
      } else if (item.role == Role.COLORIST_COVER ||
          item.role == Role.PAINTER_COVER ||
          item.role == Role.PENCILER_COVER ||
          item.role == Role.PENCILLER_COVER) {
        artistString += item.name + ", ";
      } else if (item.role == Role.EDITOR) {
        editor = item.name + ", ";
      }
    }
    authorString = authorString.trim();
    artistString = artistString.trim();
    editor = editor.trim();

    authorString = authorString.length > 1
        ? authorString.substring(0, authorString.length - 1)
        : authorString;
    artistString = artistString.length > 1
        ? artistString.substring(0, artistString.length - 1)
        : artistString;
    editor =
        editor.length > 1 ? editor.substring(0, editor.length - 1) : editor;
  }

  void getCharacterString(MarvelCharacters charcters) {
    for (var item in charcters.items) {
      charactersString += item.name + ", ";
    }
    charactersString = charactersString.trim();
    charactersString = charactersString.length > 1
        ? charactersString.substring(0, charactersString.length - 1)
        : charactersString;
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    var appProvider = Provider.of<AppProvider>(context);
    getCreatorsString(appProvider.comicInFocus.creators.items);
    getCharacterString(appProvider.comicInFocus.characters);

    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 20, 20, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        title: Image.asset(
          "assets/images/marvel_logo.png",
          height: dimension.width * 0.1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              left: dimension.width * 0.04,
              right: dimension.width * 0.04,
              top: dimension.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedOperations.imageBoxWidget(
                      dimension.width * 0.3,
                      dimension.height * 0.25,
                      appProvider.comicInFocus.images.first.path +
                          "/portrait_fantastic.${appProvider.comicInFocus.images.first.extension}"),
                  SizedBox(
                    width: dimension.width * 0.04,
                  ),
                  Container(
                    width: dimension.width * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appProvider.comicInFocus.title,
                          style: CustomTextStyle.subTitleWhite2(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.006,
                        ),
                        Text(
                          "Pulished:",
                          style: CustomTextStyle.subTitleWhite(),
                        ),
                        Text(
                          SharedOperations.convertDate(DateTime.parse(
                              appProvider.comicInFocus.dates.first.date)),
                          style: CustomTextStyle.subTitleWhiteNB(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.006,
                        ),
                        Text(
                          "Authors:",
                          style: CustomTextStyle.subTitleWhite(),
                        ),
                        Text(
                          authorString,
                          style: CustomTextStyle.subTitleWhiteNB(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.006,
                        ),
                        Text(
                          "Editors:",
                          style: CustomTextStyle.subTitleWhite(),
                        ),
                        Text(
                          editor,
                          style: CustomTextStyle.subTitleWhiteNB(),
                        ),
                        SizedBox(
                          height: dimension.height * 0.006,
                        ),
                        Text(
                          "Cover Artist:",
                          style: CustomTextStyle.subTitleWhite(),
                        ),
                        Text(
                          artistString,
                          style: CustomTextStyle.subTitleWhiteNB(),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Description:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.description != null
                    ? appProvider.comicInFocus.description
                    : "No description",
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Variant Description:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.variantDescription == null
                    ? "No description"
                    : appProvider.comicInFocus.variantDescription,
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Variants:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                getSeries(appProvider.comicInFocus.variants),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Series:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.series.name,
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Characters:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                charactersString,
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Issues Number:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.issueNumber.toString(),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Price:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                "\$${appProvider.comicInFocus.prices.first.price}",
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Page count:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.pageCount.toString(),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Diamond Code:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.diamondCode,
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Digital Id:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                appProvider.comicInFocus.digitalId.toString(),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Events:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                getSeries(appProvider.comicInFocus.events.items),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
              SizedBox(
                height: dimension.height * 0.006,
              ),
              Text(
                "Modified:",
                style: CustomTextStyle.subTitleWhite(),
              ),
              Text(
                SharedOperations.convertDate(
                    DateTime.parse(appProvider.comicInFocus.modified)),
                style: CustomTextStyle.subTitleWhiteNB(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
