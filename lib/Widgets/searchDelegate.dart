import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Localization/iconAssets.dart';
import '../Themes/appColors.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  ApiController apiController = Get.put(ApiController());
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(IconAssets.clearIcon),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
        ? apiController.categoryItem
        : apiController.categoryItem
            .where(
                (p0) => p0.eventname.toString().contains(query.toLowerCase()))
            .toList();
    return myList.isEmpty
        ? const Center(
            child: Text(
            "No Result Found",
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ))
        : ListView.builder(
            itemBuilder: (context, index) => InkWell(
              onTap: () async {
                Get.toNamed(Routes.EventDetailView,
                    arguments: {'data': myList[index]});
              },
              child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  myList[index].thumbUrl.toString()),
                              fit: BoxFit.fitHeight)),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myList[index].eventname.toString(),
                              style: Get.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              myList[index].label.toString(),
                              style: Get.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              myList[index].location.toString(),
                              style: Get.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 3),
                                            child: const Align(
                                                widthFactor: 0.5,
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 8,
                                                    backgroundImage:
                                                        NetworkImage(""),
                                                  ),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        if (await canLaunchUrl(Uri.parse(
                                            myList[index]
                                                .shareUrl
                                                .toString()))) {
                                          launchUrl(Uri.parse(myList[index]
                                              .shareUrl
                                              .toString()));
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.dry_cleaning_outlined,
                                        color: AppColors.blackColor,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        IconAssets.starIcon,
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
            ),
            itemCount: myList.length >= 3 ? 3 : myList.length,
          );
  }
}
