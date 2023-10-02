import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Loading spinner
            SizedBox(height: 16.0), // Spacer
            Text(
              'Loading...', // Loading text
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
