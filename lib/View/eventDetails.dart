import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Localization/iconAssets.dart';
import 'package:allevents/Localization/imageAssets.dart';
import 'package:allevents/Modal/categoryDataREsponseModal.dart';
import 'package:allevents/Themes/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class EventDetailView extends StatelessWidget {
  EventDetailView({super.key});
  final LatLng center = const LatLng(23.033000946045, 72.616996765137);
  ApiController apiController = Get.put(ApiController());
  RxList<Item> suggetionItem = <Item>[].obs;

  suggestionList() async {
    suggetionItem.value = apiController.categoryItem;
  }

  @override
  Widget build(BuildContext context) {
    Item productDetails = Get.arguments['data'];
    suggestionList();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          productDetails.eventname.toString(),
          style: Get.textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (await canLaunchUrl(
                    Uri.parse(productDetails.shareUrl.toString()))) {
                  launchUrl(Uri.parse(productDetails.shareUrl.toString()));
                }
              },
              icon: Icon(
                IconAssets.webIcon,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(productDetails.thumbUrl.toString()),
                      fit: BoxFit.fill)),
            ),
            Card(
              child: ListTile(
                title: Text(
                  productDetails.eventnameRaw.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Get.textTheme.titleMedium,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconAssets.starIcon,
                      size: 20,
                      color: AppColors.blackColor,
                    )),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: const Align(
                            widthFactor: 0.5,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.whiteColor,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage(""),
                              ),
                            )),
                      ),
                  ],
                ),
              ),
            ),
            _rowText(icon: IconAssets.calenderIcon, text: "datetime".tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Text(
                productDetails.startTimeDisplay.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Get.textTheme.labelMedium,
              ),
            ),
            _rowText(icon: Icons.location_on_outlined, text: "vanue".tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Text(
                productDetails.venue!.fullAddress.toString(),
                style: Get.textTheme.labelMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "viewmap".tr,
                style: Get.textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(),
                    width: Get.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: center,
                        zoom: 14.0,
                      ),
                      onMapCreated:
                          (GoogleMapController googleMapController) async {},
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("booknow".tr))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Text(
                productDetails.eventnameRaw.toString(),
                style: Get.textTheme.labelMedium,
              ),
            ),
            _rowText(icon: Icons.door_back_door, text: "eventphotos".tr),
            const SizedBox(height: 5),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image:
                          NetworkImage(productDetails.thumbUrlLarge.toString()),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(height: 5),
            _rowText(icon: Icons.dock, text: "hostAttendance".tr),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 80,
              width: Get.width,
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.whiteColor,
                    backgroundImage: AssetImage(ImageAssets.allEventImg),
                    maxRadius: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "sbruniverse".tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.titleLarge,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => Icon(
                            IconAssets.starIcon,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Great",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.blueColor)),
                      onPressed: () {},
                      child: Text(
                        "follow".tr,
                        style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(),
              width: Get.width,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    width: Get.width - 100,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                backgroundImage:
                                    AssetImage(ImageAssets.allEventImg),
                                maxRadius: 35,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "sbruniverse".tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.titleLarge,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemBuilder: (context, _) => Icon(
                                      IconAssets.starIcon,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "1 month ago",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "absolutelyexpect".tr,
                          style: Get.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 400,
              width: Get.width,
              decoration: const BoxDecoration(color: AppColors.white54Color),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "suggestionsforyou".tr,
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: Get.width - 100,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: AppColors.blackColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(suggetionItem[index]
                                            .thumbUrl
                                            .toString()),
                                        fit: BoxFit.fill)),
                              ),
                              Text(
                                suggetionItem[index].eventname.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.labelMedium,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              backgroundImage: NetworkImage(""),
                                            ),
                                          )),
                                    ),
                                ],
                              ),
                              Text(
                                suggetionItem[index].location.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodySmall,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _rowText({IconData icon = Icons.calendar_month, String text = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.greyColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              text,
              style: Get.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
