import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/cubit/question_taker_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/question_taker_checkout.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/widgets/question_taker_initial_page.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/widgets/question_taker_loaded_withquestion.dart';

class QuestionTakerInitialScreen extends StatefulWidget {
  QuestionTakerInitialScreen({super.key});

  @override
  State<QuestionTakerInitialScreen> createState() =>
      _QuestionTakerInitialScreenState();
}

class _QuestionTakerInitialScreenState
    extends State<QuestionTakerInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<QuestionTakerCubit, QuestionTakerState>(
        builder: (context, state) {
          if (state is QuestionTakerInitial) {
            return QuestionTakerInitialPage(context: context, );
          } else if (state is QuestionTakerLoading) {
            return Center(
                child: Lottie.asset(loading, height: 200, width: 200));
          } else if (state is QuestionTakerLoadedWithQuestion) {
            return QuestionTakerLoadedWithQuestionPage(data: state.datasnapshot);
          }else if(state is QuestionTakerError){
            return QuestionTakerInitialPage(context: context, error: state.errorMessage,);
          }
          else if(state is QuestionTakerPayment){
            return StripePaymentScreen();
          }

          return Text('');
        },
      ),
    );
  }
}
