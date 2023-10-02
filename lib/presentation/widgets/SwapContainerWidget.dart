import 'package:flutter/material.dart';

class SwapContainer extends StatelessWidget {
  final String title;
  final Widget dropdownWidget;
  final Widget avatar;
  final double coinPrice;
  final double availableCoins;

  const SwapContainer(
      {Key? key,
      required this.title,
      required this.dropdownWidget,
      required this.avatar,
      required this.coinPrice,
      required this.availableCoins})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                title,
                style: TextStyle(color: Colors.white54),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: avatar,
                ),
                SizedBox(width: 130.0, child: dropdownWidget),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$$coinPrice",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.white54,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  children: [
                    Text("data", style: TextStyle(color: Colors.white38)),
                    Spacer(),
                    Text("$availableCoins MAX",
                        style: TextStyle(color: Colors.white38)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
