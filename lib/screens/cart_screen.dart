import 'package:e_shop_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_items.dart';
import '../provider/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      '\$${cartData.totalAmount}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).hoverColor,
                  ),
                  OrderButton(cartData: cartData),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder:
                  (ctx, i) => CartItems(
                    cartData.items.values.toList()[i].id,
                    cartData.items.keys.toList()[i],
                    cartData.items.values.toList()[i].title,
                    cartData.items.values.toList()[i].price,
                    cartData.items.values.toList()[i].quantity,
                  ),
              itemCount: cartData.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({super.key, required this.cartData});

  final CartProvider cartData;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : TextButton(
          onPressed:
              (widget.cartData.totalAmount <= 0 || _isLoading)
                  ? null
                  : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOder(
                      widget.cartData.items.values.toList(),
                      widget.cartData.totalAmount,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                    widget.cartData.clear();
                  },
          child: Text(
            'ORDER NOW',
            style: TextStyle(color: Theme.of(context).hoverColor),
          ),
        );
  }
}
