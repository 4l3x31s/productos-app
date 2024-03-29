import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';

class ChechAuthScreen extends StatelessWidget {
  const ChechAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if(!snapshot.hasData){
              return Text('Espere');
            }
            if(snapshot.data == ''){
              Future.microtask(() {
                //Navigator.of(context).pushReplacementNamed('login');
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_ ,__,___)=>LoginScreen(),
                  transitionDuration: Duration(seconds: 0)
                ));
              });

            }else{
              Future.microtask(() {
                //Navigator.of(context).pushReplacementNamed('login');
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_ ,__,___)=>HomeScreen(),
                  transitionDuration: Duration(seconds: 0)
                ));
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}