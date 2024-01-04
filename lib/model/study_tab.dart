// ignore_for_file: non_constant_identifier_names

class StudyTab {
  // field
  final String PID;
  final String PNAME;
  final String MODALITY;
  final String STUDYDESC;
  final int STUDYDATE;
  final int REPORTSTATUS;
  final int SERIESCNT;
  final int IMAGECNT;
  final int EXAMSTATUS;

  StudyTab(
      {required this.PID,
      required this.PNAME,
      required this.MODALITY,
      required this.STUDYDESC,
      required this.STUDYDATE,
      required this.REPORTSTATUS,
      required this.SERIESCNT,
      required this.IMAGECNT,
      required this.EXAMSTATUS});

  static final studies = [
    StudyTab(
        PID: "MS0001",
        PNAME: "Anonymous",
        MODALITY: "CR",
        STUDYDESC: "Chest PA",
        STUDYDATE: 20210310,
        REPORTSTATUS: 3,
        SERIESCNT: 1,
        IMAGECNT: 1,
        EXAMSTATUS: 1),
    StudyTab(
        PID: "MS0001",
        PNAME: "Anonymous",
        MODALITY: "CR",
        STUDYDESC: "Chest PA",
        STUDYDATE: 20210310,
        REPORTSTATUS: 3,
        SERIESCNT: 1,
        IMAGECNT: 1,
        EXAMSTATUS: 1),
    StudyTab(
        PID: "MS0001",
        PNAME: "Anonymous",
        MODALITY: "CR",
        STUDYDESC: "Chest PA",
        STUDYDATE: 20210310,
        REPORTSTATUS: 3,
        SERIESCNT: 1,
        IMAGECNT: 1,
        EXAMSTATUS: 1),
  ];
}
