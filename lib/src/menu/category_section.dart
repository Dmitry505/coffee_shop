import 'dart:io';

import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String category;
  final List<Widget> products;

  CategorySection({required this.category, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 240.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return products[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}