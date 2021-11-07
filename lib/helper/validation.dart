import 'package:flutter/material.dart';

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    String pattern =
       r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
} 

 showAlert(String error){
      if(error == ''){
        return const SizedBox();
      }
      return Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
                      color : Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            
            Flexible(child: Text(error)),

          ],
          ),

      );
  }

  showLoading(bool isLoading){
    if(isLoading){
      return const CircularProgressIndicator();
    }
    return const SizedBox();
  }