import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedTabView extends StatelessWidget {
  const FeedTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Comming soon",
        style: Get.textTheme.titleLarge,
      ),
    );
  }
}
