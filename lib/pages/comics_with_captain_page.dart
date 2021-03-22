import 'package:captain_marvel/api/marvels_api.dart';
import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/templates/comic_template.dart';
import 'package:captain_marvel/templates/shimmer_comic_template.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComicsWithCaptainMarvelPage extends StatefulWidget {
  static String routeName = "/comicsWithCaptainMarvel";
  @override
  _ComicsWithCaptainMarvelPageState createState() =>
      _ComicsWithCaptainMarvelPageState();
}

class _ComicsWithCaptainMarvelPageState
    extends State<ComicsWithCaptainMarvelPage> {
  final PagingController<int, ComicInfo> _pagingController =
      PagingController(firstPageKey: 0);

  MarvelAPI request = new MarvelAPI();

  static const _pageSize = 20;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final data =
          await request.getComicsFeaturingCaptainMarvel(pageKey, _pageSize);
      final newComics = data.results;
      final isLastPage = newComics.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newComics);
      } else {
        final nextPageKey = pageKey + newComics.length;
        _pagingController.appendPage(newComics, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
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
      body: Container(
        margin: EdgeInsets.only(
            top: dimension.height * 0.03,
            left: dimension.width * 0.04,
            right: dimension.width * 0.04),
        child: Column(
          children: [
            Container(
              child: Text(
                "Comics Featuring Captain Marvel",
                style: CustomTextStyle.titleWhite2(),
              ),
            ),
            SizedBox(
              height: dimension.height * 0.03,
            ),
            Container(
              height: dimension.height * 0.8,
              child: PagedListView<int, ComicInfo>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<ComicInfo>(
                    itemBuilder: (context, item, index) =>
                        ComicTemplate(comic: item),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                          child: Text("No comics found.",
                              style: CustomTextStyle.subTitleWhite()),
                        ),
                    firstPageProgressIndicatorBuilder: (_) => Container(
                          child: Column(
                            children: List<ShimmerComicTemplate>.filled(
                                10, ShimmerComicTemplate()),
                          ),
                        ),
                    noMoreItemsIndicatorBuilder: (_) {
                      SharedOperations.showMessage("No more comics");
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
