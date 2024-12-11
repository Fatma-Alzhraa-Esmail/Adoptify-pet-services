part of 'top_services_cubit.dart';

@immutable
sealed class TopServicesState {}

final class TopServicesStateInitial extends TopServicesState {}
class TopServicesStatesLoading
    extends TopServicesState {}

class TopServicesStatesLoaded
    extends TopServicesState {
  final List <ProductModel> products;

 TopServicesStatesLoaded(this.products,);
}

class TopServicesStatesError
    extends TopServicesState {
  final String error;

 TopServicesStatesError(this.error);
}

