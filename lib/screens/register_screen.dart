import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 30,),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    )
                    //_LoginForm(),

                  ],
                ),
              ),
              SizedBox(height: 50,),
              TextButton(
                onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.black87),),
              ),
              SizedBox(height: 50,),
            ],
          )
        )
      )
   );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        //TODO: mantener la referencia al KEY
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'jhon.doe@gmail.com',
                labelText: 'Correo Electrónico',
                prefixIcon: Icons.alternate_email
              ),
              onChanged: (value)=>loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo.';
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value)=>loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6) 
                ? null 
                : 'La contraseña debe ser mayor a 6 caracteres';
              },
            ),
            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espere'
                  :'Ingresar', 
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading ? null: () async{
                //TODO: login form
                FocusScope.of(context).unfocus();
                //loginForm.isValidForm();
                final authService = Provider.of<AuthService>(context, listen:false);
                if(!loginForm.isValidForm()) return;
                
                
                loginForm.isLoading = true;
                //TODO: validar si el login es correcto

                final String? errorMessage =await authService.createUser(loginForm.email, loginForm.password);
                loginForm.isLoading = false;
                print(errorMessage);
                if(errorMessage == null){
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  //TODO: mostrar error en pantalla
                  print(errorMessage);
                  NotificationService.showSnackBar(errorMessage);
                }
                
                
              }
            )
          ],
        ),
      ),
    );
  }
}