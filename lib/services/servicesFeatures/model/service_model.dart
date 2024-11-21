


// class ServicesModel {
//   ServiceCategories? category;
//   ServiceCategories? categoryImage;
//   ServiceCategories? categoryId;
//   dynamic id;
//   String? title;
//   dynamic price;
//   String? description;
//   String? image;
//   Rating? rating;
//   String? tag;
//   dynamic count;

//   ServicesModel(
//       {this.id,
//       this.title,
//       this.price,
//       this.description,
//       this.category,
//       this.image,
//       this.rating,
//       this.categoryImage,
//       this.tag,
//       this.count,
//       this.categoryId});
//   static List<ServicesModel> CreateServicesFeatureCategoryCard() {
//     return [
//       ServicesModel(
//           category: ServiceCategories(category: 'Grooming'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//           categoryId: ServiceCategories(categoryId: 1),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           id: 1,
//           image: 'assets/images/trimming hairr.jpg',
//           price: 38,
//           rating: Rating(rate: 4.8),
//           tag: 'hair',
//           title: 'Trimming Hair',
//           count: Rating(count: 2368)),
//       //
//       ServicesModel(
//           category: ServiceCategories(category: 'Grooming'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//           categoryId: ServiceCategories(categoryId: 1),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           id: 2,
//           image: 'assets/images/spa bath.jpg',
//           price: 25,
//           rating: Rating(rate: 4.8),
//           tag: 'Walk or Visit',
//           title: 'Spa Bath',
//           count: Rating(count: 2368)),
//       //
//       ServicesModel(
//           category: ServiceCategories(category: 'Grooming'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           categoryId: ServiceCategories(categoryId: 1),
//           id: 3,
//           image: 'assets/images/nails.jpg',
//           price: 28,
//           rating: Rating(rate: 4.8),
//           tag: 'Walk or Visit',
//           title: 'Nail',
//           count: Rating(count: 2368)),
//       ServicesModel(
//           category: ServiceCategories(category: 'Hotel'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/hotel.png'),
//           categoryId: ServiceCategories(categoryId: 2),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           id: 4,
//           image: 'assets/images/nails.jpg',
//           price: 28,
//           rating: Rating(rate: 4.8),
//           tag: 'Walk or Visit',
//           title: 'Nail',
//           count: Rating(count: 2368)),
//       ServicesModel(
//           category: ServiceCategories(category: 'Vaccination'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/vaccination.png'),
//           categoryId: ServiceCategories(categoryId: 3),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           id: 5,
//           image: 'assets/images/nails.jpg',
//           price: 28,
//           rating: Rating(rate: 4.8),
//           tag: 'Walk or Visit',
//           title: 'Nail',
//           count: Rating(count: 2368)),
//       ServicesModel(
//           category: ServiceCategories(category: 'Care'),
//           categoryImage:
//               ServiceCategories(categoryImage: 'assets/images/care.png'),
//           categoryId: ServiceCategories(categoryId: 4),
//           description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//           id: 6,
//           image: 'assets/images/nails.jpg',
//           price: 28,
//           rating: Rating(rate: 4.8),
//           tag: 'Walk or Visit',
//           title: 'Nail',
//           count: Rating(count: 2368)),
//       //
//     ];
//   }

//   // PetModel.fromJson(Map<String, dynamic> json) {
//   //   name = json['name'];
//   //   imagePath = json['imagePath'];
//   //   rate = (json['rate']??0).toDouble();
//   //   price = (json['price']??0).toDouble();
//   //   id = json['id'];
//   // }
//   ServicesModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     price = json['price'];
//     description = json['description'];
//     category = json['category'];
//     image = json['image'];
//     rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
//     count = json['rating'] != null ? Rating.fromJson(json['count']) : null;
//     category = json['category'] != null
//         ? ServiceCategories.fromJson(json['category'])
//         : null;
//     categoryId = json['categoryId'] != null
//         ? ServiceCategories.fromJson(json['categoryId'])
//         : null;
//     categoryImage = json['categoryImage'] != null
//         ? ServiceCategories.fromJson(json['categoryImage'])
//         : null;
//   }
// }

// class Rating {
//   dynamic rate;
//   dynamic count;

//   Rating({this.rate, this.count});

//   Rating.fromJson(Map<String, dynamic> json) {
//     rate = json['rate'];
//     count = json['count'];
//   }
// }

// class ServiceCategories {
//   int? categoryId;
//   String? category;
//   String? categoryImage;
//   ServiceCategories({this.category, this.categoryId, this.categoryImage});
//   ServiceCategories.fromJson(Map<String, dynamic> json) {
//     categoryId = json['categoryId'];
//     category = json['category'];
//     categoryImage = json['categoryImage'];
//   }
// }
