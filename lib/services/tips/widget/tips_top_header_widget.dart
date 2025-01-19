import 'package:flutter/material.dart';
import 'package:peto_care/services/home/widgets/search.dart';

class tipsTopHeaderWidget extends StatelessWidget {
  const tipsTopHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.1 / 1.5,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey, Colors.black12],
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/onboarding7.jpeg',
                        )),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
          Positioned(top: 45, right: 12, left: 12, child: TopSearchBarWidget()),
        ],
      ),
    );
  }
}
