// import 'package:e_shop/screens/products_overview_screen.dart';

// import '../provider/products_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/product_grid.dart';

// enum FilterOptions { Favorites, All }

// class FavoriteScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productData = Provider.of<ProductsProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('E Shop'),
//         actions: [
//           PopupMenuButton(
//             onSelected: (FilterOptions selectedValue) {
//               if (selectedValue == FilterOptions.Favorites) {
//                 productData.showFavoriteOnly();
//               } else {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProductsOverviewScreen()));
//                 productData.showAll();
//               }
//             },
//             itemBuilder: (_) => [
//               PopupMenuItem(
//                 child: Text('Only Favorites'),
//                 value: FilterOptions.Favorites,
//               ),
//               PopupMenuItem(
//                 child: Text('Show All'),
//                 value: FilterOptions.All,
//               ),
//             ],
//             child: Icon(
//               Icons.more_vert,
//             ),
//           )
//         ],
//       ),
//       body: Grid_view(),
//     );
//   }
// }
