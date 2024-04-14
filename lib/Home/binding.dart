import 'package:deemo/Home/controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => controller());
  }
}
