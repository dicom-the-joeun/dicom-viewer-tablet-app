import 'package:dicom_image_control_app/view_model/detail_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrightSlider extends StatelessWidget {
  const BrightSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailVM>(
      builder: (_) => Visibility(
        visible: _.isBrightSelected,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('밝기 조절  '),
              SizedBox(
                width: 300,
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 20,
                  ),
                  child: Slider(
                    thumbColor: Colors.blueAccent,
                    inactiveColor: Colors.grey,
                    label: _.brightValue.toStringAsFixed(2),
                    value: _.brightValue,
                    min: !_.isConverted ? 0 : -5,
                    max: !_.isConverted ? 5 : 0,
                    divisions: 10,
                    onChanged: (double value) {
                      _.brightValue = value;
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
