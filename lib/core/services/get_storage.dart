import 'package:get_storage/get_storage.dart';

final box = GetStorage();

void setOnboardingSeen() {
  box.write('onboarding_seen', true);
}

void saveUserData(Map<String, dynamic> user) {
  box.write('user_data', user);
}

Map<String, dynamic>? getUserData() {
  return box.read('user_data');
}
