import 'package:allevents/Modal/userResponseModal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LocalDB/localDB.dart';
import '../Routes/pages.dart';
import '../Utility/logger.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  Future<User?> signInWithGoogleMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      await createNewUser(
        phoneNumber: user!.phoneNumber.toString(),
        uID: user.uid,
        userEmail: user.email.toString(),
        userName: user.displayName.toString(),
        userPhotoUrl: user.photoURL.toString(),
      );
      await LocalDB.saveName(user.displayName.toString());
      await LocalDB.saveImage(user.photoURL.toString());
      await LocalDB.savePhone(user.phoneNumber.toString());
      await LocalDB.saveUserID(user.uid.toString());
      await LocalDB.saveEmail(user.email.toString());

      assert(!user.isAnonymous);
      final User? currentUser = _auth.currentUser;
      assert(currentUser!.uid == user.uid);

      Get.offAllNamed(Routes.HomeView);
      update();
      return user;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  createNewUser(
      {String userName = "",
      String userEmail = "",
      String userPhotoUrl = "",
      String uID = "",
      String phoneNumber = ""}) async {
    try {
      if (await getUser()) {
        logger.i("User already exists");
      } else {
        DocumentReference doc = userCollection.doc();

        UserResponceModal userResponceModal = UserResponceModal(
            id: doc.id,
            email: userEmail,
            name: userName,
            phoneNumber: phoneNumber,
            profileImg: userPhotoUrl);
        final userJson = userResponceModal.toJson();
        doc.set(userJson);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> getUser() async {
    String user = "";
    await _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .get()
        .then((value) async {
      user = value.data().toString();
    });
    if (user.toString() == "null") {
      return false;
    } else {
      await _firestore
          .collection('users')
          .doc(_currentUser.uid)
          .get()
          .then((value) async {
        user = value.data().toString();
        await LocalDB.saveImage(value["profileImg"]);
        await LocalDB.saveName(value["name"]);
        await LocalDB.savePhone(value["phoneNumber"]);
      });
      return true;
    }
  }

  @override
  void onInit() {
    userCollection = _firestore.collection("users");
    super.onInit();
  }

  Future<bool> googleSignOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();

      await LocalDB.removeUserID();

      Get.offAllNamed(Routes.SignInView);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
