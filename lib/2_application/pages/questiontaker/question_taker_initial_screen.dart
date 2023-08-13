import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';

class QuestionTakerInitialScreen extends StatefulWidget {
  QuestionTakerInitialScreen({super.key});

  @override
  State<QuestionTakerInitialScreen> createState() =>
      _QuestionTakerInitialScreenState();
}

class _QuestionTakerInitialScreenState
    extends State<QuestionTakerInitialScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController questionNumberController = TextEditingController();

  String dropdownValue_age = '7';
  String dropdownValue_subject = 'Math';
  String dropdownValue_topic = 'Topic 1';

  void isEmailValid(String email) {
    bool checkEmail = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);

    if (checkEmail == false) {
      AnimatedSnackBar.material(
        'Invalid Email',
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
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }

  void generateQuestion(String dropdownvalueAge, String text, int parse,
      String dropdownvalueSubject, String dropdownvalueTopic) {
        print('object');
    if (emailController.text.isNotEmpty &&
        questionNumberController.text.isNotEmpty) {
      //isEmailValid(emailController.text);
    } else {
      AnimatedSnackBar.material(
        'Enter all fields',
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
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            color: Colors.blue[100],
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Generate Question',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomInputButton(
                      controller: emailController,
                      obscureText: false,
                      title: 'Enter your email',
                      textInputType: TextInputType.visiblePassword,
                      prefixIconUrl: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Step 1.

// Step 2.
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: 400,
                    child: DropdownButton<String>(
                      // Step 3.
                      value: dropdownValue_age,
                      // Step 4.
                      underline: Container(),
                      items: <String>['7', '8', '9', '10']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue_age = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Step 1.

// Step 2.
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: 400,
                    child: DropdownButton<String>(
                      // Step 3.
                      value: dropdownValue_subject,
                      // Step 4.
                      underline: Container(),
                      items: <String>['Math', 'Islam', 'Scince', 'English']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue_subject = newValue!;
                        });
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Step 1.

// Step 2.
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: 400,
                    child: DropdownButton<String>(
                      // Step 3.
                      value: dropdownValue_topic,
                      // Step 4.
                      underline: Container(),
                      items: <String>[
                        'Topic 1',
                        'Topic 2',
                        'Topic 3',
                        'Topic 4'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue_topic = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomInputButton(
                      controller: questionNumberController,
                      obscureText: false,
                      title: 'How many question you need',
                      textInputType: TextInputType.visiblePassword,
                      prefixIconUrl: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.pin),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomElevatedButton(
                      bordRadious: 4.0,
                      height: 50.0,
                      color: const Color(0xFFE0003E),
                      onPress: ()=>
                        generateQuestion(
                            dropdownValue_age,
                            emailController.text,
                            int.parse(questionNumberController.text),
                            dropdownValue_subject,
                            dropdownValue_topic),
                      
                      textColor: const Color(0xFFDA982A),
                      child: const SizedBox(
                        child: Text(
                          'Gererate Question',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
