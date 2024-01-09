import 'package:data_table_2/data_table_2.dart';
import 'package:dicom_image_control_app/component/custom_dropdown_button.dart';
import 'package:dicom_image_control_app/component/custom_textfield.dart';
import 'package:dicom_image_control_app/component/home_title.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/search_button.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/drawer.dart';
import 'package:dicom_image_control_app/view/thumbnail_view.dart';
import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeVM);
    return GetBuilder<HomeVM>(
      init: HomeVM(),
      builder: (homeVM) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyAppBar(
            title: 'PACSPLUS',
            actions: [
              IconButton(
                onPressed: () => homeVM.resetValues(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          controller: homeVM.userIDController,
                          labelText: '환자 아이디',
                        ),
                        CustomTextField(
                          controller: homeVM.userNameController,
                          labelText: '환자 이름',
                        ),
                        CustomDropdownButton(
                          itemLists: homeVM.modalityList,
                          boxWidth: 150,
                        ),
                        CustomDropdownButton(
                          itemLists: homeVM.examStatusList,
                          boxWidth: 150,
                        ),
                        CustomDropdownButton(
                          itemLists: homeVM.reportStatusList,
                          boxWidth: 150,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.dialog(Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TableCalendar(
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime.utc(2022, 1, 1),
                                        lastDay: DateTime.utc(2024, 12, 31),
                                        selectedDayPredicate: (day) =>
                                            isSameDay(homeVM.selectedDay, day),
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          //
                                        },
                                      ),
                                      const HomeTitle(title: '검사일자'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () async {
                                              homeVM.startDay =
                                                  await homeVM.updateDatePicker(
                                                      context, homeVM.startDay);
                                              // setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month_outlined),
                                            label: Text(
                                              DateFormat('yyyy.MM.dd')
                                                  .format(homeVM.startDay),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          TextButton.icon(
                                            onPressed: () async {
                                              homeVM.endDay =
                                                  await homeVM.updateDatePicker(
                                                      context, homeVM.endDay);
                                              // setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month_outlined),
                                            label: Text(
                                              DateFormat('yyyy.MM.dd')
                                                  .format(homeVM.endDay),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // 검색
                                              Get.back();
                                            },
                                            child: const Text('확인'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          },
                          icon: const Icon(Icons.calendar_month),
                          label: const Text('날짜 선택'),
                        ),
                        const SearchButton(labelText: '전체'),
                        const SearchButton(labelText: '1일'),
                        const SearchButton(labelText: '1주일'),
                        SearchButton(
                          labelText: '검색',
                          backgroundColor: Colors.red,
                          onPressed: () => homeVM.filterData(
                            pid: homeVM.userIDController.text.trim(),
                            pname: homeVM.userNameController.text.trim(),
                            reportStatus: homeVM.selectedReportStatus,
                            equipment: homeVM.selectedModality,
                            examStatus: homeVM.selectedExamStatus,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.71,
                        child: DataTable2(
                          columnSpacing: 40,
                          headingTextStyle: headerTextStyle(),
                          columns: const [
                            DataColumn2(label: Text('환자 ID'),fixedWidth: 130),
                            DataColumn2(label: Text('환자 이름'),fixedWidth: 140),
                            DataColumn2(label: Text('검사장비'), fixedWidth: 110),
                            DataColumn2(label: Text('검사설명'),),
                            DataColumn2(label: Text('검사일시'), fixedWidth: 130),
                            DataColumn2(label: Text('판독상태'), fixedWidth: 110),
                            DataColumn2(label: Text('시리즈'), fixedWidth: 90),
                            DataColumn2(label: Text('이미지'), fixedWidth: 90),
                            DataColumn2(label: Text('Verify'),fixedWidth: 90),
                          ],
                          rows: List.generate(homeVM.studies.length,
                              (index) {
                            StudyTab study = homeVM.studies[index];
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(study.PID, style: cellTextStyle(),),
                                  onTap: () async {
                                    // 시리즈 리스트 받아오기
                                    var seriesList = await homeVM.getSeriesTabList(study.STUDYKEY);
                                    Get.to(()=> ThumbnailView(seriesList: seriesList));
                                  }
                                ),
                                DataCell(Text(study.PNAME, style: cellTextStyle(),)),
                                DataCell(Text(study.MODALITY, style: cellTextStyle(),)),
                                DataCell(Text(study.STUDYDESC!, style: cellTextStyle(),)),
                                DataCell(Text(study.STUDYDATE.toString(), style: cellTextStyle(),)),
                                DataCell(Text(study.REPORTSTATUS.toString(), style: cellTextStyle(),)),
                                DataCell(Text(study.SERIESCNT.toString(), style: cellTextStyle(),)),
                                DataCell(Text(study.IMAGECNT.toString(), style: cellTextStyle(),)),
                                DataCell(Text(study.EXAMSTATUS.toString(), style: cellTextStyle(),)),
                              ],
                              
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: const UserDrawer(),
        ),
      ),
    );
  }
}

TextStyle cellTextStyle(){
  return const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
}

TextStyle headerTextStyle(){
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}