import 'package:cached_network_image/cached_network_image.dart';
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
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CachedNetworkImage(
                    // 요청 url
                    imageUrl: thumbnailVM.getThumbnailUrl(
                      seriesList: seriesList,
                      index: 0,
                    ),
                    // 헤더에 토큰 담기
                    httpHeaders: {
                      'accept': 'application/json',
                      'Authorization' : 'Bearer ${thumbnailVM.token}'},
                      // 'Authorization':
                      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDQ3MDg5MzcsInN1YiI6ImFkbWluIn0.p1KSebSi4XIp_MOW6BEsWZ1bNt0uxWVcEKsCoCfwTgs'
                    // },
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
