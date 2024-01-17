import 'dart:io';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

class ImageSliderTest extends StatefulWidget {
  const ImageSliderTest({Key? key}) : super(key: key);

  @override
  State<ImageSliderTest> createState() => ImageSliderTestState();
}

class ImageSliderTestState extends State<ImageSliderTest> {
  List<File> images = [];
  late Directory directory;
  late double gamma;
  late bool isConverted; // 반전 눌렀는지
  int _index = 10;
  late PhotoViewScaleStateController scaleStateController;

  @override
  void initState() {
    super.initState();
    // images = fetchImagesFromDirectory(); // FutureBuilder 대신 여기서 이미지를 초기에 가져옴
    print(images.length);
    gamma = 1.0;
    isConverted = false;
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'image_slider_test'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async =>
                    images = await fetchImagesFromDirectory(),
                child: const Text('images get from directory')),
            SizedBox(
              height: 800,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix([
                  gamma, 0, 0, 0, !isConverted ? 0 : 255, //R
                  0, gamma, 0, 0, !isConverted ? 0 : 255, //G
                  0, 0, gamma, 0, !isConverted ? 0 : 255, //B
                  0, 0, 0, 1, 0, //A
                ]),
                child: PhotoView(
                  enableRotation: true,
                  scaleStateController: scaleStateController,
                  filterQuality: FilterQuality.high,
                  imageProvider: AssetImage(
                      '/Users/msk/Library/Developer/CoreSimulator/Devices/82AA6129-900A-4E56-BA3B-9B6DDE681450/data/Containers/Data/Application/389EB078-AC4B-4ABC-8FC4-844F571B6693/Documents/20extracted/20/${(_index).toInt().toString().padLeft(3, '0')}img.png'),
                ),
              ),
            ),
            SizedBox(
              width: 1000,
              child: CupertinoSlider(
                value: _index.toDouble(),
                max: 20.0,
                divisions: 20,
                onChanged: (double value) {
                  setState(() {
                    _index = value.toInt();
                  });
                },
              ),
            ),
            SizedBox(
              width: 1000,
              child: CupertinoSlider(
                value: gamma,
                min: -5,
                max: 5.0,
                divisions: 100,
                onChanged: (double value) {
                  setState(() {
                    gamma = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                gamma = gamma * -1;
                isConverted = !isConverted;
                setState(() {});
              },
              child: Text('반전'),
            ),
          ],
        ),
      ),
    );
  }

  //function
  // 이미지를 초기에 가져오는 함수
  Future<List<File>> fetchImagesFromDirectory() async {
    List<File> images = [];
    final directory = await getApplicationDocumentsDirectory();
    Directory imagesDirectory = Directory('${directory.path}/20extracted/20');

    if (imagesDirectory.existsSync()) {
      List<FileSystemEntity> files = imagesDirectory.listSync();

      for (var file in files) {
        if (file is File && file.path.toLowerCase().endsWith('.png')) {
          images.add(file);
        }
      }

      setState(() {});
    }
    return images;
  }

  void goBack() {
    scaleStateController.scaleState = PhotoViewScaleState.initial;
  }
}//ENd



