import 'package:dicom_image_control_app/view_model/detail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WindowCenterSlider extends StatelessWidget {
  const WindowCenterSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailVM>(
      builder: (_) => Visibility(
        visible: _.isWCSelected,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('윈도우 센터 조절  '),
              SizedBox(
                width: 300,
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 20,
                  ),
                  child: Slider(
                    value: _.windowCenterIndex.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (double value) {
                      _.windowCenterIndex = value.toInt();
                      _.update();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
