import 'package:e_shop_app/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/product.dart';
import '../screens/product_detail_screen.dart';
import '../provider/cart_provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem({
  //   required this.id,
  //   required this.imageUrl,
  //   required this.title,
  // });
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final tokenData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder:
                (ctx, product, child) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    product.toggleFavorite(tokenData.token, tokenData.userId!);
                  },
                  color: Theme.of(context).primaryColor,
                ),
          ),
          title: Text(product.title),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
