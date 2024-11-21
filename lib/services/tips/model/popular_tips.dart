
class PopularTips {
  final String? image;
  final String? title;
  final String? descriptionPopTips;

  final bool? favourite;

  PopularTips({
    this.image,
    this.title,
    this.descriptionPopTips,
    this.favourite,
  });
  static List<PopularTips> CreateTopShopCard() {
    return [
      PopularTips(
        image: 'assets/images/poptips.jpg',
        title: 'Mystery of cats Food',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
      PopularTips(
        image: 'assets/images/poptips2.jpg',
        title: 'Training dogs at home',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
      PopularTips(
        image: 'assets/images/poptips3.jpg',
        title: 'Vaccistion for cats',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
      PopularTips(
        image: 'assets/images/poptips4.jpg',
        title: 'Small pet sleep',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
      PopularTips(
        image: 'assets/images/top1.png',
        title: 'Mystery of cats Food',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
      PopularTips(
        image: 'assets/images/top1.png',
        title: 'Training dogs at home',
        favourite: false,
        descriptionPopTips: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
      ),
    ];
  }
}
