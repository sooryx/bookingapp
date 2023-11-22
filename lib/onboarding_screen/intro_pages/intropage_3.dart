import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350.w,
              child: Text('Confirmed! Your getaway begins. Enjoy every moment ',textAlign: TextAlign.center,style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
      ),),
            ),
          ],
        ),
        Lottie.asset('assets/animations/success-animation.json',fit: BoxFit.contain)
        ],
      ),
    );
  }
}
