import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class SharedOperations {
  static Widget imageBoxWidget(double width, double height, String imageUrl) {
    return FadeInImage.assetNetwork(
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      width: width,
      height: height,
      image: imageUrl,
      // placeholder: 'Assets/images/video_loader.gif',
      placeholder: 'assets/images/img_placeholder.png',
      placeholderCacheHeight: width.round(),
      placeholderCacheWidth: height.round(),
      fit: BoxFit.fitWidth,
    );
  }

  static String convertDate(DateTime date) {
    String dateString = "";

    switch (date.month) {
      case 1:
        dateString += "January";
        break;
      case 2:
        dateString += "February";
        break;
      case 3:
        dateString += "March";
        break;
      case 4:
        dateString += "April";
        break;
      case 5:
        dateString += "May";
        break;
      case 6:
        dateString += "June";
        break;
      case 7:
        dateString += "July";
        break;
      case 8:
        dateString += "August";
        break;
      case 9:
        dateString += "September";
        break;
      case 10:
        dateString += "October";
        break;
      case 11:
        dateString += "November";
        break;
      case 12:
        dateString += "December";
        break;
    }
    return dateString += " ${date.day}, ${date.year}";
  }

  static void showMessage(String message) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[500],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // static void showToast(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showMessage("Could not open url");
    }
  }
}
