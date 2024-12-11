import 'package:flutter/material.dart';
import 'package:peto_care/services/home/widgets/deal_of_day_body.dart';
import 'package:peto_care/services/home/widgets/header_body.dart';
import 'package:peto_care/services/home/widgets/hot_shop_body.dart';
import 'package:peto_care/services/home/widgets/main_features_body.dart';
import 'package:peto_care/services/home/widgets/top_service_body.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HeaderBody(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: MainFeaturesBody(),
          ),
          SliverToBoxAdapter(
            child: TopServiceBody(),
          ),
          // HotShopBody will now be inside SliverToBoxAdapter to allow flexible height
          SliverToBoxAdapter(
            child: HotShopBody(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
            child: DealOFDayBody(),
          ),
        ],
      ),
    );
  }
}
