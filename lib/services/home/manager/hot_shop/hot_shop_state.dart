part of 'hot_shop_cubit.dart';

@immutable
sealed class HotShopState {}

final class HotShopInitial extends HotShopState {}
class HotShopStateLoading
    extends HotShopState {}

class HotShopStateLoaded
    extends HotShopState {
  final List <ProductModel> products;

 HotShopStateLoaded(this.products,);
}

class HotShopStateError
    extends HotShopState {
  final String error;

 HotShopStateError(this.error);
}