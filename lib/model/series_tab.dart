// ignore_for_file: non_constant_identifier_names

class SeriesTab {
  // field
  final int SERIESKEY;
  final String? SERIESDESC;
  final String? SCORE;
  final int IMAGECNT;
  final String PATH;
  final String FNAME;
  final String HEADERS;

  SeriesTab({
    required this.SERIESKEY, 
    this.SERIESDESC, 
    this.SCORE, 
    required this.IMAGECNT, 
    required this.PATH, 
    required this.FNAME,
    required this.HEADERS,
    });

  factory SeriesTab.fromMap(Map<String, dynamic> json){
    return SeriesTab(
      SERIESKEY : json['SERIESKEY'],
      SERIESDESC : json['SERIESDESC'],
      SCORE : json['SCORE'],
      IMAGECNT : json['IMAGECNT'],
      PATH : json['PATH'],
      FNAME : json['FNAME'],
      HEADERS : json['HEADERS'],
    );
  }

} // end