import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/servicesFeatures/bloc/state.dart';
import 'package:adoptify/services/servicesFeatures/model/services_list_model.dart';

class ServicesFeatureCategoryCubit
    extends Cubit<ServicesFeatureCategoryStates> {
  ServicesFeatureCategoryCubit() : super(ServicesFeatureCategoryInitialState());

  static ServicesFeatureCategoryCubit get(context) => BlocProvider.of(context);
  List<Category> categories = [
    Category(
      id: '1',
      name: 'Grooming',
      imageUrl: 'assets/images/grooming.png',
      products: [
        Product(
          name: 'Trimming Hair',
          price: 38,
          imageUrl: 'assets/images/trimming hairr.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
        ),
        Product(
          name: 'Spa Bath',
          price: 25,
          imageUrl: 'assets/images/spa bath.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 3.8,
          tag: "Walk or Visit",
        ),
        Product(
          name: 'Nail',
          price: 28,
          imageUrl: 'assets/images/nails.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 2.8,
          tag: "Walk or Visit",
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
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 2.8,
          tag: "Walk or Visit",
        ),
        Product(
          name: 'Grooming',
          price: 25,
          imageUrl: 'assets/images/spa bath.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
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
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
        ),
        Product(
          name: 'Grooming',
          price: 25,
          imageUrl: 'assets/images/spa bath.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
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
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
        ),
        Product(
          name: 'Grooming',
          price: 25,
          imageUrl: 'assets/images/spa bath.jpg',
          count: 2368,
          description: "hbhjkvgjch  hvhchfxdfg vgytfrtdsew vfrtdseraer iugi",
          rating: 4.8,
          tag: "hair",
        ),
      ],
    ),
  ];

  dynamic selectedCat;
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ServiceChangeCategoryState());
  }
}
