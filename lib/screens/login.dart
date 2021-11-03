import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}
 
class _State extends State<LoginScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitua',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Bitua'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Bitua',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      //TODO forget password screen
                    },
                    
                    child: const Text('Forgot Password', style: TextStyle(color: Colors.blue),),
                  ),
                  Container(
                    height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login' , style: TextStyle(color: Colors.white),),
                        onPressed: () async{

                          try{
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: nameController.text.toString().trim(), password: passwordController.text.toString().trim());
                              Navigator.pushNamed(context, '/main');
                          }
                          on FirebaseAuthException catch (e){
                            if(e.code == 'user-not-found'){
                              print(e.code);
                            }
                            else if(e.code == 'wrong-password'){
                              print(e.code);
                            }
                          }
                        },
                      )),
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
              ))),
    );
  }
}