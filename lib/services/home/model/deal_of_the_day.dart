

class DealOfTheDay {
  final String? image;
  final String? title;
  final double? rating;
  final double? price;
  final double? new_price;
  final int? dis_percentage;
  int timer=0;

  DealOfTheDay(
      {this.image,
      this.title,
      this.price,
      this.rating,
      this.dis_percentage,
      this.new_price,
     required this.timer});
  static List<DealOfTheDay> CreatedealofdayCard() {
    return [
      DealOfTheDay(
        image: 'assets/images/deal1.png',
        title: 'Carrie',
        price: 36,
        rating: 4,
        dis_percentage: 20,
        new_price: 15,
        timer: 24,

        // DateFormat("hh:mm:ss")
      ),
      DealOfTheDay(
        image: 'assets/images/deal2.png',
        title: 'Collar',
        price: 13,
        rating: 3.2,
        dis_percentage: 10,
        new_price: 9,
        timer: 48,
      ),
      DealOfTheDay(
        image: 'assets/images/deal3.png',
        title: 'Chain',
        price: 23,
        rating: 3.5,
        dis_percentage: 25,
        new_price: 7,
        timer: 60,
      ),
      DealOfTheDay(
        image: 'assets/images/top66.png',
        title: 'Bouns',
        price: 20,
        rating: 5,
        dis_percentage: 8,
        new_price: 11,
        timer: 45,
      ),
    ];
  }
}
