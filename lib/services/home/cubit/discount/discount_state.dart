part of 'discount_cubit.dart';

@immutable
sealed class DiscountState {}

final class DiscountInitial extends DiscountState {}
class DiscountProductsLoading
    extends DiscountState {}

class DiscountProductsLoaded
    extends DiscountState {
  final List<ProductModel> products;

  DiscountProductsLoaded(this.products,);
}

class DiscountProductsError
    extends DiscountState {
  final String error;

  DiscountProductsError(this.error);
}
