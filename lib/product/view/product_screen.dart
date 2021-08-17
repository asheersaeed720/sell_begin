import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Product screen'),
    );
  }
}
