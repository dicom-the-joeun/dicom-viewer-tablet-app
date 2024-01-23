import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/toolbar_button.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/static/search_data.dart';
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
                SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToolbarButton(
                        icon: Icons.invert_colors,
                        label: '반전',
                        isSelected: detailVM.isInvertSelected,
                        onPressed: () => detailVM.invertColor(),
                      ),
                      ToolbarButton(
                        icon: Icons.invert_colors,
                        label: '반전',
                        isSelected: detailVM.isInvertSelected,
                        onPressed: () => detailVM.invertColor(),
                      ),
                      ToolbarButton(
                        icon: Icons.invert_colors,
                        label: '반전',
                        isSelected: detailVM.isInvertSelected,
                        onPressed: () => detailVM.invertColor(),
                      ),
                      ToolbarButton(
                        icon: Icons.invert_colors,
                        label: '반전',
                        isSelected: detailVM.isInvertSelected,
                        onPressed: () => detailVM.invertColor(),
                      ),
                      ToolbarButton(
                          icon: Icons.light_mode_rounded,
                          label: '밝기',
                          isSelected: detailVM.isBrightSelected,
                          onPressed: () => detailVM.clickBrightButton()),
                    ],
                  ),
                ),
                Visibility(
                  visible: detailVM.isBrightSelected,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 900,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text('밝기 조절  '),
                        SizedBox(
                          width: 300,
                          child: Slider(
                            
                            thumbColor: Colors.blue,
                            activeColor: Colors.blueAccent,
                            inactiveColor: Colors.grey,
                            label: detailVM.brightValue.toString(),
                            value: detailVM.brightValue,
                            min:  -5,
                            max: 5,
                            divisions: 10,
                            onChanged: (double value) {
                              detailVM.brightValue = value;
                              detailVM.update();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
                width: MediaQuery.of(context).size.width,
                height: 700,
                child: ClipRRect(
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
              SizedBox(
                  height: 100,
                  child: (series.IMAGECNT != 1)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('이미지 이동  '),
                            SizedBox(
                              width: 500,
                              child: CupertinoSlider(
                                value: detailVM.imageIndex.toDouble(),
                                min: 0,
                                max: series.IMAGECNT - 1,
                                divisions: series.IMAGECNT,
                                onChanged: (double value) {
                                  detailVM.imageIndex = value.toInt();
                                  detailVM.update();
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox())
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('밝기 조절  '),
              //     SizedBox(
              //       width: 700,
              //       child: CupertinoSlider(
              //         value: detailVM.brightValue,
              //         min: -5,
              //         max: 5,
              //         divisions: 100,
              //         onChanged: (double value) {
              //           detailVM.brightValue = value;
              //           detailVM.update();
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // (series.IMAGECNT != 1)
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text('이미지 이동  '),
              //           SizedBox(
              //             width: 500,
              //             child: CupertinoSlider(
              //               value: detailVM.imageIndex.toDouble(),
              //               min: 0,
              //               max: series.IMAGECNT - 1,
              //               divisions: series.IMAGECNT,
              //               onChanged: (double value) {
              //                 detailVM.imageIndex = value.toInt();
              //                 detailVM.update();
              //               },
              //             ),
              //           ),
              //         ],
              //       )
              //     : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
