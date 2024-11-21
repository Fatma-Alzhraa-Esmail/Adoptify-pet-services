import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class CategoryCard extends StatelessWidget {

   const CategoryCard( {
    this.isSelected = false,
    this.categori
  });
  final String ? categori;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(

          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: isSelected? Colors.black: Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 5),
            ),
          ]),
      child: Column(
        children: [
          Icon(Icons.abc_sharp, size: 32),
          SizedBox(height: 8),
          Text(
            '$categori',
            style: AppTextStyles.w500.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

