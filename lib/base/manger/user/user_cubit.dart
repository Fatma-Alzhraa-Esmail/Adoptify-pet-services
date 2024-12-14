import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/base/repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());
  final UserRepo userRepo;
  bool userIsLoading = true;

  Future<UserModel?> fetchUserData({required String userId}) async {
    userIsLoading = true;

    var userData = await userRepo.fetchUserData(userId: userId);
    userData.fold(
      (failure) {
        emit(UserError(errMessage: failure.errMessage));
      },
      (userData) {
        print("print useData : $userData");
        emit(UserLoaded(userData: userData));
        userIsLoading = false;
      },
    );
  }
}
