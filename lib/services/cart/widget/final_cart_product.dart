import 'package:flutter/material.dart';
import 'package:adoptify/utilities/theme/media.dart';

class FinalCartProductWidget extends StatefulWidget {
  const FinalCartProductWidget({super.key});

  @override
  State<FinalCartProductWidget> createState() => _FinalCartProductWidgetState();
}

class _FinalCartProductWidgetState extends State<FinalCartProductWidget> {
  Color? selectedColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaHelper.width,
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  child: Image.asset(
                    'assets/images/carrie.png',
                    fit: BoxFit.cover,
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
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
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
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Color:"),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.amber,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Divider(
          //   color: Colors.grey.shade400,
          //   height: 2,
          //   indent: 20,
          //   endIndent: 20,
          //   thickness: 1,
          // )
        ],
      ),
    );
  }
}
