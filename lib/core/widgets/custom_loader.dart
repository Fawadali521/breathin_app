import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: kRedColor,
    );
    //  Lottie.asset(
    //   "$jsonString/circle-loader.json",
    //   height: 170.h,
    //   width: 170.w,
    // );
  }
}
