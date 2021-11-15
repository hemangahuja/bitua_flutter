
import 'package:bitua/helper/gradient_style.dart';
import 'package:bitua/helper/validation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


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
          title: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text('Bitua' , style: GoogleFonts.lato(
                textStyle: const TextStyle(color: Colors.black),
              ),),
            ],
          )),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow[600]!, Colors.red[200]!]),
              )
            ),
        ),
      body:
      Container(
        decoration :  BoxDecoration(
          color: Colors.grey[850]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                  const SizedBox(height: 50),
                        TextFormField(
                          style: gradientStyle,
                          onSaved: (value){
                            data.email = value!;
                          },
                          decoration: const InputDecoration(
                            labelText: "Email",
                            
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
                            style: gradientStyle,
                            onSaved: (value){
                              data.password = value!;
                            },
                            decoration: const InputDecoration(
                              labelText: "Password",
                              
                            ),
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
                                      Navigator.popAndPushNamed(context, '/main');
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
                           GradientText('Do not have account?' , 
                           style: const TextStyle(fontSize: 18),
                           colors: [
                             Colors.yellow[600]!, Colors.red[200]!
                           ],),
                          TextButton(
                            
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontSize: 20 , color:  Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/register');
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
              ],
            ),

        ),
      ));
  }
}


  
