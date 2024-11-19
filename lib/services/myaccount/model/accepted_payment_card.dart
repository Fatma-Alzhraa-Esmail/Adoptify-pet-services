

class AcceptedPaymentCard {
  final String? image;
  final Function()? route;

  AcceptedPaymentCard({this.image, this.route});
  static List<AcceptedPaymentCard> CreateCompleteProfileCard() {
    return [
      AcceptedPaymentCard(
        image: 'assets/images/visa1.png',
        // route: () {
        //   print('object');
        //   CustomNavigator.push(Routes.addnewpaymentCard);
        // }
      ),
      AcceptedPaymentCard(
               image: 'assets/images/visa4.png',

        // route: () {
        //   CustomNavigator.push(Routes.addnewpaymentCard);
        // }
      ),
      AcceptedPaymentCard(
       image: 'assets/images/visa3.png',
        // route: () {
        //   CustomNavigator.push(Routes.addnewpaymentCard);
        // }
      ),
      AcceptedPaymentCard(
        image: 'assets/images/visa2.png',
        // route: () {
        //   CustomNavigator.push(Routes.addnewpaymentCard);
        // }
      ),
    ];
  }
}
