import 'package:flutter/material.dart';
import 'package:inte_eco_admin/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo-full.png',
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Container(
                width: 250,
                child: const LinearProgressIndicator(
                  color: primaryColor,
                )),
          ],
        ),
      ),
    );
  }
}
