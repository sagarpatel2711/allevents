import 'package:allevents/Controller/authController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Themes/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Localization/iconAssets.dart';

// ignore: must_be_immutable
class ProfileTabView extends StatelessWidget {
  ProfileTabView({super.key});
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: Get.width,
                color: AppColors.blueColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.whiteColor,
                    backgroundImage:
                        NetworkImage(homeController.photoUrlUser.toString()),
                    maxRadius: 80,
                  ),
                ),
              ),
            ],
          ),
          Text(
            homeController.nameUser.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.titleMedium,
          ),
          Text(
            homeController.emailUser.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.labelMedium,
          ),
          const SizedBox(height: 10),
          _listTile(
            icons: IconAssets.personIcon,
            title: "personaldata".tr,
            onTap: () {},
          ),
          _listTile(
            icons: IconAssets.helpIcon,
            title: "help".tr,
            onTap: () {},
          ),
          _listTile(
            icons: IconAssets.aboutIcon,
            title: "aboutapp".tr,
            onTap: () {},
          ),
          _listTile(
            icons: IconAssets.logoutIcon,
            title: "signout".tr,
            onTap: () async {
              await authController.googleSignOut();
            },
          ),
        ],
      ),
    );
  }

  _listTile(
      {void Function()? onTap,
      IconData icons = Icons.edit,
      String title = ""}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white54Color,
          border: Border.all(color: AppColors.blackColor)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icons,
          color: AppColors.blackColor,
        ),
        title: Text(
          title,
          style: Get.textTheme.titleMedium,
        ),
      ),
    );
  }
}
