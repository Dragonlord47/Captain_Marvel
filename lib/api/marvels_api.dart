import 'package:captain_marvel/models/character_json_response.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class MarvelAPI {
  String apiUrl = "https://gateway.marvel.com/v1";
  String secretKey = "5d089e05d4a9565d3a89061bb76d77546704ad3e";
  String publicKey = "8fdf008b74e6c21c005e8dcbb60ce28e";
  var ts = DateTime.now().millisecondsSinceEpoch.toString();
  String md5Hash;

  MarvelAPI() {
    var md5 = crypto.md5;

    var input = ts + secretKey + publicKey;
    md5Hash = md5.convert(utf8.encode(input)).toString();
  }

  String authorizationString() {
    return "?ts=$ts&apikey=$publicKey&hash=$md5Hash";
  }

  Future<ComicData> getComicsFeaturingCaptainMarvel(
      int offset, int pageSize) async {
    String url = apiUrl +
        "/public/comics?characters=1010338&ts=$ts&apikey=$publicKey&hash=$md5Hash&limit=$pageSize&offset=$offset";

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    print(url);

    return await http
        .get(Uri.encodeFull(url), headers: headers)
        .timeout(Duration(seconds: 15), onTimeout: () {
      return null;
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        var result = ComicData.fromJson(data['data']);
        return result;
      }
      return null;
    });
  }

  Future<ComicData> getComics(int offset, int pageSize, {String order =""}) async {
    String url = apiUrl +
        "/public/characters/1010338/comics?"+order+"ts=$ts&apikey=$publicKey&hash=$md5Hash&limit=$pageSize&offset=$offset";

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    print(url);

    return await http
        .get(Uri.encodeFull(url), headers: headers)
        .timeout(Duration(seconds: 15), onTimeout: () {
      return null;
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        var result = ComicData.fromJson(data['data']);
        return result;
      }
      return null;
    });
  }

  Future<ComicData> searchComics(String title, int offset, int pageSize) async {
    String url = apiUrl +
        "/public/comics?characters=1010338&titleStartsWith=" +
        title +
        "&ts=$ts&apikey=$publicKey&hash=$md5Hash&limit=$pageSize&offset=$offset";

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    print(url);

    return await http
        .get(Uri.encodeFull(url), headers: headers)
        .timeout(Duration(seconds: 15), onTimeout: () {
      return null;
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        var result = ComicData.fromJson(data['data']);
        return result;
      }
      return null;
    });
  }

  Future<MarvelCharacter> getCharacterData() async {
    String url = apiUrl +
        "/public/characters/1010338?ts=$ts&apikey=$publicKey&hash=$md5Hash";

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    print(url);

    return await http
        .get(Uri.encodeFull(url), headers: headers)
        .timeout(Duration(seconds: 15), onTimeout: () {
      return null;
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        var result = MarvelCharacter.fromJson(data);
        return result;
      }
      return null;
    });
  }
}
