import 'package:allevents/Utility/logger.dart';
import 'package:get/get.dart';

import '../LocalDB/localDB.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxString selectedCatName = "".obs;
  RxString photoUrlUser = "".obs;
  RxString nameUser = "".obs;
  RxString emailUser = "".obs;
  RxString phoneUser = "".obs;
  RxString idUser = "".obs;

  @override
  void onInit() {
    getLocalData();
    super.onInit();
  }

  getLocalData() async {
    await LocalDB.getImage().then((value) {
      photoUrlUser.value = value.toString();
    });
    await LocalDB.getName().then((value) {
      nameUser.value = value.toString();
    });
    await LocalDB.getPhone().then((value) {
      phoneUser.value = value.toString();
    });
    await LocalDB.getUserID().then((value) {
      idUser.value = value.toString();
    });

    await LocalDB.getEmail().then((value) {
      emailUser.value = value.toString();
    });
  }
}
