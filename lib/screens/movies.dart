import 'package:flutter/material.dart';

import '../home_stuff/popular_item.dart';
import '../home_stuff/recommended_item.dart';
import '../home_stuff/release_item.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        PopularItem(),
        SizedBox(
          height: 20,
        ),
        Release(),
        SizedBox(
          height: 20,
        ),
        RecommendedItem(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
