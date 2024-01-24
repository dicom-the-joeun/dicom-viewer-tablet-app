import 'package:dicom_image_control_app/component/loading_dialog.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/detail_view.dart';
import 'package:dicom_image_control_app/view/thumbnail_box.dart';
import 'package:dicom_image_control_app/view_model/detail_vm.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThumbnailView extends GetView<ThumbnailVM> {
  final List<SeriesTab> seriesList;
  final StudyTab study;
  const ThumbnailView(
      {super.key, required this.seriesList, required this.study});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Thumbnail'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '환자 ID: ${study.PID}',
                    style: seriesTextStyle(),
                  ),
                  Text(
                    '환자 이름: ${study.PNAME}',
                    style: seriesTextStyle(),
                  ),
                  Text('검사 장비 : ${study.MODALITY}', style: seriesTextStyle()),
                  Text('검사 일자: ${study.STUDYDATE}', style: seriesTextStyle()),
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.73,
                child: GetBuilder<ThumbnailVM>(
                  builder: (controller) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      mainAxisExtent: 550,
                    ),
                    itemCount: seriesList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            if (!await controller
                                .isImageDownloaded(study.STUDYKEY)) {
                              Get.dialog(
                                LoadingDialog(
                                    loadingText: controller.loadingText),
                                // barrierDismissible를 false로 설정하여 터치로 닫기 비활성화
                                barrierDismissible: false,
                              );
                              // 집파일 받아오기
                              await controller.getSeriesImages(
                                  studykey: study.STUDYKEY);
                              Get.back();
                            }

                            Get.to(
                                () => DetailView(
                                      studyKey: study.STUDYKEY,
                                      series: seriesList[index],
                                    ), binding: BindingsBuilder(() {
                              Get.put(DetailVM());
                            }));
                          },
                          child: ThumbnailBox(
                              seriesList: seriesList, index: index));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
