// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pet_services_app/services/servicesFeatures/bloc/state.dart';
// import 'package:pet_services_app/services/servicesFeatures/model/service_model.dart';
// import 'package:pet_services_app/services/servicesFeatures/model/services_feature_category.dart';
// import 'package:pet_services_app/services/servicesFeatures/repo/services_repo.dart';

// // class ServicesFeatureCategoryCubit
// //     extends Cubit<ServicesFeatureCategoryStates> {
// //   ServicesFeatureCategoryCubit() : super(ServicesFeatureCategoryInitialState());

// //   static ServicesFeatureCategoryCubit get(context) => BlocProvider.of(context);
// //   final List serviceFeatureCategoryList =
// //       ServicesFeatureCategory.CreateServicesFeatureCategoryCard();

// //   int currentIndex = 0;

// //   void changeIndex(int index) {
// //     currentIndex = index;
// //     emit(ServiceChangeCategoryState());
// //   }

// //   List<String?> categories = [];
// //   List<String?> categoriesImage = [];
// //   dynamic selectedCat;

// //  getCategories() {
// //     for (var val in ServicesModel.CreateServicesFeatureCategoryCard()) {
// //       if (!categories.contains(val.category)) {
// //         categories.add(val.category);
// //         // print('ffff$categories');

// //         categoriesImage.add(val.categoryImage);
// //       }
// //     }
// //     emit(ServiceCategoryState());

// //     return [categories,categoriesImage];
// //   }

// //   List<ServicesModel> productsBasedCategories = [];
// //   Future<List<ServicesModel>> getProducts(String cat) async {
// //     productsBasedCategories = [];
// //     for (var val in ServicesModel.CreateServicesFeatureCategoryCard()) {
// //       if (val.category == cat) {
// //         productsBasedCategories.add(val);
// //         print(val.title);
// //       }
// //     }
// //     emit(productsBasedCategoriesState());
// //     return productsBasedCategories;
// //   }
// // }

// class ServicesFeatureCategoryCubit
//     extends Cubit<ServicesFeatureCategoryStates> {
//   ServicesFeatureCategoryCubit() : super(Loading()) {
//     getServices();
//   }
//   //============================================================================
//   //============================================================================ Variables
//   //============================================================================
//   List<ServicesModel> pets = [];
//   ServicesRepo _repo = ServicesRepo();
//   int selectedCategoryId = 0;
//   //============================================================================
//   //============================================================================ Functions
//   //============================================================================

//   Future<void> getServices() async {
//     emit(Loading());
//     await Future.delayed(const Duration(seconds: 2));
//     try {
//       // pets = await _repo.getPets();
//       // if(pets.isNotEmpty)
//       pets = [
//         ServicesModel(
//             category: ServiceCategories(category: 'Grooming'),
//             categoryImage:
//                 ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//             categoryId: ServiceCategories(categoryId: 1),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             id: 1,
//             image: 'assets/images/trimming hairr.jpg',
//             price: 38,
//             rating: Rating(rate: 4.8),
//             tag: 'hair',
//             title: 'Trimming Hair',
//             count: Rating(count: 2368)),
//         //
//         ServicesModel(
//             category: ServiceCategories(category: 'Grooming'),
//             categoryImage:
//                 ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//             categoryId: ServiceCategories(categoryId: 1),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             id: 2,
//             image: 'assets/images/spa bath.jpg',
//             price: 25,
//             rating: Rating(rate: 4.8),
//             tag: 'Walk or Visit',
//             title: 'Spa Bath',
//             count: Rating(count: 2368)),
//         //
//         ServicesModel(
//             category: ServiceCategories(category: 'Grooming'),
//             categoryImage:
//                 ServiceCategories(categoryImage: 'assets/images/grooming.png'),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             categoryId: ServiceCategories(categoryId: 1),
//             id: 3,
//             image: 'assets/images/nails.jpg',
//             price: 28,
//             rating: Rating(rate: 4.8),
//             tag: 'Walk or Visit',
//             title: 'Nail',
//             count: Rating(count: 2368)),
//         ServicesModel(
//             category: ServiceCategories(category: 'Hotel'),
//             categoryImage:
//                 ServiceCategories(categoryImage: 'assets/images/hotel.png'),
//             categoryId: ServiceCategories(categoryId: 2),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             id: 4,
//             image: 'assets/images/nails.jpg',
//             price: 28,
//             rating: Rating(rate: 4.8),
//             tag: 'Walk or Visit',
//             title: 'Nail',
//             count: Rating(count: 2368)),
//         ServicesModel(
//             category: ServiceCategories(category: 'Vaccination'),
//             categoryImage: ServiceCategories(
//                 categoryImage: 'assets/images/vaccination.png'),
//             categoryId: ServiceCategories(categoryId: 3),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             id: 5,
//             image: 'assets/images/nails.jpg',
//             price: 28,
//             rating: Rating(rate: 4.8),
//             tag: 'Walk or Visit',
//             title: 'Nail',
//             count: Rating(count: 2368)),
//         ServicesModel(
//             category: ServiceCategories(category: 'Care'),
//             categoryImage:
//                 ServiceCategories(categoryImage: 'assets/images/care.png'),
//             categoryId: ServiceCategories(categoryId: 4),
//             description: 'jhjujghujygvjyh khbukygvhj hhjik hhihuhug',
//             id: 6,
//             image: 'assets/images/nails.jpg',
//             price: 28,
//             rating: Rating(rate: 4.8),
//             tag: 'Walk or Visit',
//             title: 'Nail',
//             count: Rating(count: 2368)),
//       ];
//       emit(Done());
//       // else emit(Empty());
//     } catch (e) {
//       emit(Error());
//     }
//   }

//   List<String?> categories = [];
//   getCategories(List<ServicesModel> pets) {
//     for (var val in pets) {
//       print('pets${pets}');
//       if (!categories.contains(val.category)) {
//         categories.add(val.category!.category);
//         print('ffff$categories');

//         // categoriesImage.add(val.categoryImage);
//       }
//     }
//     emit(Loading());

//     return categories;
//   }

//   Future<void> getSercicesByCategory(int categoryId) async {
//     selectedCategoryId = categoryId;
//     emit(Done());
//     emit(Loading());
//     await Future.delayed(const Duration(seconds: 2));
//     try {
//       // pets = await _repo.getPets(categoryId: categoryId);
//       // if (pets.isNotEmpty)
//       pets = [];
//       for (int x = 0; x < categoryId; x++) {
//         // pets.add(
//         // PetModel(
//         //   name: "Cat 1",
//         //   imagePath: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg",
//         //   rate: 3.2,
//         //   price: 300,
//         //   id: 1,
//         // ),
//         // );
//       }
//       emit(Done());
//       // else
//       // emit(Empty());
//     } catch (e) {
//       emit(Error());
//     }
//   }

//   final List<ServicesModel> services =
//       ServicesModel.CreateServicesFeatureCategoryCard();
//   // var category;
//   // var products;
//   // getCategoriesAndRelatedProducts() {
//   //   for (int index = 0; index < services.length; index++) {
//   //     category = services[index].category?.category;

//   //   }
//   //    products = services
//   //         .where((service) => service.category?.category == category)
//   //         .toList();
//   //   return [category, products];
//   // }

//   // List<String> extractCategories(List<ServicesModel> services) {
//   //   List<String> categories = [];
//   //   for (var service in services) {
//   //     if (!categories.contains(service.category?.category)) {
//   //       categories.add(service.category!.category!);
//   //     }
//   //   }
//   //   return categories;
//   // }

//   List<String> extractCategories(List<ServicesModel> services) {
//     List<String> categories = [];
//     for (var service in services) {
//       if (service.category?.category != null &&
//           !categories.contains(service.category?.category)) {
//         categories.add(service.category!.category!);
//       }
//     }
//     return categories;
//   }

//   List<ServicesModel> extractProductsByCategory(
//       List<ServicesModel> services, String category) {
//     List<ServicesModel> products = [];
//     for (var service in services) {
//       if (service.category?.category == category) {
//         products.add(service);
//       }
//     }
//     return products;
//   }

//   List<ServicesModel> allServices =
//       ServicesModel.CreateServicesFeatureCategoryCard();
//   List categoriess = [];
//   displayCategories() {
//     List<String> categories = extractCategories(allServices);
//     for (var category in categories) {
//       if (!categoriess.contains(category)) {
//         categoriess.add(category);
//       }
//       print('Category: $category');
//     }
//     return categoriess;
//   }

//   var productss = [];
//   displayProductsByCategory(String category) {
//     List<ServicesModel> products =
//         extractProductsByCategory(allServices, category);
//     for (var product in products) {
//       if (!productss.contains(product)) {
//         productss.add(product);
//       }
//       print('Product: ${product.title}');
//     }
//     return productss;
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/servicesFeatures/model/services_list_model.dart';

// Events
abstract class CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final Category category;

  SelectCategoryEvent(this.category);
}

// States
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySelected extends CategoryState {
  final Category category;

  CategorySelected(this.category);
}

// BLoC
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  List<Category> categories = [
  Category(
    id: '1',
    name: 'Grooming',
    imageUrl: 'assets/images/grooming.png',
    products: [
      Product(
        name: 'Trimming Hair',
        price:38,
        imageUrl: 'assets/images/trimming hairr.jpg',
      ),
      Product(
        name: 'Spa Bath',
        price:  25,
        imageUrl: 'assets/images/spa bath.jpg',
      ),
    ],
  ),
  Category(
    id: '2',
    name: 'Hotel',
    imageUrl: 'assets/images/hotel.png',
    products: [
      Product(
        name: 'Nail',
        price: 28,
        imageUrl: 'assets/images/nails.jpg',
      ),
       Product(
        name: 'Grooming',
        price:  25,
        imageUrl: 'assets/images/spa bath.jpg',
      ),
    ],
  ),


  Category(
    id: '3',
    name: 'Vaccination',
    imageUrl: 'assets/images/vaccination.png',
    products: [
      Product(
        name: 'Nail',
        price: 28,
        imageUrl: 'assets/images/nails.jpg',
      ),
       Product(
        name: 'Grooming',
        price:  25,
        imageUrl: 'assets/images/spa bath.jpg',
      ),
    ],
  ),
  Category(
    id: '4',
    name: 'Care',
    imageUrl: 'assets/images/care.png',
    products: [
      Product(
        name: 'Nail',
        price: 28,
        imageUrl: 'assets/images/nails.jpg',
      ),
       Product(
        name: 'Grooming',
        price:  25,
        imageUrl: 'assets/images/spa bath.jpg',
      ),
    ],
  ),
];
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is SelectCategoryEvent) {
      yield CategorySelected(event.category);
    }
  }
}