import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

get user => _auth.currentUser;

String? name;
String? email;
String? imageUrl;
int? statusLulus;
String? role = "PolinemaDigitals' User";

Future<FirebaseApp> _initilizedFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

Future signUp(
    {required String name,
    required String email,
    required String nim,
    required String password,
    required bool isLulus,
    required String nohp}) async {
  String? url = dotenv.env['BASE_URL'];
  Dio dio = Dio();

  try {
    int nimInt;
    int lulusBool = (isLulus == true) ? 1 : 0;
    nimInt = int.parse(nim);
    String uri =
        "$url/api/user?name=$name&email=$email&nim=$nimInt&nohp=$nohp&isLulus=$lulusBool&password=$password";
    Response response;
    response = await dio.post(uri);

    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final User? user = result.user;
    await user?.updateDisplayName(name);
    await user?.updatePhotoURL(
        'https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80');
    return user;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<int> checkUserStatus(String email) async {
  final dio = Dio();
  String? url = dotenv.env['BASE_URL'];
  final apiUrl = '$url/api/user/find/$email';

  try {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final int isLulus = response.data['user'][0]['isLulus'];
      return isLulus;
    } else {
      throw Exception('Failed to load data from API');
    }
  } catch (e) {
    throw Exception('Error connecting to the API');
  }
}

Future signInWithEmailPassword(
    {required String email, required String password}) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final User? user = credential.user;

    if (user != null) {
      // Pengecekkan DisplayName
      (user.displayName == null) ? name = "User" : name = user.displayName;

      // Pengecekkan Photo
      (user.photoURL == null)
          ? imageUrl =
              'https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80'
          : imageUrl = user.photoURL;

      // Pengecekkan EMAIL
      (user.email == null) ? "Email tidak ada" : email = user.email!;

      if (email.contains("polinema")) {
        role = "Student of Polinema";
      }

      // Only taking the first part of the name, i.e., First Name
      if (name!.contains(" ")) {
        name = name?.substring(0, name?.indexOf(" "));
      }

      print(email);
      print(imageUrl);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);

      final dataUser = await checkUserStatus(email);

      statusLulus = dataUser;

      // await saveUserInfoToFirestroe(user.uid, name!, email, imageUrl!);

      print("signInWithEmailPassword Succeeded: $user");
      return {'user': user, 'statusUser': statusLulus};
    }
  } on FirebaseAuthException catch (e) {
    return e.message;
  }
}

Future<String?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken);

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  if (user != null) {
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    if (email!.contains("polinema")) {
      role = "Student of Polinema";
    }

    if (name!.contains(" ")) {
      name = name?.substring(0, name?.indexOf(" "));
    }

    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser?.uid);

    // await saveUserInfoToFirestroe(user.uid, name!, email!, imageUrl!);

    print("signinWithGoogle Succeeded: $user");
    return '$user';
  }

  return null;
}

Future<void> saveUserInfoToFirestroe(
    String userId, String name, String email, String image) async {
  // Mengakses Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference userReferense = firestore.collection('users').doc(userId);

  var role = "PolinemaDigital's User";
  if (email.contains("polinema")) {
    role = "Student of Polinema";
  }

  await userReferense
      .set({'name': name, 'email': email, 'imageUrl': imageUrl, 'role': role});
}
