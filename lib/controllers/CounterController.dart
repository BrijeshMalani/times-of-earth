import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs; // 'obs' makes it observable

  void increment() {
    count++;
  }
}
