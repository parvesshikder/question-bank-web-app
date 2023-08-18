import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

part 'question_maker_state.dart';

class QuestionMakerCubit extends Cubit<QuestionMakerState> {
  QuestionMakerCubit({required BuildContext context}) : super(QuestionMakerInitial());

  void displayQuestion(){
    emit(QuestionMakerLoaded());

  }
}
