import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:knovator_practicle/apiAndDataBase/apiControl.dart';
import 'package:knovator_practicle/apiAndDataBase/databaseHelper.dart';
import 'package:knovator_practicle/utils/appStrings.dart';
import 'package:knovator_practicle/utils/commonWidget.dart';

import '../model/productModel.dart';

class PostViewScreenController extends GetxController {
  List<PostModel> postList = [];

  RxList viewedItems = [].obs;

  RxList itemCounts = [].obs;
  RxList<Timer?> timers = <Timer>[].obs;

  Future<List<PostModel>> fetchData() async {
    final List<ConnectivityResult> connectivityResult =
    await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var postData = await getPostData();
      if (postData.statusCode == 200) {
        postList = PostModel.fromJsonList(json.decode(postData.body));
      } else {
        CommonWidget()
            .snackBar(AppString().message, AppString().somethingWentWrong);
      }
      for (var postData in postList) {
        DatabaseHelper().insertPost(postData);
      }
    }

    postList.clear();

    postList = await DatabaseHelper().getPosts();

    itemCounts = List<int>.generate(postList.length, (index) => 40).obs;
    timers = List<Timer?>.filled(postList.length, null).obs;

    return postList;
  }

  void checkViewedItems(itemIndex) {
    if (viewedItems.contains(itemIndex)) {} else {
      viewedItems.add(itemIndex);
    }
  }

  void startCountdown(int index) {
    if (timers[index] == null && itemCounts[index] > 0) {
      timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (itemCounts[index] > 0) {
          itemCounts[index]--;
        } else {
          timer.cancel();
        }
      });
    }
  }

  void stopCountdown(int index) {
    timers[index]?.cancel();
    timers[index] = null;
  }
}
