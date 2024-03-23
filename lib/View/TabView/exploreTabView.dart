import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Localization/iconAssets.dart';
import 'package:allevents/Routes/pages.dart';
import 'package:allevents/Themes/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreTabView extends StatelessWidget {
  ExploreTabView({super.key});
  ApiController apiController = Get.put(ApiController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _categoryBottomSheet(context),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            IconAssets.catagoryIcon,
                            color:
                                homeController.selectedCatName.value.isEmpty ||
                                        homeController.selectedCatName.value ==
                                            "all"
                                    ? AppColors.blackColor
                                    : AppColors.blueColor,
                          ),
                          Text(
                            homeController.selectedCatName.value.isEmpty ||
                                    homeController.selectedCatName.value ==
                                        "all"
                                ? "category".tr
                                : homeController.selectedCatName.value,
                            style: TextStyle(
                                color: homeController
                                            .selectedCatName.value.isEmpty ||
                                        homeController.selectedCatName.value ==
                                            "all"
                                    ? AppColors.blackColor
                                    : AppColors.blueColor,
                                fontSize: 16,
                                fontWeight: homeController
                                            .selectedCatName.value.isEmpty ||
                                        homeController.selectedCatName.value ==
                                            "all"
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      Text(
                        "Date&Time",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.sort_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        "Sort",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Obx(
            () => apiController.dataLoad.value
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                    itemCount: apiController.categoryItem.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var catData = apiController.categoryItem[index];

                      return InkWell(
                        onTap: () async {
                          Get.toNamed(Routes.EventDetailView,
                              arguments: {'data': catData});
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.whiteColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: Get.height,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            catData.thumbUrl.toString()),
                                        fit: BoxFit.fitHeight)),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        catData.eventname.toString(),
                                        style: Get.textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        catData.label.toString(),
                                        style: Get.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        catData.location.toString(),
                                        style: Get.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (int i = 0; i < 3; i++)
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3),
                                                      child: const Align(
                                                          widthFactor: 0.5,
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: CircleAvatar(
                                                              radius: 8,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      // productDetails.,
                                                                      ""),
                                                            ),
                                                          )),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  if (await canLaunchUrl(
                                                      Uri.parse(catData.shareUrl
                                                          .toString()))) {
                                                    launchUrl(Uri.parse(catData
                                                        .shareUrl
                                                        .toString()));
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.dry_cleaning_outlined,
                                                  color: AppColors.blackColor,
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.star_border,
                                                  color: AppColors.blackColor,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
          )
        ],
      ),
    );
  }

  _categoryBottomSheet(
    _,
  ) {
    return showModalBottomSheet(
      context: _,
      // isScrollControlled: true,
      builder: (context) {
        return Container(
          width: Get.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Categories",
                  style: Get.textTheme.titleLarge,
                ),
                titleAlignment: ListTileTitleAlignment.center,
                trailing: IconButton(
                    onPressed: () => Get.back(), icon: Icon(Icons.cancel)),
              ),
              const Divider(
                color: AppColors.greyColor,
                thickness: 1.0,
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: apiController.categoryResponceModal.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        apiController.getCatDataApi(
                            api: apiController.categoryResponceModal[index].data
                                .toString());
                        homeController.selectedCatName.value = apiController
                            .categoryResponceModal[index].category
                            .toString();
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: homeController.selectedCatName.value ==
                                    apiController
                                        .categoryResponceModal[index].category
                                ? AppColors.blueColor
                                : null),
                        child: Text(
                          apiController.categoryResponceModal[index].category
                              .toString(),
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
