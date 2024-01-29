import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
        height: MediaQuery.of(context).size.height * 0.63,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableCalendar(
                rowHeight: 50,
                daysOfWeekHeight: 50,
                locale: "ko_KR",
                headerStyle: const HeaderStyle(
                  headerPadding: EdgeInsets.symmetric(vertical: 20),
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 25)),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  weekendStyle: TextStyle(
                    color: Color.fromARGB(255, 254, 157, 157),
                    fontSize: 20,
                  ),
                ),
                focusedDay: homeVM.rangeEnd,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
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
                startingDayOfWeek: StartingDayOfWeek.sunday,
                rangeStartDay: homeVM.rangeStart,
                rangeEndDay: homeVM.rangeEnd,

                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                    fontSize: 20,
                  ),
                  outsideTextStyle: TextStyle(
                    color: Colors.white38,
                    fontSize: 20,
                  ),
                  rangeHighlightColor: Color.fromARGB(255, 146, 176, 235),
                  weekendTextStyle: TextStyle(
                    color: Color.fromARGB(255, 254, 157, 157),
                    fontSize: 20,
                  ),
                ),
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onDayLongPressed: (selectedDay, focusedDay) => {},
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 114, 114, 114),
                    ),
                    onPressed: () => {},
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat('yyyy.MM.dd').format(homeVM.rangeStart),
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'To',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 114, 114, 114),
                    ),
                    onPressed: () => {},
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat('yyyy.MM.dd').format(homeVM.rangeEnd),
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(140, 50),
                    backgroundColor: const Color.fromARGB(255, 108, 135, 209)),
                onPressed: () => Get.back(),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                            const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
