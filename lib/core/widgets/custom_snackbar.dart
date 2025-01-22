import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/constants/colors.dart';

customSnackBar({message, int time = 3}) {
  Fluttertoast.showToast(
    msg: "$message",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: time,
    backgroundColor: kBlackColor,
    textColor: kWhiteColor,
    fontSize: 16.0.sp,
  );
}
