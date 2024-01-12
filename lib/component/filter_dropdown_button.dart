
import 'package:dicom_image_control_app/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FilterDropdownButton extends StatelessWidget {
  /// 드롭다운 버튼에 포함될 리스트
  final List<String> itemLists;
  /// 드롭다운 버튼 폭
  final double boxWidth;

  /// 검색에 사용되는 드롭다운 버튼
  const FilterDropdownButton({super.key, required this.itemLists, required this.boxWidth});

  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeVM>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: boxWidth,
        child: DropdownButton(
          isExpanded: true,
          // value : 선택된 항목 값
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