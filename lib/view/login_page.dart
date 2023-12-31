
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/components/Square_title.dart';
import 'package:login/components/my_button.dart';

import 'package:login/components/my_textfield.dart';
import 'package:login/models/DataModel.dart';
import 'package:login/view/product_page.dart';

class LoginPage extends StatefulWidget{

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // Navigator.push(
  Future<bool> callSignIn() async {
    final  response = await dio.get('http://tpcreative.me/login.json');
    final DataModel  data = DataModel.fromJson(response.data);
    if (kDebugMode) {
      print(data.data.message);
    }
    if(data.error == null && data.data.username == 'tpcreative.co@gmail.com'){
      return true;
    }
    return false;
  }

  void createWrongEmail() {
    showDialog(context: context, builder: (context) {
      return const AlertDialog(title: Text('Check username and password')
      );
    },);
  }

  //sign in method
  Future<void> signUserIn({required  callback}) async {
    if(passwordController.text.isEmpty){
      createWrongEmail();
    }else{
      showDialog(context: context, builder: (context) {
        return const Center(child: CircularProgressIndicator());
      });
      if(await callSignIn()){
        if (context.mounted) Navigator.of(context).pop();
        callback();
      }else{
        if (kDebugMode) {
          print('Sign in failed');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const SizedBox(height: 50),
                const Icon(Icons.lock,size: 100),
                const SizedBox(height:50),
                Text('Welcome to this page'
                    ,style: TextStyle(color: Colors.grey[700],fontSize: 16))
                ,const SizedBox(height:25),
                MyTextField(controller: usernameController,hintText: 'Username', obscureText: false),
                const SizedBox(height: 10),
                MyTextField(controller: passwordController,hintText: 'Password',obscureText: true),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Forgot Password?',style: TextStyle(color: Colors.grey[600]),),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                MyButton(onTap : () =>{
                  signUserIn(callback: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductPage()))
                  })
                }),
                const SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.5,color: Colors.grey[400],)),
                      const Text('Or continue with'),
                      Expanded(child: Divider(thickness: 0.5,color: Colors.grey[400],))
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTitle(imagePath: 'lib/images/ic_google.png',),
                    SizedBox(width: 10,),
                    SquareTitle(imagePath: 'lib/images/ic_apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',style: TextStyle(color: Colors.grey[700]),),
                    const SizedBox(width: 4,),
                    const Text('Register now',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                  ],)


                //username textfield
                //password textfield
                //forget password
                //sign in butto
              ],),
          ),
        ),
      ),
    );
  }
}