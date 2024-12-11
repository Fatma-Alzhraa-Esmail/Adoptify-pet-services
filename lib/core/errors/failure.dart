
abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}
class FirebaseFailure extends Failure {
  FirebaseFailure(super.errMessage);

  factory FirebaseFailure.fromFirebaseError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return FirebaseFailure('The email address is invalid.');
      case 'user-disabled':
        return FirebaseFailure('This user account has been disabled.');
      case 'user-not-found':
        return FirebaseFailure('No user found with this email.');
      case 'wrong-password':
        return FirebaseFailure('Incorrect password. Please try again.');
      case 'email-already-in-use':
        return FirebaseFailure('This email is already in use.');
      case 'weak-password':
        return FirebaseFailure('Your password is too weak.');
      case 'permission-denied':
        return FirebaseFailure('You do not have permission to perform this action.');
      case 'unavailable':
        return FirebaseFailure('Service is currently unavailable. Please try again later.');
      case 'network-request-failed':
        return FirebaseFailure('No internet connection. Please check your network.');
      case 'timeout':
        return FirebaseFailure('Operation timed out. Please try again.');
      default:
        return FirebaseFailure('An unexpected error occurred. Please try again.');
    }
  }
}
