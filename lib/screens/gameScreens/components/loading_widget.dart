import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///A function to show a loading widget while [asyncComputation]
///is being performed
///It returns the value from [asyncComputation]
Future<T> loadToScreen<T>({
  required Future<T> Function() asyncComputation,
  required BuildContext context,
}) async {
  return Get.showOverlay(
    asyncFunction: asyncComputation,
    loadingWidget: Center(
      child: SpinKitPulse(
        color: Colors.teal.shade700,
        size: MediaQuery.of(context).size.width / 5,
      ),
    ),
    opacity: .5,
  );
}
