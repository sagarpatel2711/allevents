import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Localization/iconAssets.dart';
import 'package:allevents/View/TabView/exploreTabView.dart';
import 'package:allevents/View/TabView/feedTabView.dart';
import 'package:allevents/View/TabView/profileTabView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/appColors.dart';
import '../Widgets/searchDelegate.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  ApiController apiController = Get.put(ApiController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getLocalData();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Text(
            "allevents".tr,
            style: Get.textTheme.titleMedium,
          ),
          actions: [
            IconButton(
              icon: Icon(IconAssets.searchIcon),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )
          ],
        ),
        body: IndexedStack(
          index: homeController.selectedIndex.value,
          children: [ExploreTabView(), const FeedTabView(), ProfileTabView()],
        ),
        bottomNavigationBar: Obx(() => _bottomBar()),
      ),
    );
  }

  Color isSelected(int index) {
    if (homeController.selectedIndex.value == index) {
      return Colors.yellow;
    } else {
      return AppColors.redColor;
    }
  }

  _bottomBar() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: homeController.selectedIndex.value,
        onTap: (index) {
          homeController.selectedIndex.value = index;
        },
        selectedIconTheme: const IconThemeData(color: AppColors.blueColor),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedLabelStyle: const TextStyle(
          fontSize: 16,
        ),
        selectedItemColor: AppColors.blueColor,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        items: [
          BottomNavigationBarItem(
              label: "explore".tr,
              icon: Icon(IconAssets.editIcon),
              backgroundColor: isSelected(0)),
          BottomNavigationBarItem(
              label: "feed".tr,
              icon: Icon(IconAssets.calenderIcon),
              backgroundColor: isSelected(1)),
          BottomNavigationBarItem(
              label: "profile".tr,
              icon: Icon(IconAssets.personIcon),
              backgroundColor: isSelected(2)),
        ],
      ),
    );
  }
}
