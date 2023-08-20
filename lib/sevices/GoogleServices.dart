


import 'package:google_sign_in/google_sign_in.dart';

Future SignInWithGoogle() async{
  await GoogleSignInApi.login();
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}