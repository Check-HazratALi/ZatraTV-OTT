// import 'dart:async';
// import 'package:get/get.dart';

// class SessionTimerController extends GetxController {
//   RxInt sessionTimeInSeconds = 0.obs;
//   Timer? _timer;

//   void startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       sessionTimeInSeconds.value++;
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//   }

//   void resetTimer() {
//     sessionTimeInSeconds.value = 0;
//     stopTimer();
//   }

//   String get formattedTime {
//     final hours = (sessionTimeInSeconds.value / 3600).floor().toString().padLeft(2, '0');
//     final minutes = ((sessionTimeInSeconds.value % 3600) / 60).floor().toString().padLeft(2, '0');
//     final seconds = (sessionTimeInSeconds.value % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes:$seconds';
//   }
// }
