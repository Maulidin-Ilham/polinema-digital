import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

get user => _auth.currentUser;

String? name;
String? email;
String? imageUrl;

Future<FirebaseApp> _initilizedFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

Future signUp({required String email, required String password}) async {
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    final User? user = result.user;
    return user;
  }catch (e) {
    print(e.toString());
    return null;
  }
}

Future signInWithEmailPassword({required String email, required String password}) async {
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = result.user;

    if (user != null){
      //Checking if email and name is null
      if(user.displayName == null){
        name = user.email;
      }else{
        name = user.displayName;
      }

      if(user.photoURL == null){
        imageUrl = 'https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80';
      }else{
        imageUrl = user.photoURL;
      }

      if(user.email == null){
        email = "Email Tidak ada";
      }else{
        email = user.email!;
      }

      // Only taking the first part of the name, i.e., First Name
      if(name!.contains(" ")) {
        name = name?.substring(0, name?.indexOf(" "));
      }

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);

      print("signInWithEmailPassword Succeeded: $user");
      return '$user';
    }
  }on FirebaseAuthException catch(e) {
    return e.message;
  }
}

Future<String?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication?.accessToken,
    idToken: googleSignInAuthentication?.idToken
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  if (user != null){
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    if(name!.contains(" ")){
      name = name?.substring(0, name?.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    
    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    print("signinWithGoogle Succeeded: $user");
    return '$user';
  }
  
  return null;
}