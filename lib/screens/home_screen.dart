import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if(productsService.isLoading) return LoadingScreen();

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          leading: IconButton(
            onPressed: ()async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon:Icon(Icons.login_outlined),
          ),
        ),
        body: ListView.builder( //el builder no carga todo es mas eficiente
          itemCount: productsService.products.length,
          physics: BouncingScrollPhysics(), //para que el scroll sea como IOS
          itemBuilder: ( BuildContext context, int index )=> GestureDetector(
            onTap: () {
              productsService.selectedProduct = productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(
              product: productsService.products[index],
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            productsService.selectedProduct = new Product(
              available: false,
              name: '',
              price: 0
            );
            Navigator.pushNamed(context, 'product');
          },
        ),
      )
   );
  }
}