import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/myaccount/bloc/state.dart';
import 'package:adoptify/services/myaccount/model/accepted_payment_card.dart';
import 'package:adoptify/services/myaccount/model/address.dart';
import 'package:adoptify/services/myaccount/model/complete_profile.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileStates> {
  CompleteProfileCubit() : super(CompleteProfileInitialState());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);
    final List completeprofilee=CompleteProfile.CreateCompleteProfileCard();
    final List acceptedPaymentCard=AcceptedPaymentCard.CreateCompleteProfileCard();
    final List addressInfo=AddressDetails.CreateAddressDetailsCard();


}