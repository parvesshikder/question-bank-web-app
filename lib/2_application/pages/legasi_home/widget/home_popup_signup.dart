import 'package:flutter/material.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_popup_login.dart';

class DialogContentSignUp extends StatefulWidget {
  @override
  _DialogContentSignUpState createState() => _DialogContentSignUpState();
}

class _DialogContentSignUpState extends State<DialogContentSignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      title: Center(child: Text('Create new Account')),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Container(
          width: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 150, child: Image.asset(logo)),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomInputButton(
                    controller: nameController,
                    obscureText: false,
                    title: 'Full Name',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: phoneNumberController,
                    obscureText: false,
                    title: 'Phone Number',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.call,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: addressController,
                    obscureText: false,
                    title: 'Address',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.home,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: emailController,
                    obscureText: false,
                    title: 'Email',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.email,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: passwordController,
                    obscureText: true,
                    title: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.password,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    bordRadious: 4.0,
                    height: 50.0,
                    color: const Color(0xFFE0003E),
                    onPress: () {
                      if (1 == 1) {
                        // Call the register method with the selected user type
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed, Enter all the values"),
                            backgroundColor: Color(0xFFF80026),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(100.0),
                          ),
                        );
                      }
                    },
                    textColor: const Color(0xFFDA982A),
                    child: const SizedBox(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Log In'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogContentLogin();
              },
            );
          },
        ),
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
