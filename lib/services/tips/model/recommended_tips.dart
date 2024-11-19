import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecommededTips {
  final String? image;
  final String? tipsName;
  final String? description;
  final String? Status;
  final Color? colorStatus;
  bool? isFavourite;

  RecommededTips({
    this.image,
    this.Status,
    this.colorStatus,
    this.description,
    this.isFavourite,
    this.tipsName,
  });
  static List<RecommededTips> RecommededTipsCard() {
    return [
      RecommededTips(
        image: 'assets/images/trip2.jpg',
        Status: 'New',
      colorStatus: Color.fromARGB(255, 233, 114, 103),
        description: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
        isFavourite: false,
        tipsName: 'How to keep cats and dogs safd ggdf',
      ),
      RecommededTips(
        image: 'assets/images/Trimming Hair.jpg',
        Status: 'Hot',
        colorStatus: Colors.amber,
        description: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
        isFavourite: false,
        tipsName: 'Taking care of dogs and cat is pla ola',
      ),
      RecommededTips(
        image: 'assets/images/trip.jpg',
        Status: 'New',
        colorStatus: Colors.redAccent,
        description: 'Lorem ipsum dolor sit conssk jjhyg dfg eerg',
        isFavourite: false,
        tipsName: 'How to keep cats and dogs safd ggdf',
      ),
    ];
  }
}
