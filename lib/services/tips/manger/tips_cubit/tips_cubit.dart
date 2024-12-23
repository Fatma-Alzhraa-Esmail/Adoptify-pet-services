import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/repo/tips_repo.dart';

part 'tips_state.dart';

class TipsCubit extends Cubit<TipsState> {
  TipsCubit(this.tipsRepo) : super(TipsInitial());
  final TipsRepo tipsRepo;
  bool tipsWithStatusIsLoading = false;
  bool tipsWithHighlightIsLoading = false;
  bool tipsIsLoading = false;
  List<TipsModel> tipsWithStatus = [];
  List<TipsModel> tipsWithHighlighit = [];
  List<TipsModel> tips = [];
  Future<List<TipsModel>?> fetchStatusTips() async {
    tipsWithStatusIsLoading = true;
    emit(TipsFetchStatusLoadingState());
    var statusTips = await tipsRepo.getStatusTips();
    statusTips.fold((failure) {
      emit(TipsFetchStatusErrorState(errMessage: failure.errMessage));
       tipsWithStatusIsLoading = false;
    }, (statusTipsList) {
      tipsWithStatus = statusTipsList;
      emit(TipsFetchStatusLoadedState(tipsList: statusTipsList));
       tipsWithStatusIsLoading = false;
    });
    return [];
  }
  Future<List<TipsModel>?> fetchHighlightTips() async {
    tipsWithHighlightIsLoading = true;
    emit(TipsFetchHighlightLoadingState());
    var highlightTips = await tipsRepo.getHighlightedTips();
    highlightTips.fold((failure) {
      emit(TipsFetchHighlightErrorState(errMessage: failure.errMessage));
       tipsWithHighlightIsLoading = false;
    }, (HighlightTipsList) {
      tipsWithHighlighit = HighlightTipsList;
      emit(TipsFetchHighlightLoadedState(tipsList: HighlightTipsList));
       tipsWithHighlightIsLoading = false;
    });
    return [];
  }

  Future<List<TipsModel>?> fetchTips() async {
    tipsIsLoading = true;
    emit(TipsFetchLoadingState());
    var listTips = await tipsRepo.getTips();
    listTips.fold((failure) {
      emit(TipsFetchErrorState(errMessage: failure.errMessage));
       tipsIsLoading = false;
    }, (tipsList) {
      tips = tipsList;
      emit(TipsFetchLoadedState(tipsList: tipsList));
       tipsIsLoading = false;
    });
    return [];
  }
}
