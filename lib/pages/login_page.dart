import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application/components/my_button.dart';
import 'package:news_application/components/my_textfield.dart';
import 'package:news_application/helper/helper_function.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
     // text controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ));

      // try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text
        );
        // pop loading circle
        if (context.mounted) Navigator.pop(context); 
      }
      // display any error
      on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.newspaper,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 25,),
                // message and slogan
                Text("News Application",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),
                ),
                const SizedBox(height: 25,),
            
                // email textfield
                MyTextField(hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                    const SizedBox(height: 10,),
            
                //password textfield
                 MyTextField(hintText: "Password",
                    obscureText: true,
                    controller: passwordController),
            
                    const SizedBox(height: 10,),
                    // forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
            
                // sign in button
                  MyButton(text: "Login", onTap: login,),
                  const SizedBox(height: 25,),
                  // dont have a account register here
                  Row(
                    children: [
                      Text("Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).colorScheme.primary
                      ),),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text("Register Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary
                        ),),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}