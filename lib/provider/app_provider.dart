import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  ComicInfo _comicInFocus;
  List<ComicInfo> _homePageComics;

  ComicInfo get comicInFocus => _comicInFocus;
  List<ComicInfo> get homePageComics => _homePageComics;

  set comicInFocus(ComicInfo comic) {
    _comicInFocus = comic;
    notifyListeners();
  }

  set homePageComics(List<ComicInfo> comics) {
    _homePageComics = comics;
    notifyListeners();
  }
}
