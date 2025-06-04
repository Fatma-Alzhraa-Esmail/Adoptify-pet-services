import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/address/model/address.dart';

abstract class AddressRepo {
  Stream<Either<Failure, List<AddressModel>>> getAllUserAdressess();
  Future<Either<Failure, AddressModel>> addNewAddress(AddressModel addressModel);
  Future<Either<Failure, AddressModel>> editAddress(AddressModel addressModel);
}