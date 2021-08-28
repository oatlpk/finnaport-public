import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleSignIn _googleSignIn;
  bool _signedIn;

  GoogleAuthService() {
    this._googleSignIn = GoogleSignIn();
    this._signedIn = false;
  }

  /// Return bool whether the user is signed in with Google account or not.
  bool get signedIn => this._signedIn;

  /// Trigger login flow with Google account.
  Future<void> login() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      print('cannot login with google');
      return;
    }

    _signedIn = true;
    print('logged in with Google account');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Sign out of Google account.
  void signOut() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
