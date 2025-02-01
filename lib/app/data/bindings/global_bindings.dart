import 'package:get/get.dart';

import '../../constants/controllers/preferenec_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserPreferencesController(),permanent: true);
    /*Get.put(RestController());
    Get.put(GoogleFirebase());
    Get.put(NotificationServices());*/
  }
}
