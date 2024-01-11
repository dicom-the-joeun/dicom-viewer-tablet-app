import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/home_title.dart';

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeVM>();

    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontSize: 25)
                ),
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(1990, 1, 1),
                lastDay: DateTime.utc(2030, 1, 31),
                calendarFormat: homeVM.calendarFormat,
                selectedDayPredicate: (day) =>
                    isSameDay(homeVM.selectedDay, day),
                startingDayOfWeek: StartingDayOfWeek.monday,
                rangeStartDay: homeVM.rangeStart,
                rangeEndDay: homeVM.rangeEnd,
                onFormatChanged: (format) {
                  if (homeVM.calendarFormat != format){
                    homeVM.calendarFormat = format;
                  }
                },
                onDaySelected: (selectedDay, focusedDay) {
                  homeVM.daySelected(selectedDay, focusedDay);
                },
                onRangeSelected: (start, end, focusedDay) {
                  homeVM.rangeSelected(start, end, focusedDay);
                },
                
                rangeSelectionMode: RangeSelectionMode.toggledOn,
              ),
              const HomeTitle(title: '검사일자'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      //
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat('yyyy.MM.dd').format(homeVM.rangeStart ?? DateTime.now()),

                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      //
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat('yyyy.MM.dd').format(homeVM.rangeEnd ?? DateTime.now()),

                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
