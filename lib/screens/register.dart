import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bitua/helper/validation.dart';

class RegisterScreen extends StatefulWidget {
  final List coins;
  const RegisterScreen({Key? key, required this.coins}) : super(key: key);

  @override
  _State createState() => _State();
}


class LoginData { 
  String email = '';
  String password = '';
}

class _State extends State<RegisterScreen> with InputValidationMixin {
  LoginData data = LoginData();
  final formGlobalKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance.collection('user_coins');
  String _error = '';
  bool isLoading = false;

  Future initSave(var uid) async {
    for (int i = 0; i < widget.coins.length; i++) {
      await _store
          .add({'uuid': uid, 'coin_name': widget.coins[i], 'coin_amount': 0});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Bitua'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    TextFormField(
                      onSaved: (value) {
                        data.email = value!;
                      },
                      decoration: const InputDecoration(labelText: "Email"),
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
                      onSaved: (value) {
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
                    const SizedBox(height: 50),
                    showAlert(_error),
                    ElevatedButton(
                        onPressed: () async {
                         
                          if (formGlobalKey.currentState!.validate()) {
                             setState(() {
                            isLoading = true;
                          });
                            formGlobalKey.currentState!.save();
                            try {
                              final cred =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: data.email.trim(),
                                      password: data.password.trim());
                              await initSave(cred.user!.uid);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushNamed(context, '/');
                            } on FirebaseAuthException catch (e) {
                             
                                setState(() {
                                   if(e.message != null){
                                      _error = e.message!;
                                   }
                                  isLoading = false;
                                });
                            
                            }
                          }
                        },
                        child: const Text("Submit")),
                        showLoading(isLoading),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
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
