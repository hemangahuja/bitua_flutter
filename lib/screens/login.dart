
import 'package:bitua/helper/validation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}
class LoginData {
  String email = '';
  String password = '';
}
class _State extends State<LoginScreen> with InputValidationMixin {

  LoginData data = LoginData();
  final formGlobalKey = GlobalKey<FormState>();
  String _error = '';
  bool isLoading = false;
 

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Bitua'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                const SizedBox(height: 50),
                      TextFormField(
                        onSaved: (value){
                          data.email = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: "Email"
                        ),
                        validator: (email) {
                          if (isEmailValid(email!)) {
                            return null;
                          } else {
                            return 'Enter a valid email address';
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                        TextFormField(
                          onSaved: (value){
                            data.password = value!;
                          },
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                          maxLength: 32,
                          obscureText: true,
                          validator: (password) {
                            if (isPasswordValid(password!)) {
                              return null;
                            } else {
                              return 'Enter a valid password';
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        showAlert(_error),
                        const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () async{
                              
                              if (formGlobalKey.currentState!.validate()) {
                                setState(() {
                                isLoading = true;
                              });
                                formGlobalKey.currentState!.save();
                                 try{
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: data.email.trim(), password: data.password.trim());
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushNamed(context, '/main');
                                  }
                                  on FirebaseAuthException catch (e){
                                    setState(() {
                                      if(e.message != null){
                                          _error = e.message!;
                                      isLoading = false;
                                      }
                                      
                                    });
                                  }
                            }},
                            child: const Text("Submit")),
                            showLoading(isLoading),
              ],
                
                ),
              ),
               Row(
                      children: <Widget>[
                        const Text('Do not have account?'),
                        TextButton(
                          
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20 , color:  Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
            ],
          ),

      ));
  }
}


  
