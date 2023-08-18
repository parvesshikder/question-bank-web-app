import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package
import 'package:dartz/dartz.dart';
import 'package:questionbankleggasi/1_domain/entities/question_taker_entities.dart'; // Import the Either type from the dartz package

class QuestionTakerUseCases {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, dynamic>> getQuestionsDataFromFirebase(
      ) async {
    try {
      // TODO: Implement Firebase authentication and data fetching here
      // For example, you can use FirebaseAuth for authentication

      // Simulating a successful data retrieval for demonstration purposes
      final querySnapshot = await _firestore.collection('questions').get();
      
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs;
        // final questionData = QuestionTakerEntities(
        //   question: doc['question'],
        //   answerA: doc['a'],
        //   answerB: doc['b'],
        //   answerC: doc['c'],
        //   answerD: doc['d'],
        //   topic: doc['topic'],
        //   difficultyLevel: doc['difficultyLevel'],
        //   numberObjective: doc['objective'],
        // );
        return Right(doc); // Return the fetched data wrapped in the Right constructor
      } else {
        return Left(Failure("No question data found"));
      }
    } catch (e) {
      return Left(Failure("Failed to fetch question data")); // Return an error wrapped in the Left constructor
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);
}
