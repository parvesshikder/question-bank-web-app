import 'dart:html';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:questionbankleggasi/2_application/core/constants/color_constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/question_maker_popup.dart';

class QuestionMakerDashboard extends StatelessWidget {
  const QuestionMakerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: CustomElevatedButton(
              bordRadious: 4.0,
              height: 50.0,
              color: primaryColor,
              onPress: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return QuestionMakerPopup();
                  },
                );
              },
              textColor: const Color(0xFFDA982A),
              child: const SizedBox(
                child: Text(
                  'Add Question',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
