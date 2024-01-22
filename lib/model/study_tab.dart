// ignore_for_file: non_constant_identifier_names

class StudyTab {
  // field
  final int STUDYKEY;
  final String PID;
  final String PNAME;
  final String MODALITY;
  final String? STUDYDESC;
  final int STUDYDATE;
  final String REPORTSTATUS;
  final int SERIESCNT;
  final int IMAGECNT;
  final String EXAMSTATUS;

  StudyTab(
      {
      required this.STUDYKEY,
      required this.PID,
      required this.PNAME,
      required this.MODALITY,
      this.STUDYDESC,
      required this.STUDYDATE,
      required this.REPORTSTATUS,
      required this.SERIESCNT,
      required this.IMAGECNT,
      required this.EXAMSTATUS});

  

  factory StudyTab.fromMap(Map<String, dynamic> json) {
    return StudyTab(
        STUDYKEY: json['STUDYKEY'],
        PID: json['PID'],
        PNAME: json['PNAME'],
        MODALITY: json['MODALITY'],
        STUDYDESC: json['STUDYDESC'] ?? '',
        STUDYDATE: json['STUDYDATE'],
        REPORTSTATUS: _convertReportStatus(json['REPORTSTATUS']),
        SERIESCNT: json['SERIESCNT'],
        IMAGECNT: json['IMAGECNT'],
        EXAMSTATUS: (json['EXAMSTATUS'] == 0) ? '예' : '아니오');
  }
}

String _convertReportStatus(int status) {
  if (status == 3) return '읽지않음';
  if (status == 5) return '예비 판독';
  if (status == 6) {
    return '판독';
  } else {
    return '판정 모름';
  }
}
