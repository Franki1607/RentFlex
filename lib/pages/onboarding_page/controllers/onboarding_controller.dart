import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OnboardingController extends GetxController {
  void navigateBack() => Get.back();

  final List pageInfos = [
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/a1/bf/2mU89ijt_o.png",
    },
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/d4/8a/iIeNlBaL_o.png",
    },
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/0b/eb/jtEbIimr_o.png",
    },
  ];

  List<PageViewModel> pages = [];

  @override
  void onInit() {
    // TODO: implement onInit
    pages = pageInfos.map((item) => buildPageModel(item)).toList();
    super.onInit();
  }


  PageViewModel buildPageModel(Map item) {
    return PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor: Colors.blue,
      title: Text(item['title'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          )
      ),
      body: Container(
        height: 250.0,
        child: Text(
            item['body'],
            textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      mainImage:Image.network(item['img']),
    );
  }
}
