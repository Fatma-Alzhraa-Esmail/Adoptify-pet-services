import 'package:adoptify/base/models/user_model.dart';
import 'package:adoptify/handlers/shared_handler.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';

part 'facebook_auth_state.dart';

class FacebookAuthCubit extends Cubit<FacebookAuthState> {
  FacebookAuthCubit() : super(FacebookAuthInitial());
  /////////////////////////////////////////////////////
  ///////////////////////////////////////////////////// Variables
  /////////////////////////////////////////////////////
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  /////////////////////////////////////////////////////
  ///////////////////////////////////////////////////// Functions
  /////////////////////////////////////////////////////

  Future<void> signUpWithFacebook() async {
    emit(FacebookAuthLoading());

    try {
            isLoading = true;

      List<String> permissions = ['public_profile', 'email'];
      final LoginResult result = await FacebookAuth.instance.login(
          permissions: permissions, loginBehavior: LoginBehavior.dialogOnly);
      print(result);
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Check if the user already exists in Firestore
        final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .get();

        if (userSnapshot.exists) {
          // User already exists, return their account data
          final userData = userSnapshot.data();
          print('User already exists: $userData');
          SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
          CustomNavigator.push(Routes.Navigation);
        } else {
          // User does not exist, create a new account
          await _saveUserDataFacebook(userCredential.user!);
          print('New user created: ${userCredential.user!.uid}');
          SharedHandler.instance!.setData(SharedKeys().isRegister, value: true);
          CustomNavigator.push(Routes.Navigation);
        }

        SharedHandler.instance!
            .setData(SharedKeys().user, value: userCredential.user!.uid);

        emit(FacebookAuthSuccess());
                  isLoading = false;

      } else if (result.status == LoginStatus.cancelled) {
        emit(FacebookAuthStateCancelled());
      } else {
        emit(FacebookAuthStateFailaure(error: 'Something Went Wrong!'));
      }
    } catch (e) {
                isLoading = false;

      print(e.toString());
      emit(FacebookAuthStateFailaure(error: e.toString()));
    }
  }

  Future<void> signOutFaceBook() async {
    await _auth.signOut();
    SharedHandler.instance!.clear(keys: [
      SharedKeys().isLogin,
      SharedKeys().isRegister,
      SharedKeys().user
    ]);
    CustomNavigator.push(Routes.home, clean: true);
  }

  Future<void> _saveUserDataFacebook(User user) async {
    final userModel = UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      image: user.photoURL,
      phone: user.phoneNumber,
    );

    await _usersCollection.doc(user.uid).set(userModel.toJson());
  }
}
