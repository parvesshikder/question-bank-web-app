import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionbankleggasi/2_application/core/constants/imagepath_constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_popup_signup.dart';

enum Users { public, admin, questionMaker }

class DialogContentLogin extends StatefulWidget {
  @override
  _DialogContentLoginState createState() => _DialogContentLoginState();
}

class _DialogContentLoginState extends State<DialogContentLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController uniqueCodeController = TextEditingController();

  bool showAdditionalFields = false; // Track button click

  String choosenUserType = '';

  Users? _selectedUserType = Users.public;

  



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text('Log In')),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Container(
          width: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150, child: Image.asset(logo)),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<Users>(
                            value: Users.public,
                            groupValue: _selectedUserType,
                            onChanged: (Users? value) {
                              setState(() {
                                _selectedUserType = value;
                              });
                            },
                          ),
                          const Text(' Teachers '),
                        ],
                      ),
                      Radio<Users>(
                        value: Users.questionMaker,
                        groupValue: _selectedUserType,
                        onChanged: (Users? value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                      ),
                      const Text(' Question Maker '),
                      Radio<Users>(
                        value: Users.admin,
                        groupValue: _selectedUserType,
                        onChanged: (Users? value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        },
                      ),
                      const Text(' Admin '),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputButton(
                controller: emailController,
                obscureText: false,
                title: 'Email',
                textInputType: TextInputType.emailAddress,
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
              _selectedUserType == Users.questionMaker
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              _selectedUserType == Users.questionMaker
                  ? CustomInputButton(
                      controller: uniqueCodeController,
                      obscureText: false,
                      title: 'Unique Code',
                      textInputType: TextInputType.name,
                      prefixIconUrl: const Icon(
                        Icons.confirmation_number,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                bordRadious: 4.0,
                height: 50.0,
                color: const Color(0xFFE0003E),
                onPress: () async {
                  Navigator.of(context).pop();


                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    if (_selectedUserType == Users.admin) {
                      choosenUserType = 'admin';
                    } else if (_selectedUserType == Users.public) {
                      choosenUserType = 'public';
                    } else if (_selectedUserType == Users.questionMaker) {
                      choosenUserType = 'questionMaker';
                    }

                 
                      BlocProvider.of<HomeCubit>(context).logInButtobClick(
                        email: emailController.text,
                        password: passwordController.text,
                        uType: choosenUserType
                      );
                   
                  } else {
                    AnimatedSnackBar.material(
                      'Invalid Id or Password',
                      type: AnimatedSnackBarType.error,
                      mobilePositionSettings: const MobilePositionSettings(
                        topOnAppearance: 100,
                        topOnDissapear: 50,
                        bottomOnAppearance: 100,
                        bottomOnDissapear: 50,
                        left: 20,
                        right: 70,
                      ),
                      mobileSnackBarPosition: MobileSnackBarPosition.top,
                      desktopSnackBarPosition:
                          DesktopSnackBarPosition.topCenter,
                    ).show(context);
                  }
                },
                textColor: const Color(0xFFDA982A),
                child: const SizedBox(
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Dont\'t have an account! Sign Up'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogContentSignUp();
              },
            );
          },
        ),
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
