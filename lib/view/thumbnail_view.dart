import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThumbnailView extends StatelessWidget {
  final List<SeriesTab> seriesList;
  const ThumbnailView({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    Get.put(ThumbnailVM());

    return GetBuilder<ThumbnailVM>(
      init: ThumbnailVM(),
      builder: (thumbnailVM) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Thumbnail'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (thumbnailVM.isLoading.value)
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              mainAxisExtent: 400,
                            ),
                            itemCount: seriesList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text('시리즈 번호: ${seriesList[index].SERIESKEY}'),
                                  (seriesList[index].SERIESDESC == null) 
                                    ? Text('')
                                    : Text('Score: ${seriesList[index].SERIESDESC}'),
                                  (seriesList[index].SCORE == null) 
                                    ? Text('')
                                    : Text('Score: ${seriesList[index].SCORE}'),
                                  Container(
                                    width: 300,
                                    height: 300,
                                    color: Colors.black,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      // 요청 url
                                      imageUrl: thumbnailVM.getThumbnailUrl(
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
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.error);
                                      },
                                      errorListener: (value) async =>
                                      // 에러 발생 시 엑세스토큰 다시 가져오기
                                          await SharedHandler().fetchData(),
                                    ),
                                  ),
                                ],
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
