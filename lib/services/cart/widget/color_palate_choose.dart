import 'package:flutter/material.dart';
import 'package:peto_care/services/cart/manger/cart/cart_cubit.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';

class ColorPalateChoose extends StatelessWidget {
  const ColorPalateChoose({
    super.key,
    required this.colors,
    required this.cartItem,
    required this.cartCubit,
    required this.dialogContext,
  });

  final List<String> colors;
  final CartModel cartItem;
  final CartCubit cartCubit;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    print("Colors: $colors");
    print("Selected color: ${cartItem.color}");

    return Padding(
      padding: const EdgeInsets.only(right: 26, top: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF323232).withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 0,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        height: 50,
        width: 200,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 6),
          itemCount: colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool isSelected = colors[index] == cartItem.color;

            return GestureDetector(
              onTap: () {
                cartCubit.updateItemColor(
                    cartItem: cartItem, color: colors[index]);
                print("Selected Color: ${colors[index]}");
                Navigator.of(dialogContext).pop();
                FocusScope.of(dialogContext).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
                // Handle selection logic here
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: isSelected ? 40 : 35.0,
                  height: isSelected ? 40 : 35.0,
                  decoration: BoxDecoration(
                    color: Color(int.parse('0xFF${colors[index]}')),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: isSelected ? 35 : 30.0,
                      height: isSelected ? 35 : 30.0,
                      decoration: BoxDecoration(
                        color: Color(int.parse('0xFF${colors[index]}')),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: isSelected ? 2.0 : 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
