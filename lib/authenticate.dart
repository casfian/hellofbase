import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider {
  //1. Create FirebaseAuth Instance
  final FirebaseAuth firebaseAuth;

  //2. Constructor
  AuthenticationProvider(this.firebaseAuth);

  //2.1 Buat getter
  // tanda "?" maksudnya optional
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  //3. Functions utk Register, Login, Logout

  //3.1 register function
  Future<String?> register(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Registered';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //3.2 login function
  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'login';
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //3.3 Logout function
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
