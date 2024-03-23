import 'package:allevents/Modal/categoryDataREsponseModal.dart';
import 'package:allevents/Modal/categoryResponseModal.dart';
import 'package:allevents/Utility/apiManager.dart';
import 'package:allevents/Utility/apiUrls.dart';
import 'package:allevents/Utility/logger.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  RxList<CategoryRespnseModal> categoryResponceModal =
      <CategoryRespnseModal>[].obs;
  RxList<Item> categoryItem = <Item>[].obs;
  RxBool isLoading = false.obs;
  RxBool dataLoad = false.obs;
  getCategoryApi() async {
    try {
      if (await ApiManage.checkInternet()) {
        isLoading.value = true;
        final response = await ApiManage.getCall(url: ApiString.categoryUrl);
        categoryResponceModal.value = List<CategoryRespnseModal>.from(
            response.map((json) => CategoryRespnseModal.fromJson(json)));
        // categoriesDataResponseModal.item = [];
        categoryItem.value = [];
        await getCatDataApi(
            api: "https://allevents.s3.amazonaws.com/tests/all.json");

        isLoading.value = false;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  getCatDataApi({String api = ""}) async {
    try {
      if (await ApiManage.checkInternet()) {
        dataLoad.value = true;

        var responce = await ApiManage.getCall(url: api);
        CategoriesDataResponseModal categoriesDataResponseModal =
            CategoriesDataResponseModal();
        categoriesDataResponseModal.item = [];
        categoryItem.value = [];

        categoriesDataResponseModal =
            CategoriesDataResponseModal.fromJson(responce);

        if (categoriesDataResponseModal.item!.isNotEmpty) {
          categoryItem.value = categoriesDataResponseModal.item!;
          logger.i("categoryItem : ${categoryItem.length}");
        }
        dataLoad.value = false;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void onInit() {
    getCategoryApi();
    // TODO: implement onInit
    super.onInit();
  }
}
