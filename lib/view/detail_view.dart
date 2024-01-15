import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/detail_vm.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final thumbVM = Get.find<ThumbnailVM>();
        return GetBuilder<DetailVM>(
          init: DetailVM(),
          builder: (detailVM) => Scaffold(
            appBar: MyAppBar(
              title: 'Detail View',
            ),
            body: Center(
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: detailVM.isConverted ? ColorFilter.mode(Colors.white, BlendMode.difference) : ColorFilter.linearToSrgbGamma(),
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        // 요청 url
                        imageUrl: 'http://127.0.0.1:8000/api/dcms/image?filepath=201608%5C%5C22%5C%5CMS0010%5C%5CMR%5C%5C7%5C%5C&filename=MR.1.2.392.200036.9116.4.1.6116.40033.7.4001.1.1152393810.dcm&index=0',
                        
                        // 헤더에 토큰 담기
                        httpHeaders: {
                          'accept': 'application/json',
                          'Authorization': 'Bearer ${thumbVM.token.value}'
                        },
                      
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
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
                  ),
                  ElevatedButton(
                    onPressed: () {
                      detailVM.convertColor();
                    }, 
                    child: Text('반전'))
                ],
              ),
            ),
          ),
        );
  }
}
