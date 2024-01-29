import 'package:data_table_2/data_table_2.dart';
import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/detail_view.dart';
import 'package:dicom_image_control_app/view_model/detail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThumbnailBox extends StatelessWidget {
  final StudyTab study;
  final List<SeriesTab> seriesList;
  final int index;
  const ThumbnailBox(
      {super.key,
      required this.study,
      required this.seriesList,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 247, 111, 101), width: 3),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            titleTextStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            title: const Center(
                                child: Text(
                              '시리즈 정보',
                            )),
                            content: SizedBox(
                              height: 320,
                              width: 350,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable2(
                                  columns: [
                                    DataColumn2(
                                      label: Text(
                                        '환자 아이디',
                                        style: cellTextStyle(),
                                      ),
                                    ),
                                    DataColumn2(
                                      label: Text(
                                        study.PID,
                                        style: cellTextStyle(),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow2(cells: [
                                      DataCell(Text(
                                        '환자 이름',
                                        style: cellTextStyle(),
                                      )),
                                      DataCell(Text(
                                        study.PNAME,
                                        style: cellTextStyle(),
                                      )),
                                    ]),
                                    DataRow2(cells: [
                                      DataCell(Text(
                                        '검사 일시',
                                        style: cellTextStyle(),
                                      )),
                                      DataCell(Text(
                                        study.STUDYDATE.toString(),
                                        style: cellTextStyle(),
                                      )),
                                    ]),
                                    DataRow2(cells: [
                                      DataCell(Text(
                                        '검사 장비',
                                        style: cellTextStyle(),
                                      )),
                                      DataCell(Text(
                                        study.MODALITY,
                                        style: cellTextStyle(),
                                      )),
                                    ]),
                                    DataRow2(cells: [
                                      DataCell(Text(
                                        '시리즈 번호',
                                        style: cellTextStyle(),
                                      )),
                                      DataCell(Text(
                                        seriesList[index].SERIESKEY.toString(),
                                        style: cellTextStyle(),
                                      )),
                                    ]),
                                    DataRow2(cells: [
                                      DataCell(Text(
                                        '이미지 개수',
                                        style: cellTextStyle(),
                                      )),
                                      DataCell(Text(
                                        seriesList[index].IMAGECNT.toString(),
                                        style: cellTextStyle(),
                                      )),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actionsPadding: const EdgeInsets.only(bottom: 30),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 46, 149, 217)
                                ),
                                onPressed: () {
                                  Get.back();
                                  Get.to(
                                      () => DetailView(
                                          studyKey: study.STUDYKEY,
                                          series: seriesList[index]),
                                      binding: BindingsBuilder(() {
                                    Get.put(DetailVM());
                                  }));
                                },
                                child: Text('이미지 확인', style: cellTextStyle(),),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            message: seriesList[index].SERIESDESC,
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
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                    (seriesList[index].SCORE == null ||
                            seriesList[index].SCORE!.trim() == '')
                        ? const Text('')
                        : Text(
                            'Score: ${seriesList[index].SCORE}',
                            style: seriesTextStyle(),
                          ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 400,
            height: 400,
            child: Image.asset('$filePath/study_${study.STUDYKEY}/${study.STUDYKEY}_${seriesList[index].SERIESKEY}_1_1.png'),
            // child: CachedNetworkImage(
            //   fit: BoxFit.fitHeight,
            //   // 요청 url
            //   imageUrl: controller.generateThumbnailImageUrl(
            //     seriesList: seriesList,
            //     index: index,
            //   ),
            //   // 헤더에 토큰 담기
            //   httpHeaders: {
            //     'accept': 'application/json',
            //     'Authorization': 'Bearer ${controller.token.value}'
            //   },

            //   progressIndicatorBuilder: (context, url, downloadProgress) =>
            //       CircularProgressIndicator(value: downloadProgress.progress),
            //   errorWidget: (context, url, error) {
            //     return const Icon(Icons.error);
            //   },
            //   errorListener: (value) async =>
            //       // 에러 발생 시 엑세스토큰 다시 가져오기
            //       print(value),
            // ),
          ),
        ],
      ),
    );
  }
}

TextStyle seriesTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
}

TextStyle cellTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
}
