// import 'package:flutter/material.dart';
// import 'package:adoptify/services/myaccount/model/address.dart';

// class AddAddressWidget extends StatefulWidget {
//   AddressDetails address;

//   AddAddressWidget(BuildContext context, this.address);
//   @override
//   State<AddAddressWidget> createState() => _AddAddressWidgetState();
// }

// class _AddAddressWidgetState extends State<AddAddressWidget> {
//   bool isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           isSelected = true;
//         });
//       },
//       child: Padding(
//         padding: EdgeInsets.only(left: 18, right: 18, top: 15),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: isSelected?Colors.amber:Colors.black38)),
//           child: Row(
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 14),
//                 child: Container(
//                   height: 130,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.address.name ?? 'Fatma Alzhraa Esmail',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w800, fontSize: 20),
//                       ),
//                       Text(widget.address.location ?? 'address',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18,
//                               color: Colors.grey.shade600)),
//                       Text('${widget.address.phoneNumber ?? 01065576124}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18,
//                               color: Colors.grey.shade600)),
//                     ],
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:adoptify/services/myaccount/model/address.dart';

class AddAddressWidget extends StatefulWidget {
  AddressDetails address;

  AddAddressWidget(BuildContext context,this.address);
  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 18, right: 18, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black38)),
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Container(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 widget.address.name ?? 'Fatma Alzhraa Esmail',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                Text(widget.address.location ?? 'address',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.grey.shade600)),
                Text('${widget.address.phoneNumber ?? 01065576124}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.grey.shade600)),
              ],
            ),
          ),
        )),
      ),
    );
  }
}