import 'package:e_shop_app/screens/edit_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String ImageUrl;

  UserProductItem(this.id, this.title, this.ImageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(ImageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(EditProductsScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(
                    context,
                    listen: false,
                  ).deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
