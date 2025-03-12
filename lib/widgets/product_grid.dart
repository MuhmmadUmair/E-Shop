import '../provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItem : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (cxt, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // id: products[i].id,
            // title: products[i].title,
            // imageUrl: products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
