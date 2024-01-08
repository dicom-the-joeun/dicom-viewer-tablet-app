import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ThumbnailVM extends GetxController{
  
  late String token;

  @override
  void onInit() async {
    super.onInit();
    token = await SharedHandler().getAccessToken();
    print(token);
  }


  String getThumbnailImage({required List<SeriesTab> seriesList, required int index}){
    String url = '${dotenv.env['API_ENDPOINT']!}dcms/image';
    String filePath = seriesList[index].PATH;
    String fileName = seriesList[index].FNAME;

    url = '$url?filepath=$filePath&filename=$fileName';
    return url;
  }

  

}