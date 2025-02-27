import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastOverlay {
  static void showToast(String msg, {onTop = false}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.lightGrey,
      textColor: AppColors.black,
      timeInSecForIosWeb: 3,
      gravity: onTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
      fontSize: 16,
    );
  }
}
