import 'package:flutter/material.dart';
import '../models/productsmodel.dart';

class Cartbloc extends ChangeNotifier {
  List<Products> _cartItem = [];

  List<Products> get cartItem => _cartItem;

  int _counter = 0;

  int get counter => _counter;

  set counter (int val) => _counter = val;

  void addProduct (Products item){
    _cartItem.add(item);
    counter++;
    notifyListeners();
  }
}