import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

import 'global_variables.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart =Provider.of<CartProvider>(context).cart;
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
          itemBuilder: (context,index){
              final cartItem=cart[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                ),
                trailing: IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Delete item',
                            style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                              'Are you sure you want to rremove the product'
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: const Text('NO',
                              style: TextStyle(
                                color: Colors.blue
                              ),)),
                              TextButton(onPressed: (){
                                Provider.of<CartProvider>(context,listen: false).removeProduct(cartItem);
                                Navigator.of(context).pop();
                              }, child: const Text('YES', style: TextStyle(
                                  color: Colors.red
                              ),)),
                            ],
                          );

                        },);
                },
                icon: const Icon(Icons.delete,
                color: Colors.red,
                ),
                ),
                title: Text(
                  cartItem['title'].toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text('Size: ${cartItem['size']}'),
              );
          }),
    );
  }
}
