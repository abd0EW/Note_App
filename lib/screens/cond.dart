import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User? get user => FirebaseAuth.instance.currentUser;
  Future register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      print("acount create");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("acount login");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future sendEmail() async {
    if (user != null && !user!.emailVerified) {
      print("Send email success");
      await user!.sendEmailVerification();
    } else {}
  }

  Future<bool?> verfifedEmail() async {
    await user!.reload();
    return user?.emailVerified ?? false;
  }

  Future forPassword(String emailresetpassword) async {
    print("password reset send");
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailresetpassword,
    );
  }

  Future deleteUser() async {
    try {
      print("Userdelete");
      await user?.delete();
    } catch (e) {
      print("error is ${e}");
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
