import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData icon;
  final bool isSelected;
  const ToolbarButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.isSelected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: AspectRatio(
          aspectRatio: 1/1,
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
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: !isSelected ? Colors.white : const Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
