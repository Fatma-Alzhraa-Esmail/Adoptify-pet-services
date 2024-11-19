import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';

class CompleteProfile {
  final String? image;
  final String? CompleteProfileName;
  final Function()? route;

  CompleteProfile({this.image, this.CompleteProfileName, this.route});
  static List<CompleteProfile> CreateCompleteProfileCard() {
    return [
      CompleteProfile(
          image: 'assets/images/address-removebg-preview.png',
          CompleteProfileName: 'Address',
          route: () {
            print('object');
            CustomNavigator.push(Routes.address);
          }),
      CompleteProfile(
          image: 'assets/images/payment-removebg-preview.png',
          CompleteProfileName: 'Payment',
          route: () {
            CustomNavigator.push(Routes.addnewpaymentCard);
          }),
      CompleteProfile(
          image: 'assets/images/history-removebg-preview.png',
          CompleteProfileName: 'History',
          route: () {
            CustomNavigator.push(Routes.history);
          }),
    ];
  }
}
