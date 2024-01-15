class ImageTab {
  final String studyDate;
  final String studyTime;
  final String manufacturer;
  final String seriesDescription;
  final String manufacturerModelName;
  final String patientName;
  final String patientID;
  final String patientBirthDate;
  final String seriesNumber;
  final String rows;
  final String columns;
  final String windowCenter;
  final String windowWidth;
  final String numberOfFrames;
  final String pixelArrayShape;
  final List<ImageResult> result;

  ImageTab({
    required this.studyDate,
    required this.studyTime,
    required this.manufacturer,
    required this.seriesDescription,
    required this.manufacturerModelName,
    required this.patientName,
    required this.patientID,
    required this.patientBirthDate,
    required this.seriesNumber,
    required this.rows,
    required this.columns,
    required this.windowCenter,
    required this.windowWidth,
    required this.numberOfFrames,
    required this.pixelArrayShape,
    required this.result,
  });

  factory ImageTab.fromMap(Map<String, dynamic> res) {
    return ImageTab(
      studyDate: res['Study Date'],
      studyTime: res['Study Time'],
      manufacturer: res['Manufacturer'],
      seriesDescription: res['Series Description'],
      manufacturerModelName: res["Manufacturer's Model Name"],
      patientName: res['Patient\'s Name'],
      patientID: res['Patient ID'],
      patientBirthDate: res['Patient\'s Birth Date'],
      seriesNumber: res['Series Number'],
      rows: res['Rows'],
      columns: res['Columns'],
      windowCenter: res['Window Center'],
      windowWidth: res['Window Width'],
      numberOfFrames: res['Number of Frames'],
      pixelArrayShape: res['pixel array shape'],
      result: (res['result'] as List).map((item) => ImageResult.fromMap(item)).toList(),
    );
  }
}

class ImageResult {
  final int imageKey;
  final String path;
  final String fname;

  ImageResult({
    required this.imageKey,
    required this.path,
    required this.fname,
  });

  factory ImageResult.fromMap(Map<String, dynamic> res) {
    return ImageResult(
      imageKey: res['IMAGEKEY'],
      path: res['PATH'],
      fname: res['FNAME'],
    );
  }
}
