import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String labelText;
  final Color? backgroundColor;
  const SearchButton({super.key, required this.labelText, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // 검색 기능 추가
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: (backgroundColor == null)
                        ? const Color.fromARGB(255, 61, 52, 52)
                        : backgroundColor,
          foregroundColor: Colors.white
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