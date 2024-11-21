import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/shop/bloc/shop_state.dart';
import 'package:peto_care/services/shop/model/shop_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopChangeCategoryState());

  static ShopCubit get(context) => BlocProvider.of(context);
  List<ShopCategory> Categories = [
    ShopCategory(
      id: 1,
      imageUrl: "assets/images/furniture.png",
      title: "Furniture",
      products: [
        ShopProduct(
          name: "Cat house",
          price: 39,
          imageUrl: "assets/images/catHouse.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 4.8,
        ),
        ShopProduct(
          name: "Carrie",
          price: 13,
          imageUrl: "assets/images/carrie.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 3.8,
        ),
        ShopProduct(
          name: "Buffer",
          price: 47,
          imageUrl: "assets/images/buffer.png",
          count: 2578,
          description: "cat house dsmdakf slkdnsgk",
          rating: 2.8,
        ),
        ShopProduct(
          name: "Tree house",
          price: 13,
          imageUrl: "assets/images/treeHouse.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 4.0,
        ),
        ShopProduct(
          name: "Camp",
          price: 23,
          imageUrl: "assets/images/camp.png",
          count: 298,
          description: "cat house dsmdakf slkdnsgk",
          rating: 2.8,
        ),
        ShopProduct(
          name: "Strewberry",
          price: 13,
          imageUrl: "assets/images/housestroperry.png",
          count: 5678,
          description: "cat house dsmdakf slkdnsgk",
          rating: 3.4,
        ),
      ],
    ),

    //2
    ShopCategory(
      id: 2,
      imageUrl: "assets/images/drug.png",
      title: "Drug",
      products: [
        ShopProduct(
          name: "Cat house",
          price: 39,
          imageUrl: "assets/images/catHouse.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 4.8,
        ),
      ],
    ),
    //3
    ShopCategory(
      id: 3,
      imageUrl: "assets/images/accessory.png",
      title: "Accessory",
      products: [
        ShopProduct(
          name: "Cat house",
          price: 39,
          imageUrl: "assets/images/catHouse.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 4.8,
        ),
      ],
    ),

    //4
    ShopCategory(
      id: 4,
      imageUrl: "assets/images/food.png",
      title: "Food",
      products: [
        ShopProduct(
          name: "Cat house",
          price: 39,
          imageUrl: "assets/images/catHouse.png",
          count: 2345,
          description: "cat house dsmdakf slkdnsgk",
          rating: 4.8,
        ),
      ],
    ),
  ];

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeCategoryState());
  }


  List<ShopCategory> getMainCategories() {
    return Categories;
  }

  List<ShopProduct> getProductsByCategory({int categoryId=1}) {
    final category = Categories.firstWhere((cat) => cat.id == categoryId);
        emit(ShopChangeCategoryState());

    return category.products;
    
  }
    dynamic selectedCat;

  void selectCategory(ShopCategory category) {
    selectedCat = category;
    emit(ShopChangeCategoryState());
  }

}
