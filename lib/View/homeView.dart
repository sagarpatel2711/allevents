import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/View/TabView/exploreTabView.dart';
import 'package:allevents/View/TabView/feedTabView.dart';
import 'package:allevents/View/TabView/profileTabView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/appColors.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  ApiController apiController = Get.put(ApiController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Text(
            "All Events",
            style: Get.textTheme.titleMedium,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )
          ],
        ),
        body: IndexedStack(
          index: homeController.selectedIndex.value,
          children: [ExploreTabView(), FeedTabView(), ProfileTabView()],
        ),
        bottomNavigationBar: Obx(() => _bottomBar()),
      ),
    );
  }

  Color isSelected(int index) {
    if (homeController.selectedIndex.value == index) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  _bottomBar() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
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
              label: "Explore".tr,
              icon: Icon(Icons.edit_document),
              backgroundColor: isSelected(0)),
          BottomNavigationBarItem(
              label: "Feed".tr,
              icon: Icon(Icons.calendar_month),
              backgroundColor: isSelected(1)),
          BottomNavigationBarItem(
              label: "Profile".tr,
              icon: const Icon(CupertinoIcons.person_alt_circle),
              backgroundColor: isSelected(2)),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(context: context, delegate: SearchBarDelegate());
      },
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestions based on the query here
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text('Suggestion $index'),
        onTap: () {
          // Handle suggestion selection
          showResults(context);
        },
      ),
      itemCount: 5,
    );
  }
}
