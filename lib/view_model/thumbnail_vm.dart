import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ThumbnailVM extends GetxController {
  /// access token
  RxString token = ''.obs;
  /// access token 가져왔는지 판단할 변수
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await SharedHandler().fetchData();
    isLoading.value = false; // Set loading to false after data is fetched
    update();
  }

  /// 이미지 url 생성 함수
  String createThumbnailUrl(
      {required List<SeriesTab> seriesList, required int index}) {
    String url = '${dotenv.env['API_ENDPOINT']!}dcms/image';
    String filePath = seriesList[index].PATH;
    String fileName = seriesList[index].FNAME;

    url = '$url?filepath=$filePath&filename=$fileName';
    return url;
  }

  
}
