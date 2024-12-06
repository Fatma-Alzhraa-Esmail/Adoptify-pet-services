part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
class ProductsLoading
    extends ProductState {}

class ProductsLoaded
    extends ProductState {
  final List<ProductModel> products;

  ProductsLoaded(this.products,);
}

class ProductsError
    extends ProductState {
  final String error;

  ProductsError(this.error);
}

