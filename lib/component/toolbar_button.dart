import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;
  final bool isSelected;
  final double? width;
  const ToolbarButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.isSelected,
      this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width ?? 80,
        height: 80,
        child: MaterialButton(
          color: !isSelected ? const Color.fromARGB(255, 33, 33, 33) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 47,
                color: !isSelected ? Colors.white : const Color.fromARGB(255, 33, 33, 33),
              ),
              SizedBox(height: 3,),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: !isSelected ? Colors.white : const Color.fromARGB(255, 33, 33, 33),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
