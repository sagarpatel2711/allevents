import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffects extends StatelessWidget {
  final double width;
  final double? height;
  final double radius;
  final ShapeBorder shape;

  const ShimmerEffects.rectangle(
      {super.key,
      required this.height,
      this.width = double.infinity,
      this.radius = 0,
      this.shape = const RoundedRectangleBorder()});

  const ShimmerEffects.circular({
    super.key,
    this.height,
    this.width = double.infinity,
    this.radius = 10,
    this.shape = const CircleBorder(),
  });

  @override
  Shimmer build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode
          ? const Color.fromRGBO(33, 33, 33, 1)
          : const Color.fromARGB(255, 215, 215, 216),
      highlightColor: Get.isDarkMode
          ? const Color.fromARGB(255, 200, 218, 241)
          : const Color.fromRGBO(245, 245, 245, 1),
      enabled: true,
      child: Container(
        width: radius > 0 ? radius / 2 : width,
        height: radius > 0 ? radius / 2 : height,
        decoration: ShapeDecoration(shape: shape, color: Colors.white),
      ),
    );
  }
}

class ShimmerTextFieldGenerator extends StatelessWidget {
  final double marginTop;
  final double marginBottom;
  final double buttonGap;
  final int count;
  final double height;
  final double seperationHeight;
  final bool isButtonVisible;
  final bool isHeadingVisible;
  final double width;

  const ShimmerTextFieldGenerator(
      {super.key,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.buttonGap = 25,
      required this.count,
      this.isButtonVisible = false,
      this.height = 60,
      this.isHeadingVisible = false,
      this.seperationHeight = 20,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: marginTop),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: count,
          separatorBuilder: (context, index) => SizedBox(
            height: seperationHeight,
          ),
          itemBuilder: (context, index) => Column(children: [
            isHeadingVisible
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: ShimmerEffects.rectangle(
                        height: 17,
                        width: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            isHeadingVisible
                ? const SizedBox(
                    height: 5,
                  )
                : const SizedBox.shrink(),
            ShimmerEffects.rectangle(
              width: width,
              height: height,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ]),
        ),
        isButtonVisible ? SizedBox(height: buttonGap) : const SizedBox.shrink(),
        isButtonVisible
            ? ShimmerEffects.rectangle(
                height: 50,
                width: Get.width / 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            : const SizedBox.shrink(),
        SizedBox(height: marginBottom),
      ],
    );
  }
}

class ShimmerGridViewGenerator extends StatelessWidget {
  final double marginTop;
  final double marginBottom;
  final double buttonGap;
  final int count;
  final double? height;
  final double axisSpacing;
  final bool isButtonVisible;
  final bool isHeadingVisible;
  final double width;

  const ShimmerGridViewGenerator(
      {super.key,
      this.marginTop = 0,
      this.marginBottom = 0,
      this.buttonGap = 25,
      required this.count,
      this.isButtonVisible = false,
      this.height,
      this.isHeadingVisible = false,
      this.axisSpacing = 20,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: marginTop),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: count,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: axisSpacing,
              mainAxisSpacing: axisSpacing,
              mainAxisExtent: height),
          itemBuilder: (context, index) => Column(
            children: [
              isHeadingVisible
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: ShimmerEffects.rectangle(
                        height: 17,
                        width: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  : const SizedBox.shrink(),
              isHeadingVisible
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox.shrink(),
              ShimmerEffects.rectangle(
                width: width,
                height: height,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        isButtonVisible ? SizedBox(height: buttonGap) : const SizedBox.shrink(),
        isButtonVisible
            ? ShimmerEffects.rectangle(
                height: 50,
                width: Get.width / 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            : const SizedBox.shrink(),
        SizedBox(height: marginBottom),
      ],
    );
  }
}
