import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/toolbar_button.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/view_model/thumbnail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../view_model/detail_vm.dart';

class DetailView extends StatelessWidget {
  final String imageUrl;
  const DetailView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final thumbVM = Get.find<ThumbnailVM>();
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
                ToolbarButton(
                  icon: Icons.invert_colors,
                  label: '반전',
                  onPressed: () => detailVM.convertColor(),
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
                width: 700,
                height: 700,
                child: ClipRRect(
                  child: SizedBox(
                    height: 700,
                    child: PhotoView.customChild(
                      enableRotation: true, // 회전 기능,
                      backgroundDecoration: const BoxDecoration(color: Colors.black),
                      child: ColorFiltered(
                        colorFilter: detailVM.isConverted
                            ? const ColorFilter.matrix([
                                -1.0, 0.0, 0.0, 0.0, 255.0, //
                                0.0, -1.0, 0.0, 0.0, 255.0, //
                                0.0, 0.0, -1.0, 0.0, 255.0, //
                                0.0, 0.0, 0.0, 1.0, 0.0, //
                              ])
                            : const ColorFilter.matrix([
                                1.0, 0.0, 0.0, 0.0, 0.0, //
                                0.0, 1.0, 0.0, 0.0, 0.0, //
                                0.0, 0.0, 1.0, 0.0, 0.0, //
                                0.0, 0.0, 0.0, 1.0, 0.0, //
                              ]),
                        child: CachedNetworkImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitHeight,
                          // 요청 url
                          imageUrl: imageUrl,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
