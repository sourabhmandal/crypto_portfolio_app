import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String data;
  final Color? backgroundColor;
  final Color? pillTextColor;

  const Pill({
    Key? key,
    required this.data,
    required this.backgroundColor,
    required this.pillTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(data, style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 16, color: pillTextColor),),
      ),
    );
  }
}