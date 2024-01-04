// ignore_for_file: non_constant_identifier_names

class StudyTab {
  // field
  final String PID;
  final String PNAME;
  final String MODALITY;
  final String? STUDYDESC;
  final int STUDYDATE;
  final int REPORTSTATUS;
  final int SERIESCNT;
  final int IMAGECNT;
  final int EXAMSTATUS;

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

}
