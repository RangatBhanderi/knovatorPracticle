import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_practicle/controller/postViewScreenController.dart';
import 'package:knovator_practicle/utils/appStrings.dart';
import 'package:sizer/sizer.dart';

import 'appColor.dart'; // For using Obx

class CommonWidget {
  void snackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: Colors.white, backgroundColor: Colors.black12);
  }

  Widget commonText(
      {String? title, double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      title.toString(),
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget circularLoader() {
    return Center(
        child: CircularProgressIndicator(
      color: AppColor().amberColor,
    ));
  }

  Widget centerText(
    String title,
  ) {
    return Center(child: commonText(title: title));
  }

  Widget itemWithTitle(String itemTitle, String itemName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget().commonText(
            title: itemTitle, fontSize: 12.sp, fontWeight: FontWeight.w500),
        Flexible(
            child: CommonWidget().commonText(title: itemName, fontSize: 12.sp)),
      ],
    );
  }
}

class PostItemView extends StatefulWidget {
  final String? id;
  final String? userId;
  final String? title;
  final String? body;
  final VoidCallback? onPressed;

  PostItemView({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.onPressed,
  });

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  PostViewScreenController postViewScreenController =
      Get.put(PostViewScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: CommonWidget()
                .itemWithTitle(AppString().id.toString(), widget.id ?? ''),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: CommonWidget().itemWithTitle(
                AppString().userId.toString(), widget.userId ?? ''),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: CommonWidget().itemWithTitle(
                AppString().title.toString(), widget.title ?? ''),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: CommonWidget()
                .itemWithTitle(AppString().body.toString(), widget.body ?? ''),
          ),
        ],
      ),
    );
  }
}
