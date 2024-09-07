import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_practicle/controller/postViewScreenController.dart';
import 'package:knovator_practicle/utils/commonWidget.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColor.dart';

class PostDetailViewScreen extends StatefulWidget {
  int itemIndex;

  PostDetailViewScreen({super.key, required this.itemIndex});

  @override
  State<PostDetailViewScreen> createState() => _PostDetailViewScreenState();
}

class _PostDetailViewScreenState extends State<PostDetailViewScreen> {
  PostViewScreenController postViewScreenController =
      Get.put(PostViewScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(1.w),
              margin: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(color:  AppColor().amberColor),
                color:  AppColor().amberColor,
              ),
              child: PostItemView(
                id: postViewScreenController.postList[widget.itemIndex].id
                    .toString(),
                userId: postViewScreenController
                    .postList[widget.itemIndex].userId
                    .toString(),
                title: postViewScreenController.postList[widget.itemIndex].title
                    .toString(),
                body: postViewScreenController.postList[widget.itemIndex].body
                    .toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
