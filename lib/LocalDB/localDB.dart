import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static const nkey = "dsfdsfdfsda";
  static const pkey = "rgeudfhjjrigknj";
  static const ikey = "weruygvbngtfdcvfd";
  static const ekey = "qpowskdjcmnpwslkdmc";
  static const uidKey = "wepokijfrhhkdmc";

  static Future<bool> saveUserID(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(uidKey);
  }

  static Future<bool> removeUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(uidKey);
  }

  static Future<bool> saveName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nkey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nkey);
  }

  static Future<bool> savePhone(String phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pkey, phone);
  }

  static Future<String?> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(pkey);
  }

  static Future<bool> saveImage(String image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ikey, image);
  }

  static Future<String?> getImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ikey);
  }

  static Future<bool> saveEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ekey, email);
  }

  static Future<String?> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ekey);
  }
}
