import 'package:flutter/material.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class SearchWidget extends StatelessWidget {
   SearchWidget({
    super.key,
  });

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
    
      cursorColor: Colors.white,
      controller: searchController,
      style:AppTextStyles.w600, 
      decoration: InputDecoration(
        filled: true,
        
        // border: Border(bottom: BorderSide(color: Colors.w)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
            ),
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color:const Color.fromARGB(94, 255, 255, 255) ),
          borderRadius: BorderRadius.circular(10.0),),
        fillColor: const Color.fromARGB(110, 255, 255, 255),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
         isDense: true,
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
          onPressed: () => searchController.clear(),
        ),
        // Add a search icon or button to the search bar
        prefixIcon: IconButton(
          icon:drawSvgIcon('search',iconColor: Colors.white,height: 21,width: 21),
          onPressed: () {
            // Perform the search here
          },
        ),
        
        border: OutlineInputBorder(
          borderSide: BorderSide(color:const Color.fromARGB(255, 255, 255, 255) ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        
      ),
    );
  }
}
