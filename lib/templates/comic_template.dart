import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/pages/comic_details.dart';
import 'package:captain_marvel/provider/app_provider.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicTemplate extends StatelessWidget {
  final ComicInfo comic;

  ComicTemplate({@required this.comic});

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    AppProvider provider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: () {
        provider.comicInFocus = comic;
        Navigator.pushNamed(context, ComicDetailsPage.routeName);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: dimension.height * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SharedOperations.imageBoxWidget(
                dimension.width * 0.3,
                dimension.width * 0.3,
                comic.images.first.path +
                    "/portrait_fantastic.${comic.images.first.extension}"),
            SizedBox(
              width: dimension.width * 0.04,
            ),
            Container(
              width: dimension.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comic.title,
                    style: CustomTextStyle.subTitleWhite(),
                  ),
                  Text(
                    "Release Date: " +
                        SharedOperations.convertDate(
                            DateTime.parse(comic.dates.first.date)),
                    style: CustomTextStyle.subTitleWhite(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
