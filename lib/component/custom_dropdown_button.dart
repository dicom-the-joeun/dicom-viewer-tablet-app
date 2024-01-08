
import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> itemLists;
  final double boxWidth;
  //final String selectedValue;
  const CustomDropdownButton({super.key, required this.itemLists, required this.boxWidth});

  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeVM>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: boxWidth,
        child: DropdownButton(
          isExpanded: true,
          value: (itemLists == homeVM.modalityList)
              ? homeVM.selectedModality
              : (itemLists ==homeVM.reportStatusList)
                  ? homeVM.selectedReportStatus
                  : homeVM.selectedExamStatus
              ,
          items: itemLists.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            homeVM.selectDropDown(value!, itemLists);
          },
        ),
      ),
    );
  }
}