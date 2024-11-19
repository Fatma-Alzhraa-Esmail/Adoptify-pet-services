import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/cart/bloc/cart_cubit.dart';
import 'package:adoptify/services/cart/bloc/cart_state.dart';
import 'package:adoptify/services/cart/widget/color_select_button.dart';

class EditCartProductWidget extends StatefulWidget {
  EditCartProductWidget({super.key});

  @override
  State<EditCartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<EditCartProductWidget> {
  Color? selectedColor;

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.brown,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 8, right: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
            ]),
        //  width: 185,
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 75,
                height: 75,
                child: Image.asset(
                  'assets/images/carrie.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Carrie',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      '\$13',
                      style: TextStyle(
                          color: Color.fromARGB(255, 222, 174, 31),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'x2',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        child: Builder(builder: (context) {
                          return ColorSelectWidget(
                            defaultColor: Colors.amber,
                            colors: colors,
                            onColorSelected: (selectedColor) {
                              setState(() {
                                this.selectedColor = selectedColor;
                              });
                            },
                          );
                        }),
                      ),
                      BlocProvider(
                        create: (BuildContext context) => CartCubit(),
                        child: BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            var bloc = BlocProvider.of<CartCubit>(context);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      bloc.remove();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade500,
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Icon(
                                            Icons.remove,
                                            size: 18,
                                          )),
                                    ),
                                  ),
                                  Text(
                                    "${bloc.counter}",
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      bloc.add();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade500,
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
