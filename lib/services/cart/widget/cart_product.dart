import 'package:flutter/material.dart';

class CartProductWidget extends StatefulWidget {
  const CartProductWidget({super.key});

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
 Color? selectedColor=Colors.amber;

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
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Color:"),
                      SizedBox(width: 5,),
                  
                      CircleAvatar(
                        radius: 9,
                        
                        backgroundColor: selectedColor,)
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
