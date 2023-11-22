import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350.w,
            child: Text('Book with a tap. Your ideal stay, just like that.',textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
          Lottie.asset('assets/animations/booking-animation.json',fit: BoxFit.contain)
        ],
      ),
    );
  }
}
