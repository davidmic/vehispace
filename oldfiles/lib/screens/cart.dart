import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cartbloc.dart';
class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cartbloc cartbloc = Provider.of<Cartbloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: ListView.builder(
        itemCount: cartbloc.cartItem.length,
          itemBuilder: (BuildContext context, int index){
          final item = cartbloc.cartItem[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(item.image),
                ),
                title: Text(item.name),
                subtitle: Text(item.sellingPrice),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            );
          } 
      ),
    );
  }
}
