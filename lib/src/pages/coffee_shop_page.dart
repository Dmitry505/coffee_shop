import 'dart:io';

import 'package:first_project/src/menu/category_section.dart';
import 'package:first_project/src/menu/product_item.dart';
import 'package:flutter/material.dart';

class CoffeeShopPage extends StatefulWidget {
  @override
  _CoffeeShopPageState createState() => _CoffeeShopPageState();
}

class _CoffeeShopPageState extends State<CoffeeShopPage> {
  final List<String> _categories = [
    'Кофе с молоком',
    'Кофе на основе экспрессо',
    'Чай',
    'Десерты',
  ];

  final List<Map<String, dynamic>> _products = [
    // Кофе с молоком
    {
      'image': 'assets/images/cappuccino.png',
      'name': 'Cappuccino',
      'price': '150 руб.',
      'quantity': 0,
    },
    {
      'image': 'assets/images/latte.jfif',
      'name': 'Latte',
      'price': '200 руб.',
      'quantity': 0,
    },
    // Кофе на основе экспрессо
    {
      'image': 'assets/images/americano.jfif',
      'name': 'Americano',
      'price': '150 руб.',
      'quantity': 0,
    },
    {
      'image': 'assets/images/espresso.jfif',
      'name': 'Espresso',
      'price': '120 руб.',
      'quantity': 0,
    },
    // Чай
    {
      'image': 'assets/images/black_tea.jfif',
      'name': 'Black tea',
      'price': '100 руб.',
      'quantity': 0,
    },
    {
      'image': 'assets/images/green_tea.jfif',
      'name': 'Green tea',
      'price': '100 руб.',
      'quantity': 0,
    },
    // Десерты
    {
      'image': 'assets/images/eclair.jfif',
      'name': 'Eclair',
      'price': '120 руб.',
      'quantity': 0,
    },
    {
      'image': 'assets/images/tiramisu.jfif',
      'name': 'Tiramisu',
      'price': '220 руб.',
      'quantity': 0,
    },
  ];

  ScrollController _categoryScrollController = ScrollController();
  ScrollController _menuScrollController = ScrollController();

  int _currentCategoryIndex = 0;
  bool _showCart = false; 

  @override
  void initState() {
    super.initState();
    _menuScrollController.addListener(() {
      _updateActiveCategory();
    });
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _menuScrollController.dispose();
    super.dispose();
  }

  void _updateActiveCategory() {
    double scrollOffset = _menuScrollController.offset;
    for (int i = 0; i < _categories.length; i++) {
      RenderBox categoryRenderBox = context.findRenderObject() as RenderBox;
      double categoryTop = categoryRenderBox.localToGlobal(Offset.zero).dy;
      if (scrollOffset >= categoryTop &&
          scrollOffset <= categoryTop + 50) {
        setState(() {
          _currentCategoryIndex = i;
        });
        break;
      }
    }
  }

  void _scrollToCategory(int index) {
    _categoryScrollController.animateTo(
      index * 80.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    RenderBox categoryRenderBox = context.findRenderObject() as RenderBox;
    _menuScrollController.animateTo(
      categoryRenderBox.localToGlobal(Offset.zero).dy +
          index * 180.0, 
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _updateCartVisibility() {
    setState(() {
      _showCart = _products.any((product) => product['quantity'] > 0);
    });
  }

  void _onCartPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Корзина'),
          content: Text('Заказ успешно оформлен!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateCartVisibility();
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Container(
            height: 50.0,
            child: ListView.builder(
              controller: _categoryScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _scrollToCategory(index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.center,
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        fontWeight: _currentCategoryIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _menuScrollController,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return CategorySection(
                    category: _categories[index],
                    products: _products
                        .sublist(index * 2, index * 2 + 2)
                        .map((product) => ProductItem(
                              product: product,
                              onQuantityChanged: (newQuantity) {
                                setState(() {
                                  product['quantity'] = newQuantity;
                                  _updateCartVisibility();
                                });
                              },
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            if (_showCart)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: FloatingActionButton(
                    onPressed: _onCartPressed,
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}