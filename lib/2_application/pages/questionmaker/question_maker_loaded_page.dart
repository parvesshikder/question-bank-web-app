import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart'; // Import Firestore package

class QuestionMakerLoadedPage extends StatelessWidget {
  const QuestionMakerLoadedPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('questions').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(loading, height: 200, width: 200),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('You haven\'t uploaded any questions.'),
            ),
          );
        }

        List<Map<String, dynamic>> data = snapshot.data!.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 950,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //height: 220,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Text(
                                  '${data[index]['question']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10), // Adding spacing
                              Text('A : ${data[index]['a']}'),
                              SizedBox(height: 10), // Adding spacing
                              Text('B : ${data[index]['b']}'),
                              SizedBox(height: 10), // Adding spacing
                              Text('C : ${data[index]['c']}'),
                              SizedBox(height: 10), // Adding spacing
                              Text('D : ${data[index]['d']}'),
                              SizedBox(height: 20), // Adding spacing
              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implement edit functionality here
                                      _showEditPopup(context, data[index]);
                                    },
                                    child: Text('Edit'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implement delete functionality here
                                      _showDeletePopup(
                                          context, data[index]['question']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    child: Text(
                                      'Delete',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditPopup(BuildContext context, Map<String, dynamic> questionData) {
    TextEditingController questionController =
        TextEditingController(text: questionData['question']);
    TextEditingController answerAController =
        TextEditingController(text: questionData['a']);
    TextEditingController answerBController =
        TextEditingController(text: questionData['b']);
    TextEditingController answerCController =
        TextEditingController(text: questionData['c']);
    TextEditingController answerDController =
        TextEditingController(text: questionData['d']);
    TextEditingController topicController =
        TextEditingController(text: questionData['topic']);
    TextEditingController objectiveController =
        TextEditingController(text: questionData['objective']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Question'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: questionController,
                    decoration: InputDecoration(labelText: 'Question')),
                TextField(
                    controller: answerAController,
                    decoration: InputDecoration(labelText: 'Answer A')),
                TextField(
                    controller: answerBController,
                    decoration: InputDecoration(labelText: 'Answer B')),
                TextField(
                    controller: answerCController,
                    decoration: InputDecoration(labelText: 'Answer C')),
                TextField(
                    controller: answerDController,
                    decoration: InputDecoration(labelText: 'Answer D')),
                TextField(
                    controller: topicController,
                    decoration: InputDecoration(labelText: 'Topic')),
                TextField(
                    controller: objectiveController,
                    decoration: InputDecoration(labelText: 'Objective')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the question in Firestore

                try {
                  await FirebaseFirestore.instance
                      .collection('questions')
                      .doc(questionData[
                          'documentId']) // Provide the correct document ID here
                      .update({
                    'question': questionController.text,
                    'a': answerAController.text,
                    'b': answerBController.text,
                    'c': answerCController.text,
                    'd': answerDController.text,
                    'topic': topicController.text,
                    'objective': objectiveController.text,
                  });

                  AnimatedSnackBar.material(
                    'Updated Sucessfully',
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
                    'Faild to Upload the Question',
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
                }

                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeletePopup(BuildContext context, String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Question'),
          content: Text('Are you sure you want to delete this question?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                // Delete the question from Firestore
                await FirebaseFirestore.instance
                    .collection('questions')
                    .where('question', isEqualTo: question)
                    .get()
                    .then((querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    doc.reference.delete();
                  });
                });

                Navigator.pop(context); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
