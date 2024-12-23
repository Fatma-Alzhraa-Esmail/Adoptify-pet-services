import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/repo/tips_repo.dart';

class TipsRepoImp implements TipsRepo {
  final _firebase = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, List<TipsModel>>> getStatusTips() async {
    
   
 
   try {
      List<TipsModel> allTips = [];
       var tipsListsnapShot = await _firebase.collection('Tips').where('status',isNotEqualTo: '').get();
      final tipsList = tipsListsnapShot.docs.map((tipDoc) {
        print("tipDoc Data: ${tipDoc.data()}");
        return TipsModel.fromJson(tipDoc.data());
      }).toList();
      allTips.addAll(tipsList);
      return right(allTips);
    } catch (e) {
      print("Error Get tipsList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
 
  }
  
  @override
  Future<Either<Failure, List<TipsModel>>> getHighlightedTips() async{
  try {
      List<TipsModel> allTips = [];
       var tipsListsnapShot = await _firebase.collection('Tips').where('isHighlight',isEqualTo: true).get();
      final tipsList = tipsListsnapShot.docs.map((tipDoc) {
        print("tipDoc Data: ${tipDoc.data()}");
        return TipsModel.fromJson(tipDoc.data());
      }).toList();
      allTips.addAll(tipsList);
      return right(allTips);
    } catch (e) {
      print("Error Get tipsList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<TipsModel>>> getTips() async{
    try {
      List<TipsModel> allTips = [];
       var tipsListsnapShot = await _firebase.collection('Tips').where('isHighlight',isEqualTo: false).where( 'status',isEqualTo: '').get();
      final tipsList = tipsListsnapShot.docs.map((tipDoc) {
        print("tipDoc Data: ${tipDoc.data()}");
        return TipsModel.fromJson(tipDoc.data());
      }).toList();
      allTips.addAll(tipsList);
      return right(allTips);
    } catch (e) {
      print("Error Get tipsList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

}
