import 'package:flutter/material.dart';
import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/services/home/widgets/search.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class HeaderBody extends StatelessWidget {
  const HeaderBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1.9,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Transform.translate(
                offset: Offset(0, -100),
                child: Image.asset(
                  Assets.assetsImagesSlider3,
                  fit: BoxFit.fitWidth,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black12],
                ),
              ),
            ),
          ),
          Positioned(top: 45, right: 12, left: 12, child: TopSearchBarWidget()),
          Positioned(
            top: 150,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SUMMER',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w600.copyWith(
                    color: Colors.white,
                    decorationThickness: 1.0,
                    fontSize: 20,
                    shadows: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 72,
                  height: 2.5,
                  child: Container(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            child: Text(
              '30% OFF',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                shadows: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                    // blurStyle: BlurStyle.outer
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
