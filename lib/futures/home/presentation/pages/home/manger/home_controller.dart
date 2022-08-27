import 'package:get/get.dart';
import '/core/services/custom_widgets.dart';

class HomeController extends GetxController {
  String city = "", type = "";
  bool isDoctor = false;

  @override
  void onInit() async {
    city = (await getAddress()) ?? "";
    setType();
    super.onInit();
  }

  void setType(){
    type = CustomWidgets.accountType;
    isDoctor = CustomWidgets.isDoctor;
  }
}
