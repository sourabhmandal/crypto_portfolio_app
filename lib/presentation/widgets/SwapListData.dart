import 'package:flutter/material.dart';

class SwapListData extends StatelessWidget {
  final String keyData;
  final String valueData;
  final bool isLast;

  const SwapListData({
    Key? key,
    required this.keyData,
    required this.valueData,
    this.isLast = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(keyData, style: TextStyle(color: Colors.white54),),
                Spacer(),
                Text(valueData, style: TextStyle(color: Colors.white),),
              ],),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: isLast == false ? Divider(color: Colors.white54,) : SizedBox(),
          ),
        ],
      ),
    );
  }
}