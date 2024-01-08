// ignore_for_file: non_constant_identifier_names

class SeriesTab {
  // field
  final int SERIESKEY;
  final String? SERIESDESC;
  final String? SCORE;
  final int IMAGECNT;
  final String PATH;
  final String FNAME;

  SeriesTab({
    required this.SERIESKEY, 
    this.SERIESDESC, 
    this.SCORE, 
    required this.IMAGECNT, 
    required this.PATH, 
    required this.FNAME});

  SeriesTab.fromMap(Map<String, dynamic> res)
      : SERIESKEY = res['SERIESKEY'],
        SERIESDESC = res['SERIESDESC'],
        SCORE = res['SCORE'],
        IMAGECNT = res['IMAGECNT'],
        PATH = res['PATH'],
        FNAME = res['FNAME'];


} // end