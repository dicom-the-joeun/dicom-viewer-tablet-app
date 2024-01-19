import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/toolbar_button.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/static/search_data.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../view_model/detail_vm.dart';

class DetailView extends StatelessWidget {
  final int studyKey;
  final SeriesTab series;
  const DetailView({super.key, required this.studyKey, required this.series});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailVM>(
      init: DetailVM(),
      builder: (detailVM) => Scaffold(
        appBar: MyAppBar(
          title: 'Detail View',
          bottom: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToolbarButton(
                  icon: Icons.invert_colors,
                  label: '반전',
                  onPressed: () => detailVM.invertColor(),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 500,
                child: ClipRRect(
                  child: SizedBox(
                    height: 500,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.matrix([
                        detailVM.brightValue, 0.0, 0.0, 0.0,
                        detailVM.isConverted ? 255 : 0,
                        0.0, detailVM.brightValue, 0.0, 0.0,
                        detailVM.isConverted ? 255 : 0,
                        0.0, 0.0, detailVM.brightValue, 0.0,
                        detailVM.isConverted ? 255 : 0,
                        0.0, 0.0, 0.0, 1.0, 0.0, //
                      ]),
                      child: PhotoView(
                        enableRotation: true, // 회전 기능,
                        scaleStateController: detailVM.scaleStateController,
                        filterQuality: FilterQuality.high,
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.black),
                        imageProvider: AssetImage(
                            '$filePath/${studyKey}_${series.SERIESKEY}/${studyKey}_${series.SERIESKEY}_${detailVM.imageIndex}.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('밝기 조절  '),
                  SizedBox(
                    width: 500,
                    child: CupertinoSlider(
                      value: detailVM.brightValue,
                      min: -5,
                      max: 5,
                      divisions: 100,
                      onChanged: (double value) {
                        detailVM.brightValue = value;
                        detailVM.update();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('이미지 이동  '),
                  SizedBox(
                    width: 500,
                    child: CupertinoSlider(
                      value: detailVM.imageIndex.toDouble(),
                      min: 0,
                      max: series.IMAGECNT -1,
                      divisions: series.IMAGECNT,
                      onChanged: (double value) {
                        detailVM.imageIndex = value.toInt();
                        detailVM.update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
