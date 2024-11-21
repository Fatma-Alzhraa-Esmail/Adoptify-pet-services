class TopServices {
  final String? image;
  final String? ServicesName;
 final double? price;
 final double? rating;
 final String? title;
  final double? n_rating;

  TopServices({this.image, this.ServicesName,this.n_rating,this.price,this.rating,this.title});
  static List<TopServices> TopServicesCard() {
    return [
     
      TopServices(
        image: 'assets/images/trip2.jpg',
        ServicesName: 'trip',
        n_rating: 1.565,
        price: 38,
        rating: 3.5,
        title: 'Dog Park Trips'
        
        
      ),
      TopServices(
        image: 'assets/images/Trimming Hair.jpg',
        ServicesName: 'service',
        n_rating: 2.368,
        price: 38,
        rating: 4.8,
        title: 'Trimming Hair'
      ),
     TopServices(
        image: 'assets/images/trip.jpg',
        ServicesName: 'trip',
        n_rating: 1.565,
        price: 38,
        rating: 3.5,
        title: 'Dog Park Trips'
        
        
      ),
    ];
  }
}
