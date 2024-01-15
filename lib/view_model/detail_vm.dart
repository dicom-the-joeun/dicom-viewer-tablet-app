import 'package:get/get.dart';

class DetailVM extends GetxController{
  bool isConverted = false;

  convertColor(){
    isConverted = !isConverted;
    update();
  }



}