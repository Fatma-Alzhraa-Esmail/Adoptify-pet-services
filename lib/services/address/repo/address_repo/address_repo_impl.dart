import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/address/model/address.dart';
import 'package:peto_care/services/address/repo/address_repo/address_repo.dart';

class AddressRepoImpl extends AddressRepo {
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<Either<Failure, List<AddressModel>>> getAllUserAdressess() {
    try {
      final userId = SharedHandler.instance
          ?.getData(key: SharedKeys().user, valueType: ValueType.string);
      if (userId == null || userId.isEmpty) {
        print("Error: userId is null or empty");
        return Stream.value(Left(FirebaseFailure("User ID is missing or invalid")));
      }

      return _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('Address')
          .snapshots()
          .map<Either<Failure, List<AddressModel>>>((snapshot) {
            try {
              final addressItems = snapshot.docs.map((address) {
                final data = address.data();
                return AddressModel.fromJson({
                  ...data,
                  'id': address.id,
                });
              }).toList();
              print("AddressItems: $addressItems");
              return Right<Failure, List<AddressModel>>(addressItems);
            } catch (e) {
              print("Error mapping addresses: $e");
              return Left(FirebaseFailure(e.toString()));
            }
          })
          .handleError((e) {
            print("Error fetching Addresses: $e");
            if (e is FirebaseException) {
              return Left(FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
            }
            return Left(FirebaseFailure(e.toString()));
          });
    } catch (e) {
      print("Error fetching Addresses: $e");
      return Stream.value(Left(FirebaseFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> addNewAddress(AddressModel addressModel) async {
    final userId = SharedHandler.instance
        ?.getData(key: SharedKeys().user, valueType: ValueType.string);

    try {
      if (userId == null || userId.isEmpty) {
        print("Error: userId is null or empty");
        return Left(FirebaseFailure("User ID is missing or invalid"));
      }

      // Add the new address to Firestore and get the DocumentReference
      final docRef = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('Address')
          .add(addressModel.toJson());

      // Update the document to include its own ID as a field
      await docRef.update({'id': docRef.id});

      // Create a new AddressModel with the document ID included
      final updatedAddressModel = AddressModel.fromJson({
        ...addressModel.toJson(),
        'id': docRef.id,
      });

      return Right(updatedAddressModel);
    } catch (e) {
      print("Error adding address: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> editAddress(AddressModel addressModel) async {
    final userId = SharedHandler.instance
        ?.getData(key: SharedKeys().user, valueType: ValueType.string);

    try {
      if (userId == null || userId.isEmpty) {
        print("Error: userId is null or empty");
        return Left(FirebaseFailure("User ID is missing or invalid"));
      }

      if (addressModel.id == null || addressModel.id!.isEmpty) {
        print("Error: address ID is null or empty");
        return Left(FirebaseFailure("Address ID is missing or invalid"));
      }

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('Address')
          .doc(addressModel.id)
          .update(addressModel.toJson());

      return Right(addressModel);
    } catch (e) {
      print("Error editing address: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}