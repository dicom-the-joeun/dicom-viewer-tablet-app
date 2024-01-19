import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/detail_view.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThumbnailView extends StatelessWidget {
  final List<SeriesTab> seriesList;
  final StudyTab study;
  const ThumbnailView(
      {super.key, required this.seriesList, required this.study});

  @override
  Widget build(BuildContext context) {
    Get.put(ThumbnailVM());

    return GetBuilder<ThumbnailVM>(
      init: ThumbnailVM(),
      builder: (thumbnailVM) {
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
                (thumbnailVM.isLoading.value)
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.73,
                          child: GridView.builder(
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
                                //   Get.dialog(
                                //   const Center(
                                //     child: Column(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         SizedBox(
                                //           width: 600,
                                //           height: 10,
                                //           child: LinearProgressIndicator(
                                //             color: Color.fromARGB(
                                //                 255, 228, 85, 75),
                                //           ),
                                //         ),
                                //         SizedBox(
                                //           height: 10,
                                //         ),
                                //         Text(
                                //           'LOADING.....',
                                //           style: TextStyle(
                                //               decoration: TextDecoration.none,
                                //               fontSize: 30,
                                //               color: Colors.white),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //   // barrierDismissible를 false로 설정하여 터치로 닫기 비활성화
                                //   barrierDismissible: false,
                                // );
                                  // 집파일 받아오기
                                  await thumbnailVM.getSeriesImages(studykey: study.STUDYKEY, serieskey: seriesList[index].SERIESKEY);
                                  // Get.back();
                                  Get.to(() => DetailView(studyKey: study.STUDYKEY, series: seriesList[index],));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color.fromARGB(255, 247, 111, 101), width: 3),
                                    color: Colors.black,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        width: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Series Num: ${seriesList[index].SERIESKEY}',
                                              style: seriesTextStyle(),
                                            ),
                                            (seriesList[index].SERIESDESC == null)
                                                ? Text(
                                                    'Series Description: Empty',
                                                    style: seriesTextStyle(),
                                                  )
                                                : Tooltip(
                                                    message: seriesList[index]
                                                        .SERIESDESC,
                                                    textStyle: const TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black,
                                                    ),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text:
                                                            'Series Description: ${seriesList[index].SERIESDESC}',
                                                        style: seriesTextStyle(),
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                            (seriesList[index].SCORE == null ||
                                                    seriesList[index]
                                                            .SCORE!
                                                            .trim() ==
                                                        '')
                                                ? const Text('')
                                                : Text(
                                                    'Score: ${seriesList[index].SCORE}',
                                                    style: seriesTextStyle(),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 400,
                                        height: 400,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          // 요청 url
                                          imageUrl: thumbnailVM.createThumbnailUrl(
                                            seriesList: seriesList,
                                            index: index,
                                          ),
                                          // 헤더에 토큰 담기
                                          httpHeaders: {
                                            'accept': 'application/json',
                                            'Authorization':
                                                'Bearer ${thumbnailVM.token.value}'
                                          },
                                
                                          progressIndicatorBuilder: (context, url,
                                                  downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress),
                                          errorWidget: (context, url, error) {
                                            return const Icon(Icons.error);
                                          },
                                          errorListener: (value) async =>
                                              // 에러 발생 시 엑세스토큰 다시 가져오기
                                              await SharedHandler().fetchData(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

TextStyle seriesTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
}
