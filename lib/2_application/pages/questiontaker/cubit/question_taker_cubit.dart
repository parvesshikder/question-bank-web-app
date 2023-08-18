import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:questionbankleggasi/1_domain/usecases/question_taker_usecases.dart';

part 'question_taker_state.dart';

class QuestionTakerCubit extends Cubit<QuestionTakerState> {
  QuestionTakerCubit({required BuildContext context})
      : super(QuestionTakerInitial());
  QuestionTakerUseCases questionTakerUseCases = QuestionTakerUseCases();
  Future<void> generateQuestion() async {
    emit(QuestionTakerLoading());
    final response = await questionTakerUseCases.getQuestionsDataFromFirebase();
    response.fold(
      (failure) {
        emit(QuestionTakerError(errorMessage: failure.toString()));
      },
      (success) {
        emit(QuestionTakerLoadedWithQuestion(
          datasnapshot: success
        ));
      },
    );
  }

  Future<void> payment() async {
    emit(QuestionTakerLoading());
    emit(QuestionTakerPayment());
  }
}
