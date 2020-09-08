import 'package:flutter/material.dart';
import 'package:vehispace/screens/product_details.dart';
import '../provider/productbloc.dart';
import 'package:provider/provider.dart';

class MyProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final ProductBloc productbloc = Provider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(),
      body: GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: productbloc.products.length,
        itemBuilder: (BuildContext context, int index){
          final currentitem = productbloc.products[index];
          return  GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(
                productIndex: index,
              )));
              print(index);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(currentitem.image),
                  Text(currentitem.name),
                  Text(currentitem.sellingPrice),
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
