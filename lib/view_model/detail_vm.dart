import 'dart:io';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class DetailVM extends GetxController{
  bool isConverted = false;
  double brightValue = 1; // 디폴트값
  List<File> images = []; // 이미지 담을 변수
  int imageIndex = 0;
  PhotoViewScaleStateController scaleStateController = PhotoViewScaleStateController();

  invertColor(){
    isConverted = !isConverted;
    brightValue = brightValue * -1;
    update();
  }



}