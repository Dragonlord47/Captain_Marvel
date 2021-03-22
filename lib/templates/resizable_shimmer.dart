import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ResizableShimmer extends StatelessWidget {
  final double height;
  final double width;
  ResizableShimmer({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Container(
      color: Color.fromRGBO(24, 20, 20, 1),
      child: Container(
        margin: EdgeInsets.only(bottom: dimension.height * 0.005),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[600],
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Color.fromRGBO(228, 228, 228, 1),
                  )),
              height: height,
              width: width,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            )),
      ),
    );
  }
}
