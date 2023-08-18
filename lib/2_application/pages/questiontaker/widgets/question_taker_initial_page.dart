import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/cubit/question_taker_cubit.dart';

class QuestionTakerInitialPage extends StatefulWidget {
  const QuestionTakerInitialPage({
    required this.context,
    this.error = '',
  });

  final BuildContext context;
  final String error;

  @override
  State<QuestionTakerInitialPage> createState() =>
      _QuestionTakerInitialPageState();
}

class _QuestionTakerInitialPageState extends State<QuestionTakerInitialPage> {
  @override
  void initState() {
    if (widget.error != '') {
      showSnakbarLegasiHome(context);
    }
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController questionNumberController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  String dropdownValue_age = '7';
  String dropdownValue_subject = 'Math';
  String dropdownValue_topic = 'Topic 1';

  dynamic showSnakbarLegasiHome(BuildContext context) {
    return AnimatedSnackBar.material(
      'Error on fatching data',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: 400,
            child: Column(
              children: [
                const SizedBox(
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

                        TextFormField(
                          initialValue: currentUser!.email,
                          enabled: false,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 224, 224, 224),
                            labelStyle: TextStyle(
                              color: Color(0xFFADA4A5),
                              fontSize: 14.0,
                            ),
                            prefixIcon: Padding(
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
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Choose 1 number only (Age)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
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
                                    style: const TextStyle(fontSize: 18),
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
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Choose 1 only (Subject)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
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
                            items: <String>[
                              'Math',
                              'Islam',
                              'Scince',
                              'English'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 18),
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
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Choose Topic',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
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
                                    style: const TextStyle(fontSize: 18),
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
                          height: 20,
                        ),
                        const Text(
                          'How many question you need',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: '50',
                          enabled: true,
                          maxLines: 1,
                          
                          decoration: const InputDecoration(
                            hintText: 'How many question you need',
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Color(0xFFADA4A5),
                              fontSize: 14.0,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.pin),
                            ),
                          ),
                        ),
                        
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 400,
                          child: CustomElevatedButton(
                            bordRadious: 4.0,
                            height: 50.0,
                            color: const Color(0xFFE0003E),
                            onPress: () {
                              BlocProvider.of<QuestionTakerCubit>(context)
                                  .generateQuestion();
                            },
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
          ),
        ),
      ),
    );
  }
}
