import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:flutter/material.dart';

class StudyCard extends StatelessWidget {
  final StudyTab study;
  const StudyCard({super.key, required this.study});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.66,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Text(study.PID),
            Text(study.PNAME),
            Text(study.MODALITY),
            Text(study.STUDYDESC!),
            Text(study.STUDYDATE.toString()),
            Text(changeReportStatus(study.REPORTSTATUS)),
            Text(study.SERIESCNT.toString()),
            Text(study.IMAGECNT.toString()),
            Text(changeExamStatus(study.EXAMSTATUS)),
          ],
        ),
      ),
    );
  }
}

String changeReportStatus(int status) {
  if (status == 3) return "읽지않음";
  if (status == 5) return "예비 판독";
  if (status == 6) {
    return "판독";
  } else {
    return '';
  }
}

String changeExamStatus(int status) {
  if (status == 0) {
    return '아니오';
  } else {
    return '예';
  }
}
