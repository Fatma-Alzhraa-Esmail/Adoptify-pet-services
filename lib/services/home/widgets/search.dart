
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/utilities/components/search.dart';

class TopSearchBarWidget extends StatelessWidget {
 const  TopSearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: SearchWidget()),
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Icon(
            CupertinoIcons.bell,
            color: Colors.white,
            size: 27,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          CupertinoIcons.cart,
          color: Colors.white,
          size: 27,
        ),
      ],
    );
  }
}

