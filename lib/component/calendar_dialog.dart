import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/home_title.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({super.key});

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
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
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 25)),
                focusedDay: homeVM.rangeEnd,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.now(),
                calendarFormat: homeVM.calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(day, homeVM.selectedDay);
                },
                onRangeSelected: (start, end, focusedDay) {
                  if (end == null) {
                    homeVM.rangeStart = start!;
                    homeVM.rangeEnd = start;
                  } else {
                    homeVM.rangeStart = start!;
                    homeVM.rangeEnd = end;
                  }
                  setState(() {});
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                rangeStartDay: homeVM.rangeStart,
                rangeEndDay: homeVM.rangeEnd,
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onDayLongPressed: (selectedDay, focusedDay) => {},
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
                      DateFormat('yyyy.MM.dd')
                          .format(homeVM.rangeStart),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      //
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat('yyyy.MM.dd')
                          .format(homeVM.rangeEnd),
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
