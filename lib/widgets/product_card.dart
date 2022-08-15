import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(
              this.product.picture
            ),
            _ProductDetails(
              product: this.product,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                product: this.product,
              )
            ),
            //TODO: mostrar de manera condicional
            if(!product.available)
                Positioned(
                top: 0,
                left: 0,
                child: _NotAvaliable()
              )
            
             
          ],
        ),
        
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvaliable extends StatelessWidget {

  

  //String texto = product.available?'Disponible': 'No disponible';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 20),)
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(25))
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final Product product;

  const _PriceTag({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$' + this.product.price.toString(), style: TextStyle(color: Colors.white, fontSize: 20),)
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        
        decoration: _BuildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.product.name,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              this.product.id.toString(),
              style: TextStyle(fontSize: 15, color: Colors.white),
            )
          ]
          ),
      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url ==null
          ? Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
            )
        : FadeInImage(
          //TODO: fix productos cuando no hay imagen
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(this.url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}