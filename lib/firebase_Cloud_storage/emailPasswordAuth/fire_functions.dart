import 'package:firebase_auth/firebase_auth.dart';

class FireBaseHelper {
  //created object for firebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;
  //The currentUser property of the FirebaseAuth instance:
  // if you are sure the user is currently signed-in,
 // you can access the User from the currentUser property:
  get user => auth.currentUser;
  ///user signup
  Future<String?> registerUser(
      {required String email, required String pwd}) async {
    try {
      ///To create a new user account with a password,
      /// call the createUserWithEmailAndPassword() method:
    await  auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );

      ///or return null can give anything what we want to return
      return null;
    } on FirebaseAuthException catch (e) {
      ///for custom error message we can give below like this
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      ///default error message from firebase we can give below like this
      return e.message;
    } catch (e) {
      print(e);
    }
  }
  //SignIn User
  Future<String?> loginUser(
      {required String email, required String pwd}) async {
    try {
     await auth.signInWithEmailAndPassword(email: email, password: pwd);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
    }
  }
  Future<void> logout()
     async {
        auth.signOut();
}
}
