// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'question_taker_cubit.dart';

@immutable
abstract class QuestionTakerState {}

class QuestionTakerInitial extends QuestionTakerState {}

class QuestionTakerLoading extends QuestionTakerState {}

class QuestionTakerLoadedWithQuestion extends QuestionTakerState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> datasnapshot;


  QuestionTakerLoadedWithQuestion({
    required this.datasnapshot,
    
  });
}

class QuestionTakerPayment extends QuestionTakerState {}

class QuestionTakerError extends QuestionTakerState {
  final String errorMessage;

  QuestionTakerError({required this.errorMessage});
}
