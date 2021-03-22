import 'package:captain_marvel/api/marvels_api.dart';
import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/templates/comic_template.dart';
import 'package:captain_marvel/templates/shimmer_comic_template.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:captain_marvel/widgets/Icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchPage extends StatefulWidget {
  static String routeName = "/searchPage";
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PagingController<int, ComicInfo> _pagingController =
      PagingController(firstPageKey: 0);
  TextEditingController searchCtrl = new TextEditingController();
  bool searchState = false;
  bool hasSearchOccured = false;
  MarvelAPI request = new MarvelAPI();

  static const _pageSize = 20;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final data =
          await request.searchComics(searchCtrl.text, pageKey, _pageSize);

      final newComics = data.results;
      final isLastPage = newComics.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newComics);
        print("isLastPage");
      } else {
        final nextPageKey = pageKey + newComics.length;
        _pagingController.appendPage(newComics, nextPageKey);
        print("NotLastPage");
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void searchOperation() async {
    setState(() {
      hasSearchOccured = true;
    });
    _pagingController.itemList = null;
    _pagingController.nextPageKey = 0;
    _pagingController.addStatusListener((status) {});
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: dimension.height * 0.03,
            left: dimension.width * 0.04,
            right: dimension.width * 0.04,
          ),
          child: Column(
            children: [
              IconTextField(
                textHint: "Search comics",
                icon: null,
                searchOperation: searchOperation,
                controller: searchCtrl,
                isSecure: false,
              ),
              SizedBox(
                height: dimension.height * 0.01,
              ),
              //!searchState ?
              Container(
                height: dimension.height * 0.75,
                child: !hasSearchOccured
                    ? Center(
                        child: Image.asset(
                          "assets/images/captain_marvel.png",
                          width: dimension.width * 0.5,
                          height: dimension.width * 0.5,
                          fit: BoxFit.contain,
                        ),
                      )
                    : PagedListView<int, ComicInfo>(
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
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
