// ignore_for_file: non_constant_identifier_names

class StudyTab {
  // field
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
      {required this.PID,
      required this.PNAME,
      required this.MODALITY,
      this.STUDYDESC,
      required this.STUDYDATE,
      required this.REPORTSTATUS,
      required this.SERIESCNT,
      required this.IMAGECNT,
      required this.EXAMSTATUS});

  StudyTab.fromMap(Map<String, dynamic> res)
      : PID = res['PID'],
        PNAME = res['PNAME'],
        MODALITY = res['MODALITY'],
        STUDYDESC = res['STUDYDESC'] ?? '',
        STUDYDATE = res['STUDYDATE'],
        REPORTSTATUS = _convertReportStatus(res['REPORTSTATUS']),
        SERIESCNT = res['SERIESCNT'],
        IMAGECNT = res['IMAGECNT'],
        EXAMSTATUS = (res['EXAMSTATUS'] == 0) ? '아니오' : '예';
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
