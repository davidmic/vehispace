import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehispace/provider/cartbloc.dart';
import 'package:vehispace/widgets/customraisedbutton.dart';
import '../provider/productbloc.dart';
import '../models/productsmodel.dart';

class ProductDetails extends StatefulWidget {
  final int productIndex;
  ProductDetails({this.productIndex});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    final ProductBloc productbloc = Provider.of<ProductBloc>(context);
    final Cartbloc cartbloc = Provider.of<Cartbloc>(context);
    int item = widget.productIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text('${productbloc.products[item].name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Stack(
            children: <Widget>[

              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(cartbloc.counter.toString()),
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(
            productbloc.products[item].image,
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.blue.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      productbloc.products[item].name.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'NGN' + productbloc.products[item].sellingPrice,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.blue.withOpacity(0.3),
                 child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      productbloc.products[item].desc,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
            ),
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomRaisedButton(
            onPressed: () {
                cartbloc.addProduct(Products(
                  name: productbloc.products[item].name,
                  image: productbloc.products[item].image,
                  sellingPrice: productbloc.products[item].sellingPrice,
                  desc: '',
                ));
                print(cartbloc.cartItem.length);
            },
            text: 'ADD TO CART',
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
