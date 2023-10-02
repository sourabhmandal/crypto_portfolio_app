
import 'dart:math';

import 'package:crypto_portfolio_test/presentation/widgets/pillWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CapitalizationWidget extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? bodyColor;
  final Color? backgroundColor;
  final String pillData;
  final Color? pillBackgroundColor;
  final double marketCap;
  final List<FlSpot> data;

  const CapitalizationWidget({
    Key? key,
    this.title = '',
    required this.titleColor,
    required this.bodyColor,
    required this.backgroundColor,
    required this.marketCap,
    required this.pillData,
    required this.pillBackgroundColor,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: backgroundColor,
      ),
    child: Padding(padding: const EdgeInsets.all(20), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: titleColor),),
        const SizedBox(height: 6,),
        Text('\$$marketCap T', style: TextStyle(
            fontSize: 26,
            color: bodyColor,
            fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6,),
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 55,
          child: LineChart(
            LineChartData(
              titlesData: const FlTitlesData(
                show: false,
              ),
              borderData: FlBorderData(
                  show: false
              ),
              lineBarsData:[
                LineChartBarData(
                show: true,
                color: bodyColor,
                barWidth: 4,
                isCurved: true,
                dotData: const FlDotData(
                  show: false,
                ),
                spots: data,
              )],
           ),
          ),
        ),
        SizedBox(height: 10,),
        Pill(data: pillData,
            backgroundColor: pillBackgroundColor,
            pillTextColor: bodyColor)
      ]),
    ),
    );
  }
}

