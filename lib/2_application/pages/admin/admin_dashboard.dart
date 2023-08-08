import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_elevated_button.dart';
import 'package:questionbankleggasi/2_application/core/widget/custom_input_button.dart';
import 'dart:html' as html;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _currentPage = 0;

  late _DataSource _dataSource;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDat();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogContent();
      },
    );
  }

  void getDat() {
    _dataSource = _DataSource();

    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'questionMaker')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.size > 0) {
        setState(() {
          _dataSource.personData =
              snapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return {
              'fullName': data['fullName'] as String,
              'email': data['email'] as String,
              'password': data['password'] as String,
              'agemakequestion': data['agemakequestion'] as String,
              'subject': data['subject'] as String,
              'uniqueCode': data['uniqueCode'] as String,
            };
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userType', isEqualTo: 'questionMaker')
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: Lottie.asset(loading, height: 200, width: 200),
              ),
            );
          }

          final snapshotData = snapshot.requireData;

          if (snapshotData.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showDialog(context);
                    },
                    label: const Text(
                      'Create New Account for Question Maker',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      fixedSize: const Size(250, 60),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        'No records found',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showDialog(context);
                    },
                    label: const Text(
                      'Create New Account for Question Maker',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      fixedSize: const Size(250, 60),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: _dataSource.getRowCount() > 0
                        ? PaginatedDataTable(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            arrowHeadColor: Colors.red,
                            columns: [
                              const DataColumn(
                                label: Text('Name'),
                              ),
                              const DataColumn(
                                label: Text('Email'),
                              ),
                              const DataColumn(
                                label: Text('Password'),
                              ),
                              const DataColumn(
                                label: Text('Unique Code'),
                              ),
                              const DataColumn(
                                label: Text('Subject'),
                              ),
                              const DataColumn(
                                label: Text('Age Maker Question'),
                              ),
                            ],
                            source: _dataSource,
                            onPageChanged: (int newPage) {
                              setState(() {
                                _currentPage = newPage;
                              });
                            },
                            rowsPerPage: _rowsPerPage,
                          )
                        : const Text('No data found'),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Rows per page:'),
                      const SizedBox(width: 10),
                      DropdownButton<int>(
                        value: _rowsPerPage,
                        items: [10, 25, 50, 100].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _rowsPerPage = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  String _searchQuery = '';

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  late List<Map<String, String>> personData;

  List<Map<String, String>> getFilteredData() {
    if (_searchQuery.isEmpty) {
      return personData;
    }

    final lowerCaseQuery = _searchQuery.toLowerCase();

    return personData.where((person) {
      final fullName = person['fullName']?.toLowerCase() ?? '';
      final email = person['email']?.toLowerCase() ?? '';
      final password = person['password']?.toLowerCase() ?? '';
      final agemakequestion = person['agemakequestion']?.toLowerCase() ?? '';
      final subject = person['subject']?.toLowerCase() ?? '';
      final uniqueCode = person['uniqueCode']?.toLowerCase() ?? '';

      return fullName.contains(lowerCaseQuery) ||
          email.contains(lowerCaseQuery) ||
          password.contains(lowerCaseQuery) ||
          agemakequestion.contains(lowerCaseQuery) ||
          subject.contains(lowerCaseQuery) ||
          uniqueCode.contains(lowerCaseQuery);
    }).toList();
  }

  int getRowCount() {
    final filteredData = getFilteredData();
    return filteredData.length;
  }

  @override
  DataRow? getRow(int index) {
    final filteredData = getFilteredData();

    if (index >= filteredData.length) return null;

    final person = filteredData[index];

    return DataRow(cells: [
      DataCell(Text(person['fullName'] ?? '')),
      DataCell(Text(person['email'] ?? '')),
      DataCell(Text(person['password'] ?? '')),
      DataCell(Text(person['uniqueCode'] ?? '')),
      DataCell(Text(person['subject'] ?? '')),
      DataCell(Text(person['agemakequestion'] ?? '')),
    ]);
  }

  @override
  int get rowCount => getRowCount();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class DialogContent extends StatefulWidget {
  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController agemakequestionController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController uniqueCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
    required String uniqueCode,
    required BuildContext context,
    required String agemakequestion,
    required String subject,
  }) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        // Send verification email to the user
        await user.sendEmailVerification();

        Navigator.of(context).pop();

        AnimatedSnackBar.material(
          'A new account has been successfully created',
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

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fullName': name,
          'email': email,
          'password': password,
          'uniqueCode': uniqueCode,
          'agemakequestion': agemakequestion,
          'subject': subject,
          'uid': user.uid,
          'userType': 'questionMaker',
        });

        html.window.location.reload();
      }
    } on FirebaseAuthException catch (e) {
      // Do something with the exception
      Navigator.of(context).pop();
      AnimatedSnackBar.material(
        e.toString(),
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

    await app.delete();
    return Future.sync(() => userCredential!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      title: const Center(child: Text('Create Account for Question Maker')),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Container(
          width: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: nameController,
                    obscureText: false,
                    title: 'Full Name',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: agemakequestionController,
                    obscureText: false,
                    title: 'Age Make Question',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.pin,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: subjectController,
                    obscureText: false,
                    title: 'Subject (Ex: Math, English)',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.menu_book,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: uniqueCodeController,
                    obscureText: false,
                    title: 'Unique Code',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.pin,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: emailController,
                    obscureText: false,
                    title: 'Email',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.email,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInputButton(
                    controller: passwordController,
                    obscureText: true,
                    title: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    prefixIconUrl: const Icon(
                      Icons.password,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    bordRadious: 4.0,
                    height: 50.0,
                    color: const Color(0xFFE0003E),
                    onPress: () {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          subjectController.text.isNotEmpty &&
                          uniqueCodeController.text.isNotEmpty) {
                        // Call the register method with the selected user type
                        register(
                          context: context,
                          email: emailController.text,
                          subject: subjectController.text,
                          agemakequestion: agemakequestionController.text,
                          name: nameController.text,
                          password: passwordController.text,
                          uniqueCode: uniqueCodeController.text,
                        );
                      } else {
                        AnimatedSnackBar.material(
                          'Failed, Enter all the values',
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
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.topCenter,
                        ).show(context);
                      }
                    },
                    textColor: const Color(0xFFDA982A),
                    child: const SizedBox(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
