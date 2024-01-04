import 'package:dicom_image_control_app/component/custom_dropdown_button.dart';
import 'package:dicom_image_control_app/component/custom_textfield.dart';
import 'package:dicom_image_control_app/component/home_title.dart';
import 'package:dicom_image_control_app/component/search_button.dart';
import 'package:dicom_image_control_app/component/study_card.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/view/detail_view.dart';
import 'package:dicom_image_control_app/view/drawer.dart';
import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<StudyTab> studies = StudyTab.studies;

    Get.put(HomeVM);

    return GetBuilder<HomeVM>(
      init: HomeVM(),
      builder: (homeVM) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FutureBuilder(
          future: homeVM.getStudyTabList(),
          builder: (context, snapshot) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () => homeVM.resetValues(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              body: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TableCalendar(
                              focusedDay: DateTime.now(),
                              firstDay: DateTime.utc(2022, 1, 1),
                              lastDay: DateTime.utc(2024, 12, 31),
                              selectedDayPredicate: (day) =>
                                  isSameDay(homeVM.selectedDay, day),
                              onDaySelected: (selectedDay, focusedDay) {
                                //
                              },
                            ),
                            const HomeTitle(title: '검사일자'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    homeVM.startDay =
                                        await homeVM.updateDatePicker(
                                            context, homeVM.startDay);
                                    // setState(() {});
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  label: Text(
                                    DateFormat('yyyy.MM.dd')
                                        .format(homeVM.startDay),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    homeVM.endDay =
                                        await homeVM.updateDatePicker(
                                            context, homeVM.endDay);
                                    // setState(() {});
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  label: Text(
                                    DateFormat('yyyy.MM.dd')
                                        .format(homeVM.endDay),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            const HomeTitle(title: '검사장비'),
                            CustomDropdownButton(
                              itemLists: homeVM.equipmentList,
                              boxWidth: MediaQuery.of(context).size.width * 0.3,
                            ),
                            const HomeTitle(title: 'Verify'),
                            CustomDropdownButton(
                              itemLists: homeVM.verifyList,
                              boxWidth: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('조회'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white60,
                      width: 20,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.66,
                            child: Row(
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
                                  itemLists: homeVM.decipherList,
                                  boxWidth: 150,
                                ),
                                const SearchButton(labelText: '전체'),
                                const SearchButton(labelText: '1일'),
                                const SearchButton(labelText: '1주일'),
                                const SearchButton(
                                  labelText: '검색',
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => const DetailView()),
                            child: const Text('test'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.66,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                              itemCount: studies.length,
                              itemBuilder: (context, index) {
                                return StudyCard(study: studies[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              drawer: const UserDrawer(),
            );
          },
        ),
      ),
    );
  }
}
