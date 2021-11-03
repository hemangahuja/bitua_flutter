import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}
 
class _State extends State<RegisterScreen> {

  final _auth = FirebaseAuth.instance;

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
                        'Sign up',
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
                 
                  Container(
                    height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Register' , style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          try {
                            print(nameController.text.toString().trim());
                            print(passwordController.text.toString().trim());
                            await _auth.createUserWithEmailAndPassword(email: nameController.text.toString().trim(), password: passwordController.text.toString().trim());
                            Navigator.pushNamed(context, '/main');
                          } on FirebaseAuthException catch (e) {
                            if(e.code == 'weak-password'){
                              print('wp');
                            }
                            else if(e.code == 'email-already-in-use'){
                              print('eaiu');
                            }
                          }
                          catch(e){
                            print(e);
                          }
                          
                          
                        },
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Already have an account?'),
                      TextButton(
                        
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20 , color:  Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
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