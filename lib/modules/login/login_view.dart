import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_project/core/page_routes_names.dart';

import '../../core/firebase_utils.dart';
import '../../core/services/sank_bar_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    var mediaQuery =MediaQuery.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(image: AssetImage("assets/images/background@2x.png")
        , fit: BoxFit.cover)
      ),
       child: Scaffold(
         backgroundColor: Colors.transparent,
         appBar: AppBar(
           title: const Text("Login"),
         ),
         body: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Form(
               key:formKey ,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: mediaQuery.size.height *0.2,),
                  Text("Welcome back !",style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: emailController,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (value) {
                      if(value == null || value.trim().isEmpty){
                        return"plz enter your email";
                      }
                      var emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if(!emailRegex.hasMatch(value)){
                        return"invalid email";
                      }

                      },
                    decoration: InputDecoration(
                      label: Text("E-mail" , style:
                        theme.textTheme.displayMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),),
                      suffixIcon: const Icon(Icons.email),
                      hintText: "Enter your email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: passwordController,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,

                    ),
                    validator: (value) {
                      if(value == null || value.trim().isEmpty){
                        return"plz enter your password";
                      }
                    },
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      label: Text("password" , style:
                      theme.textTheme.displayMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),),
                      suffixIcon: InkWell(
                          onTap:(){
                            setState(() {
                              isObscured =!isObscured;
                            });

                          },
                          child: Icon(
                              isObscured ? Icons.visibility :
                          Icons.visibility_off)),
                      hintText: "Enter your password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text("Forget password?" , style:
                    theme.textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 12),
                    child: FilledButton(onPressed: (){
                      if (formKey.currentState?.validate() ?? false) {
                        FirebaseUtils.signIn(
                            emailController.text, passwordController.text).then(
                                (value) {
                              if (value) {
                                EasyLoading.dismiss();
                                Navigator.pushReplacementNamed(
                                    context, PageRouteName.layout);
                              }
                            });
                      }
                    },
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ),

                      child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login " , style:
                          theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),),
                        const Icon(Icons.arrow_forward,size:30,)
                      ],
                    ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, PageRouteName.registration);
                    },
                    child: Text("Or create my account" , style:
                    theme.textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),),
                  )

                ],
               ),
             ),
           ),
         ),

         ),
    );
  }
}
