import 'package:allevents/Controller/authController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Localization/imageAssets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../Themes/appColors.dart';

// ignore: must_be_immutable
class SignInView extends StatelessWidget {
  SignInView({super.key});
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.allEventImg),
            const SizedBox(
              height: 35,
            ),
            Text(
              "welcomeallEventsapp".tr,
              style: Get.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => isLoading.value
                  ? const CircularProgressIndicator()
                  : SignInButton(Buttons.google,
                      elevation: 5,
                      shape: Border.all(
                          color: AppColors.white54Color,
                          style: BorderStyle.solid), onPressed: () async {
                      isLoading.value = true;
                      await authController.signInWithGoogleMethod();
                      homeController.selectedIndex.value = 0;

                      isLoading.value = false;
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
