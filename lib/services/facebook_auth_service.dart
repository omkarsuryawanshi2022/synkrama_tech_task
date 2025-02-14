import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        return await FacebookAuth.instance.getUserData();
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
    return null;
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}
