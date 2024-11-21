
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/tips/bloc/state.dart';
import 'package:peto_care/services/tips/model/popular_tips.dart';
import 'package:peto_care/services/tips/model/recommended_tips.dart';

class TipsCubit extends Cubit<TipsStates> {
  TipsCubit() : super(TipsInitialState());

  static TipsCubit get(context) => BlocProvider.of(context);
      final List recommededTipss=RecommededTips.RecommededTipsCard();
      final List popularTipss=PopularTips.CreateTopShopCard();


   

}
