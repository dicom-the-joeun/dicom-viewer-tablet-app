import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ThumbnailVM extends GetxController {
  RxString token = ''.obs;
  var isLoading = true.obs; // Loading indicator

  @override
  void onInit() async {
    super.onInit();
    token.value = await SharedHandler().fetchData();
    isLoading.value = false; // Set loading to false after data is fetched
    update();
    print(token.value);
  }


  String getThumbnailUrl(
      {required List<SeriesTab> seriesList, required int index}) {
    String url = '${dotenv.env['API_ENDPOINT']!}dcms/image';
    String filePath = seriesList[index].PATH;
    String fileName = seriesList[index].FNAME;

    url = '$url?filepath=$filePath&filename=$fileName';
    print('path: $filePath');
    print('name: $fileName');
    return url;
  }
}
