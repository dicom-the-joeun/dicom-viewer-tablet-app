class MyUtil {
  String convertIntDateToString(int studyDate) {
// studyDate를 문자열로 변환
    String dateStr = studyDate.toString();

    // 문자열을 DateTime으로 변환
    DateTime dateTime = DateTime.parse(dateStr);

    // 출력 형식에 맞게 포맷
    String formattedDate =
        "${dateTime.year % 100}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}";

    // 최종 결과 반환
    return formattedDate;
  }
}
