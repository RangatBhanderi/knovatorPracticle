import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_practicle/controller/postViewScreenController.dart';
import 'package:knovator_practicle/model/productModel.dart';
import 'package:knovator_practicle/utils/appColor.dart';
import 'package:knovator_practicle/utils/appStrings.dart';
import 'package:knovator_practicle/utils/commonWidget.dart';
import 'package:knovator_practicle/view/postDetailViewScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostViewScreen extends StatefulWidget {
  const PostViewScreen({super.key});

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  PostViewScreenController postViewScreenController =
      Get.put(PostViewScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: postViewScreenController.fetchData(),
          builder: (buildContext, AsyncSnapshot<List<PostModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CommonWidget().circularLoader();
            } else if (snapshot.hasError) {
              return CommonWidget().centerText(
                AppString().somethingWentWrong,
              );
            } else if (snapshot.data?.length == 0) {
              return CommonWidget().centerText(
                AppString().noDataFound,
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return VisibilityDetector(
                      key: Key('$index'),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleFraction > 0) {
                          postViewScreenController.startCountdown(index);
                        } else {
                          postViewScreenController.stopCountdown(index);
                        }
                      },
                      child: Obx(() {
                        return Container(
                          padding: EdgeInsets.all(1.w),
                          margin: EdgeInsets.all(1.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            border: Border.all(color: AppColor().amberColor),
                            color: postViewScreenController.viewedItems.value
                                    .contains(index)
                                ? AppColor().whiteColor
                                : AppColor().amberColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: PostItemView(
                                  id: snapshot.data?[index].id.toString(),
                                  userId:
                                      snapshot.data?[index].userId.toString(),
                                  title: snapshot.data?[index].title.toString(),
                                  body: snapshot.data?[index].body.toString(),
                                  onPressed: () async {
                                    postViewScreenController
                                        .checkViewedItems(index);
                                    Get.to(
                                        PostDetailViewScreen(itemIndex: index));
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 4.w,
                                  ),
                                  Obx(() {
                                    return CommonWidget().commonText(
                                        title: postViewScreenController
                                            .itemCounts[index]
                                            .toString(),
                                        fontSize: 10.sp);
                                  }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
