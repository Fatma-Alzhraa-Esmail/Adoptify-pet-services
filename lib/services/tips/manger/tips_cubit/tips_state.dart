part of 'tips_cubit.dart';

@immutable
sealed class TipsState {}

final class TipsInitial extends TipsState {}

final class TipsFetchStatusLoadingState extends TipsState {}

final class TipsFetchStatusLoadedState extends TipsState {
  final List<TipsModel> tipsList;

  TipsFetchStatusLoadedState({required this.tipsList});
}

final class TipsFetchStatusErrorState extends TipsState {
  final String errMessage;

  TipsFetchStatusErrorState({required this.errMessage});
}

final class TipsFetchHighlightLoadingState extends TipsState {}

final class TipsFetchHighlightLoadedState extends TipsState {
  final List<TipsModel> tipsList;

  TipsFetchHighlightLoadedState({required this.tipsList});
}

final class TipsFetchHighlightErrorState extends TipsState {
  final String errMessage;

  TipsFetchHighlightErrorState({required this.errMessage});
}

final class TipsFetchLoadingState extends TipsState {}

final class TipsFetchLoadedState extends TipsState {
  final List<TipsModel> tipsList;

  TipsFetchLoadedState({required this.tipsList});
}

final class TipsFetchErrorState extends TipsState {
  final String errMessage;

  TipsFetchErrorState({required this.errMessage});
}