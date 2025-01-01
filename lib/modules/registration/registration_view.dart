import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_project/core/firebase_utils.dart';
import 'package:todo_project/core/page_routes_names.dart';
import 'package:todo_project/core/services/sank_bar_service.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  bool isObscured = true;
  TextEditingController userNameController = TextEditingController();

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
          title: const Text("Create Account"),
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
                  TextFormField(
                    controller: userNameController,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,

                    ),
                    validator: (value) {
                      if(value == null || value.trim().isEmpty){
                        return"plz enter your full name";
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Full Name " , style:
                      theme.textTheme.displayMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),),
                      suffixIcon: const Icon(Icons.person),
                      hintText: "Enter your full name ",
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
                      label: Text("E-mal" , style:
                      theme.textTheme.displayMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),),
                      suffixIcon: Icon(Icons.email),
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
                  const SizedBox(height: 30,),
                  FilledButton(onPressed: (){
                    if(formKey.currentState!.validate()){
                      FirebaseUtils.createUserWithEmailAndPassword(
                          emailController.text, passwordController.text).then(
                              (value) {
                                if(value){
                                  EasyLoading.dismiss();
                                  SnackBarService.showSuccessMessage("Account Created Successful");
                                  Navigator.pop(context);
                                }
                              });
                    }

                  },
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 12),

                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Create Account " , style:
                        theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),),
                        const Icon(Icons.arrow_forward,size:30,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}

