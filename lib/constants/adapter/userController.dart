import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<String> _username = ''.obs;

  String get username => _username.value;

  void setUsername(String name) {
    _username.value = name;
  }
}
