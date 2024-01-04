import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageBox extends StatefulWidget {
  final String base64String;

  const ImageBox({super.key, required this.base64String});

  @override
  _ImageBoxState createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  bool isInverted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isInverted = !isInverted;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        height: 800,
        width: 800,
        child: ClipRRect(
          child: PhotoView.customChild(
            initialScale: 1.0,
            child: ColorFiltered(
              colorFilter: isInverted
                  ? const ColorFilter.matrix(<double>[
                      -1.0, 0.0, 0.0, 0.0, 255.0, //
                      0.0, -1.0, 0.0, 0.0, 255.0, //
                      0.0, 0.0, -1.0, 0.0, 255.0, //
                      0.0, 0.0, 0.0, 1.0, 0.0, //
                    ])
                  : const ColorFilter.matrix(<double>[
                      1.0, 0.0, 0.0, 0.0, 0.0, //
                      0.0, 1.0, 0.0, 0.0, 0.0, //
                      0.0, 0.0, 1.0, 0.0, 0.0, //
                      0.0, 0.0, 0.0, 1.0, 0.0, //
                    ]),
              child: Image.memory(base64Decode(widget.base64String)),
            ),
          ),
        ),
      ),
    );
  }
}
