import 'package:dance_up/data/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

void setOnboardingSeen() {
  box.write('onboarding_seen', true);
}

void persistUserData(Map<String, dynamic>? user) {
  box.write('user_data', user);
}

UserModel? getPersistedUserData() {
  final data = box.read('user_data');
  if (data == null) return null;
  return UserModel.fromJson(data);
}
