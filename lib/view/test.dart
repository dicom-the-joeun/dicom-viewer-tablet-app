import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';


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
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                selectedDayPredicate: (day) =>
                    isSameDay(homeVM.selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  //
                },
              ),
              // const HomeTitle(title: '검사일자'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     TextButton.icon(
              //       onPressed: () async {
              //         homeVM.startDay = await homeVM.updateDatePicker(
              //             context, homeVM.startDay);
              //         // setState(() {});
              //       },
              //       icon: const Icon(Icons.calendar_month_outlined),
              //       label: Text(
              //         DateFormat('yyyy.MM.dd').format(homeVM.startDay),
              //         style: const TextStyle(fontSize: 20),
              //       ),
              //     ),
              //     TextButton.icon(
              //       onPressed: () async {
              //         homeVM.endDay =
              //             await homeVM.updateDatePicker(context, homeVM.endDay);
              //         // setState(() {});
              //       },
              //       icon: const Icon(Icons.calendar_month_outlined),
              //       label: Text(
              //         DateFormat('yyyy.MM.dd').format(homeVM.endDay),
              //         style: const TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ],
              // ),
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
