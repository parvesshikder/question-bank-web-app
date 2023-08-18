// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/cubit/question_maker_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/cubit/question_taker_cubit.dart';
import 'package:pdf/pdf.dart';
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QuestionTakerLoadedWithQuestionPage extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

  const QuestionTakerLoadedWithQuestionPage({
    required this.data,
  });

  @override
  State<QuestionTakerLoadedWithQuestionPage> createState() =>
      _QuestionTakerLoadedWithQuestionPageState();
}

class _QuestionTakerLoadedWithQuestionPageState
    extends State<QuestionTakerLoadedWithQuestionPage> {
  String dLevel = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (widget.data[index]['difficultyLevel'] == "Users.easy") {
                  dLevel = 'Easy';
                } else if (widget.data[index]['difficultyLevel'] ==
                    "Users.medium") {
                  dLevel = 'Medium';
                } else if (widget.data[index]['difficultyLevel'] ==
                    "Users.hard") {
                  dLevel = 'Hard';
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text('Change Another Question')),
                        ],
                      )),
                      Expanded(
                          flex: 4,
                          child: Container(
                              height: 220,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                        child: Text(
                                      '${widget.data[index]['question']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('A : ${widget.data[index]['a']}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('B : ${widget.data[index]['a']}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('C : ${widget.data[index]['c']}'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('D : ${widget.data[index]['d']}'),
                                  ],
                                ),
                              ))),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.blue[100]),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    '${widget.data[index]['topic']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.blue[100]),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '$dLevel',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration:
                                  BoxDecoration(color: Colors.blue[100]),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    '${widget.data[index]['objective']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          CustomElevatedButton(
            bordRadious: 4.0,
            height: 50.0,
            color: Colors.blue,
            onPress: () async {
              // Create a PDF document
              final pdf = pw.Document();

              pdf.addPage(pw.Page(
                build: (pw.Context context) {
                  return pw.ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final doc = widget.data[index];
                      return pw.Container(
                        padding: pw.EdgeInsets.symmetric(vertical: 10),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Question ${index + 1}: ${doc["question"]}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),

                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'A. ${doc['a'] ?? ''}',
                                  ),
                                  pw.Text(
                                    'B. ${doc['b'] ?? ''}',
                                  ),
                                  pw.Text(
                                    '',
                                  ),
                                ]),
                            pw.SizedBox(height: 20),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'C. ${doc['c'] ?? ''}',
                                  ),
                                  pw.Text(
                                    'D. ${doc['d'] ?? ''}',
                                  ),
                                   pw.Text(
                                    '',
                                  ),
                                 
                                ]),
                            pw.SizedBox(height: 10),
                            // pw.Text(
                            //   'Correct Answer: ${doc['correctAnswer'] ?? ''}',
                            // ),
                            pw.SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
              ));

              // Generate the PDF file as bytes
              final pdfBytes = await pdf.save();

              // Create a Blob from the PDF bytes
              final blob = html.Blob([pdfBytes], 'application/pdf');

              // Create a download URL
              final url = html.Url.createObjectUrlFromBlob(blob);

              // Create a temporary anchor element to trigger the download
              final anchorElement =
                  html.document.createElement('a') as html.AnchorElement;
              anchorElement.href = url;
              anchorElement.download =
                  'mcq_questions.pdf'; // Specify the filename

              // Trigger the download
              anchorElement.click();

              // Revoke the download URL to release memory
              html.Url.revokeObjectUrl(url);

              // Show a toast or a dialog to indicate the download is completed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Download completed')),
              );
            },
            textColor: const Color(0xFFDA982A),
            child: const SizedBox(
              child: Text(
                'Pay & Download',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}
