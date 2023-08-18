part of 'question_maker_cubit.dart';

@immutable
abstract class QuestionMakerState {}

class QuestionMakerInitial extends QuestionMakerState {}

class QuestionMakerLoading extends QuestionMakerState {}

class QuestionMakerLoaded extends QuestionMakerState {}
