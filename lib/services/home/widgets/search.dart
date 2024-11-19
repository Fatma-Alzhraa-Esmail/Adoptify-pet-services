import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget Search() {
    final TextEditingController _searchController = TextEditingController();

  return Positioned(
      top: 45,
      left: 15,
      right: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                color: HexColor('#e8e4e3').withAlpha(100),
                borderRadius: BorderRadius.circular(10.0)),
            width: 300,
            height: 45,
            child: TextField(
              cursorColor: Colors.white,
              controller: _searchController,
              decoration: InputDecoration(
                // border: Border(bottom: BorderSide(color: Colors.w)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Search',

                fillColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    height: 2.7,
                    fontWeight: FontWeight.w600),
                // Add a clear button to the search bar
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 27,
                  ),
                  onPressed: () => _searchController.clear(),
                ),
                // Add a search icon or button to the search bar
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.search_sharp,
                    color: Colors.white,
                    size: 27,
                  ),
                  onPressed: () {
                    // Perform the search here
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
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
          Container(
              child: Icon(
            CupertinoIcons.cart,
            color: Colors.white,
            size: 27,
          )),
        ],
      ));
}
