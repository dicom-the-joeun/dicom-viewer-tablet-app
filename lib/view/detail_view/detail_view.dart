import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/toolbar_button.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/view/detail_view/_bright_slider.dart';
import 'package:dicom_image_control_app/view/detail_view/window_center_slider.dart';
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
              GetBuilder<DetailVM>(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToolbarButton(
                      width: 83,
                      icon: Icons.zoom_in,
                      label: 'ZOOM',
                      isSelected: _.isZoomSelected,
                      onPressed: () => _.clickZoomButton(),
                    ),
                    ToolbarButton(
                      icon: Icons.threesixty_outlined,
                      label: '회전',
                      isSelected: _.isRotationSelected,
                      onPressed: () => _.clickRotationButton(),
                    ),
                    ToolbarButton(
                      icon: Icons.flip,
                      label: '반전',
                      isSelected: _.isInvertionSelected,
                      onPressed: () => _.invertColor(),
                    ),
                    ToolbarButton(
                        icon: Icons.light_mode_rounded,
                        label: '밝기',
                        isSelected: _.isBrightSelected,
                        onPressed: () => _.clickBrightnessButton()),
                    ToolbarButton(
                        icon: Icons.brightness_6_outlined,
                        label: 'WC',
                        isSelected: _.isWCSelected,
                        onPressed: () => _.clickWCButton()),
                  ],
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              // TODO: 위젯 합치기
              const BrightSlider(),
              const WindowCenterSlider(),
            ],
          ),
        ),
      ),
      body: Column(
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
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) =>
                        controller.changeImage(details, series.IMAGECNT),
                    child: PhotoView(
                      enableRotation: controller.isRotationSelected, // 회전 기능,
                      disableGestures: !controller.isZoomSelected,
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
                            const Text(
                              '이미지 이동',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              width: 500,
                              child: GetBuilder<DetailVM>(
                                builder: (_) => SliderTheme(
                                  data: const SliderThemeData(
                                    trackHeight: 20,
                                  ),
                                  child: Slider(
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
                            ),
                          ],
                        )
                      : const SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
