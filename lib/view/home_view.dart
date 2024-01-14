import 'package:data_table_2/data_table_2.dart';
import 'package:dicom_image_control_app/view/calendar_dialog.dart';
import 'package:dicom_image_control_app/component/filter_dropdown_button.dart';
import 'package:dicom_image_control_app/component/filter_textfield.dart';
import 'package:dicom_image_control_app/component/my_appbar.dart';
import 'package:dicom_image_control_app/component/search_button.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/drawer.dart';
import 'package:dicom_image_control_app/view/thumbnail_view.dart';
import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                        FiterTextField(
                          controller: homeVM.pIdController,
                          hintText: 'ID',
                        ),
                        FiterTextField(
                          controller: homeVM.pNameController,
                          hintText: '이름',
                        ),
                        FilterDropdownButton(
                          itemLists: homeVM.modalityList,
                          boxWidth: 150,
                        ),
                        FilterDropdownButton(
                          itemLists: homeVM.examStatusList,
                          boxWidth: 150,
                        ),
                        FilterDropdownButton(
                          itemLists: homeVM.reportStatusList,
                          boxWidth: 150,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // homeVM.rangeStart = DateTime.now();
                            // homeVM.rangeEnd = DateTime.now();
                            homeVM.selectedDay = DateTime.now();
                            Get.dialog(const TableCalendarWidget());                          
                            },
                          icon: const Icon(Icons.calendar_month),
                          label: const Text('날짜 선택'),
                        ),
                        Row(
                          children: [
                            SearchButton(
                              labelText: '전체',
                              backgroundColor: homeVM.isWholeButtonSelected
                                  ? const Color.fromARGB(255, 135, 142, 147)
                                  : null,
                              onPressed: () {
                                homeVM.changeButtonState('전체');
                              },
                            ),
                            SearchButton(
                              labelText: '1일',
                              backgroundColor: homeVM.isDayButtonSelected
                                  ? const Color.fromARGB(255, 135, 142, 147)
                                  : null,
                              onPressed: () {
                                homeVM.changeButtonState('1일');
                              },
                            ),
                            SearchButton(
                              labelText: '1주일',
                              backgroundColor: homeVM.isWeekButtonSelected
                                  ? const Color.fromARGB(255, 135, 142, 147)
                                  : null,
                              onPressed: () {
                                homeVM.changeButtonState('1주일');
                              },
                            ),
                          ],
                        ),
                        SearchButton(
                          labelText: '검색',
                          backgroundColor: Colors.red,
                          onPressed: () => homeVM.filterStudyList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.71,
                        child: DataTable2(
                          showCheckboxColumn: false,
                          columnSpacing: 40,
                          headingTextStyle: headerTextStyle(),
                          columns: const [
                            DataColumn2(label: Text('환자 ID'), fixedWidth: 130),
                            DataColumn2(label: Text('환자 이름'), fixedWidth: 140),
                            DataColumn2(label: Text('검사장비'), fixedWidth: 110),
                            DataColumn2(
                              label: Text('검사설명'),
                            ),
                            DataColumn2(label: Text('검사일시'), fixedWidth: 130),
                            DataColumn2(label: Text('판독상태'), fixedWidth: 110),
                            DataColumn2(label: Text('시리즈'), fixedWidth: 90),
                            DataColumn2(label: Text('이미지'), fixedWidth: 90),
                            DataColumn2(label: Text('Verify'), fixedWidth: 90),
                          ],
                          rows: List.generate(homeVM.filteredStudies.length,
                              (index) {
                            StudyTab study = homeVM.filteredStudies[index];
                            return DataRow(
                              onSelectChanged: (value) async {
                                // 시리즈 리스트 받아오기
                                var seriesList = await homeVM
                                    .getSeriesTabList(study.STUDYKEY);
                                Get.to(() => ThumbnailView(
                                    seriesList: seriesList, study: study));
                              },
                              cells: [
                                DataCell(Text(
                                  study.PID,
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.PNAME,
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.MODALITY,
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.STUDYDESC!,
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.STUDYDATE.toString(),
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.REPORTSTATUS.toString(),
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.SERIESCNT.toString(),
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.IMAGECNT.toString(),
                                  style: cellTextStyle(),
                                )),
                                DataCell(Text(
                                  study.EXAMSTATUS.toString(),
                                  style: cellTextStyle(),
                                )),
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

TextStyle cellTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
}

TextStyle headerTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}
