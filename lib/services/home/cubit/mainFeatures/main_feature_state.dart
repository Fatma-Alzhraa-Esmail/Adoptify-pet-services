
import 'package:flutter/material.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';

@immutable
sealed class MainFeatureState {}

final class MainFeatureInitial extends MainFeatureState {}

class MainFeaturesLoading extends MainFeatureState {}

class MainFeaturesLoaded extends MainFeatureState {
   final List<MainFeaturesModel> features;


  MainFeaturesLoaded(this.features);
}

class MainFeaturesError extends MainFeatureState {
  final String error;

  MainFeaturesError(this.error);
}
class MainFeaturesSelectCategory extends MainFeatureState {
  final String id;

  MainFeaturesSelectCategory(this.id);
}