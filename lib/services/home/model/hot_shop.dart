
class HotShop {
  final String? image;
  final String? title;
  final double? rating;
  final double? price;

  HotShop({this.image, this.title,this.price,this.rating});
  static List<HotShop> CreateTopShopCard() {
    return [
      HotShop(
        image: 'assets/images/top1.png',
        title: 'Cat house',
        price: 47 ,
        rating: 4,
      ),
      HotShop(
        image: 'assets/images/top2.png',
        title: 'Muzzle',
        price: 13 ,
        rating: 3.2,
      ),
      HotShop(
        image: 'assets/images/top3.png',
        title: 'Rope',
        price: 9 ,
        rating: 3.5,
      ),
      HotShop(
        image: 'assets/images/top4.png',
        title: 'Duck',
        price: 25 ,
        rating: 3,
      ),
      HotShop(
        image: 'assets/images/top55.png',
        title: 'Ball Spikes',
        price: 12 ,
        rating: 4,
      ),
      HotShop(
        image: 'assets/images/top66.png',
        title: 'Bouns',
        price: 20 ,
        rating: 5,
      ),
    ];
  }
}
