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
        height: MediaQuery.of(context).size.height * 0.58,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                startingDayOfWeek: StartingDayOfWeek.sunday,
                rangeStartDay: homeVM.rangeStart,
                rangeEndDay: homeVM.rangeEnd,
                calendarStyle: CalendarStyle(
                  rangeHighlightColor: Color.fromARGB(255, 146, 176, 235),
                  weekendTextStyle: TextStyle(color: Color.fromARGB(255, 255, 179, 179)),
                ),
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onDayLongPressed: (selectedDay, focusedDay) => {},
              ),
              Spacer(),
              SizedBox(height: 10,),
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
                    child: Text(
                      'To',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(140, 50),
                    backgroundColor: Color.fromARGB(255, 108, 135, 209)),
                onPressed: () => Get.back(),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                            SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
