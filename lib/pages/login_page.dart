import 'package:api_post_three/pages/home_page.dart';
import 'package:api_post_three/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

 final emailController = TextEditingController();
 final passwordController = TextEditingController();

 @override
 void dispose(){
   emailController.dispose();
   passwordController.dispose();
   super.dispose();
 }
 

  @override
  Widget build(BuildContext context) {
      final loginState = ref.watch(loginprovider);
      
      ref.listen(loginprovider, (previous, next) {
        next.whenOrNull(
          data: (auth) {
             if(auth != null && mounted){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Succussfull")));
             }
          },
          error: (error, stackTrace) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed $error")));
          },
          );
          
      },);

    return Scaffold(
      appBar: AppBar(title: const Text('Mentor Meter Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration( 
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: 
                    loginState.isLoading ?
                    null:
                (){
                        ref.read(loginprovider.notifier).login(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                      },

                child:
                   loginState.isLoading?
                    CircularProgressIndicator():
                 Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
