import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThumbnailBox extends StatelessWidget {
  final List<SeriesTab> seriesList;
  final int index;
  const ThumbnailBox({super.key, required this.seriesList, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ThumbnailVM>();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 247, 111, 101), width: 3),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
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
          SizedBox(
            width: 400,
            height: 400,
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              // 요청 url
              imageUrl: controller.generateThumbnailImageUrl(
                seriesList: seriesList,
                index: index,
              ),
              // 헤더에 토큰 담기
              httpHeaders: {
                'accept': 'application/json',
                'Authorization': 'Bearer ${controller.token.value}'
              },

              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
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
    );
  }
}

TextStyle seriesTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );
}