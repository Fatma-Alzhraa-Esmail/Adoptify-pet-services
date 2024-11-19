import 'package:adoptify/base/models/user_model.dart';
import 'package:adoptify/handlers/shared_handler.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:adoptify/services/register/logic/google_auth_cubit/google_auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthStateInitial());
  /////////////////////////////////////////////////////
  ///////////////////////////////////////////////////// Variables
  /////////////////////////////////////////////////////
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  bool isLoading = false;

  /////////////////////////////////////////////////////
  ///////////////////////////////////////////////////// Functions
  /////////////////////////////////////////////////////
  Future<void> signUpWithGoogle() async {
    emit(GoogleAuthLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user already exists in Firestore
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
      isLoading = true;

      if (userSnapshot.exists) {
        // User already exists, return their account data
        final userData = userSnapshot.data();
        print('User already exists: $userData');
        SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
        CustomNavigator.push(Routes.Navigation, clean: true);
      } else {
        // User does not exist, create a new account
        await _saveUserData(userCredential.user!);
        print('New user created: ${userCredential.user!.uid}');
        SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
        CustomNavigator.push(Routes.Navigation, clean: true);
      }

      SharedHandler.instance!
          .setData(SharedKeys().user, value: userCredential.user!.uid);

      emit(GoogleAuthStateSuccess());
      isLoading = false;
    } catch (e) {
      isLoading = false;

      print(e.toString());
      emit(GoogleAuthStateFailaure(error: 'Something Went Wrong!'));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    SharedHandler.instance!
        .clear(keys: [SharedKeys().isLogin, SharedKeys().isRegister,SharedKeys().user]);

  }

  Future<void> _saveUserData(User user) async {
    final userModel = UserModel(
      name: user.displayName,
      email: user.email,
      image: user.photoURL,
      phone: user.phoneNumber,
    );

    await _usersCollection.doc(user.uid).set(userModel.toJson());
  }
}
