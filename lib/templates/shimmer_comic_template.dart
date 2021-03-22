import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:captain_marvel/models/comics_json_response.dart';
import 'package:captain_marvel/utilities/shared_operations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComicTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: dimension.height * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
              baseColor: Colors.grey[600],
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Color.fromRGBO(228, 228, 228, 1),
                    )),
                height: dimension.width * 0.3,
                width: dimension.width * 0.3,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              )),
          SizedBox(
            width: dimension.width * 0.04,
          ),
          Container(
            width: dimension.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    baseColor: Colors.grey[600],
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          )),
                      height: dimension.width * 0.03,
                      //width: dimension.width * 0.3,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    )),
                SizedBox(
                  height: dimension.height * 0.01,
                ),
                Shimmer.fromColors(
                    baseColor: Colors.grey[600],
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Color.fromRGBO(228, 228, 228, 1),
                          )),
                      height: dimension.width * 0.03,
                      //width: dimension.width * 0.3,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
