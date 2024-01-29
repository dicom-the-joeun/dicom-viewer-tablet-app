import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/toolbar_button.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/view/detail_view/_bright_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../view_model/detail_vm.dart';

class DetailView extends GetView<DetailVM> {
  final int studyKey;
  final SeriesTab series;

  const DetailView({super.key, required this.studyKey, required this.series});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Detail View',
          bottom: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    child: GetBuilder<DetailVM>(

                      builder: (_) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToolbarButton(
                            icon: Icons.invert_colors,
                            label: '반전',
                            isSelected: _.isInvertSelected,
                            onPressed: () => _.invertColor(),
                          ),
                          ToolbarButton(
                            icon: Icons.light_mode_rounded,
                            label: '밝기',
                            isSelected: _.isBrightSelected,
                            onPressed: () => _.clickBrightButton()
                          ),
                        ],
                      ),
                    ),
                  ),
                  const BrightSlider(),
                ],
              ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 730,
                child: ClipRRect(
                  child: GetBuilder<DetailVM>(
                    builder: (_) => ColorFiltered(
                      colorFilter: ColorFilter.matrix([
                        _.brightValue, 0.0, 0.0, 0.0,
                        _.isConverted ? 255 : 0,
                        0.0, _.brightValue, 0.0, 0.0,
                        _.isConverted ? 255 : 0,
                        0.0, 0.0, _.brightValue, 0.0,
                        _.isConverted ? 255 : 0,
                        0.0, 0.0, 0.0, 1.0, 0.0, //
                      ]),
                      child: PhotoView(
                        enableRotation: true, // 회전 기능,
                        scaleStateController: controller.scaleStateController,
                        filterQuality: FilterQuality.high,
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.black),
                        imageProvider: AssetImage(
                            '$filePath/study_$studyKey/${studyKey}_${series.SERIESKEY}_${controller.imageIndex}_${controller.windowCenterIndex}.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 100,
                      child: (series.IMAGECNT != 1)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('이미지 이동', style: TextStyle(fontSize: 25),),
                                SizedBox(
                                  width: 500,
                                  child: GetBuilder<DetailVM>(
                                    builder: (_) => Slider(
                                      value: _.imageIndex.toDouble(),
                                      label: _.imageIndex.toString(),
                                      min: 1,
                                      max: series.IMAGECNT.toDouble(),
                                      divisions: series.IMAGECNT - 1,
                                      onChanged: (double value) {
                                        _.imageIndex = value.toInt();
                                        _.update();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox()),
                  SizedBox(
                      height: 100,
                      child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('윈도우 센터', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                SizedBox(
                                  width: 500,
                                  child: GetBuilder<DetailVM>(
                                    builder: (_) => Slider(
                                      value: _.windowCenterIndex.toDouble(),
                                      min: 1,
                                      max: 10,
                                      divisions: 9,
                                      onChanged: (double value) {
                                        _.windowCenterIndex = value.toInt();
                                        _.update();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
