// ignore_for_file: constant_identifier_names

part of 'pages.dart';

abstract class Routes {
  static const ROOT = _Paths.ROOT;
  static const HomeView = _Paths.HomeView;
  static const EventDetailView = _Paths.EventDetailView;
  static const SignInView = _Paths.SignInView;
}

abstract class _Paths {
  static const ROOT = '/';
  static const HomeView = '/HomeView';
  static const EventDetailView = '/EventDetailView';
  static const SignInView = '/SignInView';
}
