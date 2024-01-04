import 'dart:convert';
import 'package:dicom_image_control_app/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isInverted = false; // 초기값 설정
  late double gammaValue;
  late int currentFrame;
  late int totalFrames;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    gammaValue = 3.0;
    currentFrame = 0;
    totalFrames = 1; // 초기값 설정 (1프레임이라고 가정)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control DCM'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageBox(MyData().gifString, isInverted, currentFrame),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Animation',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                CupertinoSlider(
                  value: gammaValue,
                  min: 0.0,
                  max: 20.0,
                  onChanged: (value) {
                    gammaValue = value;
                    setState(() {
                      gammaValue = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function
  Widget imageBox(String base64String, bool isInverted, int frameIndex) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          // 흑백반전
          this.isInverted = !this.isInverted;
        });
      },
      child: SizedBox(
        height: 700,
        width: 900,
        child: ClipRRect(
          child: PhotoView.customChild(
            enableRotation: true, // 회전 활성화
            initialScale: 1.0, // 초기 비율
            child: ColorFiltered(
              colorFilter: isInverted
                  ? const ColorFilter.mode(Colors.white, BlendMode.difference)
                  : const ColorFilter.mode(
                      Colors.transparent, BlendMode.srcOver),
              child: Image.memory(
                base64Decode(MyData().gifString),
                fit: BoxFit.fitHeight,
              ),
                // child: SvgPicture.asset('assets/output.svg'),
            ),
          ),
        ),
      ),
    );
  }
}