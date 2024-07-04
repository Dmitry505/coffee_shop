import 'dart:io';

import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(int) onQuantityChanged;

  ProductItem({required this.product, required this.onQuantityChanged});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 16.0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 150.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.product['image'],
                height: 100.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8.0),
              Text(
                widget.product['name'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                widget.product['price'],
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 16.0),
              _quantity > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity =
                                  _quantity > 1 ? _quantity - 1 : 0;
                              widget.onQuantityChanged(_quantity);
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text('$_quantity'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _quantity =
                                  _quantity < 10 ? _quantity + 1 : 10;
                              widget.onQuantityChanged(_quantity);
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _quantity = 1;
                          widget.onQuantityChanged(_quantity);
                        });
                      },
                      child: Text('Купить'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}