import 'package:allevents/Modal/categoryDataREsponseModal.dart';
import 'package:allevents/Themes/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Item productDetails = Get.arguments['data'];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          productDetails.eventname.toString(),
          style: Get.textTheme.titleMedium,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.download))],
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
                    icon: const Icon(
                      Icons.star_border,
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
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage(
                                    // productDetails.,
                                    ""),
                              ),
                            )),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rowText(icon: Icons.calendar_month, text: "Date & Time"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text(
                        productDetails.startTimeDisplay.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Get.textTheme.labelMedium,
                      ),
                    ),
                    _rowText(icon: Icons.location_on_outlined, text: "Vanue"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text(
                        productDetails.venue!.fullAddress.toString(),
                        style: Get.textTheme.labelMedium,
                      ),
                    ),
                    Text(
                      "View Map",
                      style: Get.textTheme.titleMedium,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 200,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Book Now"))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                      child: Text(
                        productDetails.eventname.toString(),
                        style: Get.textTheme.labelMedium,
                      ),
                    ),
                    _rowText(
                        icon: Icons.door_back_door, text: "Event's Photos"),
                    const SizedBox(height: 5),
                    Container(
                      height: 150,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                  productDetails.thumbUrlLarge.toString()),
                              fit: BoxFit.fill)),
                    ),
                    const SizedBox(height: 5),
                    _rowText(
                        icon: Icons.dock, text: "Host Reviews By Attendance"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _rowText({IconData icon = Icons.calendar_month, String text = ""}) {
    return Row(
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
    );
  }
}
