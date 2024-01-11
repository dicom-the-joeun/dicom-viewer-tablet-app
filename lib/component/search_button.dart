import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String labelText;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  const SearchButton({super.key, required this.labelText, this.backgroundColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: (backgroundColor == null)
                        ? const Color.fromARGB(255, 69, 67, 67)
                        : backgroundColor,
          foregroundColor: Colors.white,
        ),
        child: Text(
          labelText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
          ),
      ),
    );
  }
}