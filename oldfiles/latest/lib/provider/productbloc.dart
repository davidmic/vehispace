import 'package:flutter/material.dart';
import '../models/productsmodel.dart';

class ProductBloc extends ChangeNotifier {
  List<Products> _products = [
    Products(
      name: 'Types',
      image: 'assets/images/sparepart.png',
      desc: 'Mikono Type Best Selling in Africa, teghewew ewjhwehjhjewhhew e ewhhwehhew ehewhwehhwe ew wehewhhewhhewbewbhew hhewhwehwe',
      sellingPrice: '92000'
    ),
    Products(
        name: 'Cloth',
        image: 'assets/images/sparepart.png',
        desc: 'Mikono Type Best Selling in Africa, teghewew ewjhwehjhjewhhew e ewhhwehhew ehewhwehhwe ew wehewhhewhhewbewbhew hhewhwehwe',
        sellingPrice: '21000'
    ),
    Products(
        name: 'Pants',
        image: 'assets/images/sparepart.png',
        desc: 'Mikono Type Best Selling in Africa, teghewew ewjhwehjhjewhhew e ewhhwehhew ehewhwehhwe ew wehewhhewhhewbewbhew hhewhwehwe',
        sellingPrice: '2000'
    ),
  ];

  List<Products> get products => _products;

//  setProducts(){
//    products;
//    notifyListeners();
//  }
}