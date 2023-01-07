import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              width: 120,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20),
            Container(width: 250, child: const LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
