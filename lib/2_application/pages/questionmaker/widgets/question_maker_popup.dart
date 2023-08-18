import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:questionbankleggasi/2_application/core/constants/imagepath_constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_popup_signup.dart';
import 'package:uuid/uuid.dart';

enum Users { easy, medium, hard }

class QuestionMakerPopup extends StatefulWidget {
  @override
  _QuestionMakerPopupState createState() => _QuestionMakerPopupState();
}

class _QuestionMakerPopupState extends State<QuestionMakerPopup> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerAController = TextEditingController();
  TextEditingController answerBController = TextEditingController();
  TextEditingController answerCController = TextEditingController();
  TextEditingController answerDController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController objectiveController = TextEditingController();

  Users? _selectedDifficultyType = Users.easy;

  final _firebaseAuth = FirebaseAuth.instance;

  var uuidIn = Uuid();

   String randomValue = '';

  @override
  void initState() {
    super.initState();
    generateRandomValue();
  }

  void generateRandomValue() {
    randomValue = uuidIn.v4(); // Use v4 method to generate a random UUID
  }

  void _uploadQuestion() async {
   
    if (questionController.text.isNotEmpty &&
        answerAController.text.isNotEmpty &&
        answerBController.text.isNotEmpty &&
        answerCController.text.isNotEmpty &&
        answerDController.text.isNotEmpty &&
        topicController.text.isNotEmpty &&
        objectiveController.text.isNotEmpty) {
      try {
        final userCredential = _firebaseAuth.currentUser;
        await FirebaseFirestore.instance
            .collection('questions')
            .doc(randomValue)
            .set({
          'question': questionController.text,
          'a': answerAController.text,
          'b': answerBController.text,
          'c': answerCController.text,
          'd': answerDController.text,
          'topic': topicController.text,
          'objective': objectiveController.text,
          'difficultyLevel': _selectedDifficultyType.toString(),
          'authorEmail': userCredential!.email,
          'authorUid': userCredential.uid,
          'documentId': randomValue,
        });

        AnimatedSnackBar.material(
          'Question Uploaded Successfully',
          type: AnimatedSnackBarType.success,
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
      } catch (e) {
        AnimatedSnackBar.material(
          'Error Uploading Question',
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

      Navigator.of(context).pop();
    } else {
      AnimatedSnackBar.material(
        'Please Fill All Fields',
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
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text('Add New Question')),
      ),
      content: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Container(
              width: 650,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        CustomInputButton(
                          controller: questionController,
                          mline: 5,
                          obscureText: false,
                          title: 'Question (Words Only)',
                          textInputType: TextInputType.emailAddress,
                          prefixIconUrl: const Icon(
                            Icons.question_mark,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomInputButton(
                          controller: answerAController,
                          obscureText: false,
                          title: 'Answer (Words Only)',
                          textInputType: TextInputType.visiblePassword,
                          prefixIconUrl: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.a,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomInputButton(
                          controller: answerBController,
                          obscureText: false,
                          title: 'Answer (Words Only)',
                          textInputType: TextInputType.visiblePassword,
                          prefixIconUrl: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.b,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomInputButton(
                          controller: answerCController,
                          obscureText: false,
                          title: 'Answer (Words Only)',
                          textInputType: TextInputType.visiblePassword,
                          prefixIconUrl: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.c,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomInputButton(
                          controller: answerDController,
                          obscureText: false,
                          title: 'Answer (Words Only)',
                          textInputType: TextInputType.visiblePassword,
                          prefixIconUrl: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FaIcon(
                              FontAwesomeIcons.d,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomElevatedButton(
                          bordRadious: 4.0,
                          height: 50.0,
                          color: const Color(0xFFE0003E),
                          onPress: () => _uploadQuestion(),
                          textColor: const Color(0xFFDA982A),
                          child: const SizedBox(
                            child: Text(
                              'Add',
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
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Enter Topic Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputButton(
                        controller: topicController,
                        obscureText: false,
                        title: 'One Only',
                        textInputType: TextInputType.visiblePassword,
                        prefixIconUrl: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FaIcon(
                            FontAwesomeIcons.hashtag,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Easy / Medium / Hard',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio<Users>(
                                value: Users.easy,
                                groupValue: _selectedDifficultyType,
                                onChanged: (Users? value) {
                                  setState(() {
                                    _selectedDifficultyType = value;
                                  });
                                },
                              ),
                              const Text(' Easy '),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<Users>(
                                value: Users.medium,
                                groupValue: _selectedDifficultyType,
                                onChanged: (Users? value) {
                                  setState(() {
                                    _selectedDifficultyType = value;
                                  });
                                },
                              ),
                              const Text(' Medium '),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<Users>(
                                value: Users.hard,
                                groupValue: _selectedDifficultyType,
                                onChanged: (Users? value) {
                                  setState(() {
                                    _selectedDifficultyType = value;
                                  });
                                },
                              ),
                              const Text(' Hard '),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Number Objectives (1,3,4)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputButton(
                        controller: objectiveController,
                        obscureText: false,
                        title: 'Multiples',
                        textInputType: TextInputType.visiblePassword,
                        prefixIconUrl: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FaIcon(
                            FontAwesomeIcons.hashtag,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
            generateRandomValue();
          },
        ),
      ],
    );
  }
}
