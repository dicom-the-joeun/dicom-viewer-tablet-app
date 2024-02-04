import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class DetailVM extends GetxController {

  bool isMoveButtonSelected = true;
  bool isBrightSelected = false;
  bool isInvertionSelected = false;
  bool isConverted = false;
  bool isWCSelected = false;
  bool isZoomSelected = false;
  bool isRotationSelected = false;
  double brightValue = 1; // 디폴트값
  List<File> images = []; // 이미지 담을 변수
  int imageIndex = 1;
  int windowCenterIndex = 1;
  PhotoViewScaleStateController scaleStateController =
      PhotoViewScaleStateController();

  invertColor() {
    isConverted = !isConverted;
    brightValue = brightValue * -1;
    _clickInvertionButton();
    update();
  }

  clickBrightnessButton() {
    isBrightSelected = !isBrightSelected;
    isWCSelected = false;
    update();
  }

  clickWCButton() {
    isWCSelected = !isWCSelected;
    isBrightSelected = false;
    update();
  }

  _clickInvertionButton() {
    isInvertionSelected = !isInvertionSelected;
    update();
  }

  clickZoomButton() {
    if (isZoomSelected) {
      isZoomSelected = !isZoomSelected;
      isRotationSelected = false;
    } else {
      isZoomSelected = !isZoomSelected;
    }

    update();
  }

  clickRotationButton() {
    if (isRotationSelected) {
      isZoomSelected = true;
      isRotationSelected = !isRotationSelected;
    } else {
      if (isZoomSelected) {
        isRotationSelected = !isRotationSelected;
      }
    }
    update();
  }

  changeImage(DragUpdateDetails details, int maxIndex) {
    
    if (details.delta.dx > 1 && imageIndex < maxIndex) {
      print("오른쪽");
      imageIndex++;
      update();
    } else if (details.delta.dx < -1 && imageIndex > 1) {
      print('왼쪽');
      imageIndex--;
      update();
    }
  }
}
