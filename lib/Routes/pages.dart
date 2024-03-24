import 'package:allevents/View/Auth/signInView.dart';
import 'package:allevents/View/eventDetails.dart';
import 'package:get/get.dart';

import '../View/homeView.dart';
part 'routes.dart';

class Pages {
  static List<GetPage> routes = [
    GetPage(
        name: _Paths.HomeView,
        page: () => HomeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.EventDetailView,
        page: () => EventDetailView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.SignInView,
        page: () => SignInView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200))
  ];
}
