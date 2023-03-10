import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  DetailsText({required this.content, required this.size, super.key});
  String content;
  double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: size,
        color: Colors.white,
        shadows: const [
          Shadow(
            blurRadius: 15.0,
            color: Color.fromARGB(150, 0, 0, 0),
            offset: Offset(3.0, 3.0),
          ),
        ],
      ),
    );
  }
}
