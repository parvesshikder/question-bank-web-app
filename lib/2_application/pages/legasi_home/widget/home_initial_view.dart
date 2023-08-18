// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/hero_text.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/hero_text_details.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_popup_login.dart';

class HomeInitialView extends StatefulWidget {
  final double deviceWidth;
  final bool runInvalidLogIn;
  final String error;
  final String status;
  const HomeInitialView(
      {required this.deviceWidth,
      required this.runInvalidLogIn,
      this.error = '',
      this.status = ''});

  @override
  State<HomeInitialView> createState() => _HomeInitialViewState();
}

class _HomeInitialViewState extends State<HomeInitialView> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    if (widget.runInvalidLogIn == true && widget.error != '') {
      showSnakbarLegasiHome(context);
    } else if (widget.runInvalidLogIn == true && widget.status != '') {
      showSnakbarLegasiHomeVarificationEmail(context);
    }
    super.initState();
  }

  int questionCount = 0;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogContentLogin();
      },
    );
  }

  dynamic showSnakbarLegasiHome(BuildContext context) {
    return AnimatedSnackBar.material(
      widget.error,
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

  dynamic showSnakbarLegasiHomeVarificationEmail(BuildContext context) {
    return AnimatedSnackBar.material(
      widget.status,
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

  @override
  Widget build(BuildContext context) {
    bool _isHovered = false;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('questions').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  // Wrap with Container to control size
                  height:
                      MediaQuery.of(context).size.height, // Take up full height
                  child: Lottie.asset(loading, height: 200, width: 200),
                ),
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

           
            return deviceWidth > 700
                ? LargeDevice(context, _isHovered, snapshot)
                : SmallerDvice(context, _isHovered, snapshot);
          }),
    );
  }

  Padding SmallerDvice(BuildContext context, bool _isHovered,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 80, width: 200, child: Image.asset(logo)),
          const SizedBox(
            height: 50,
          ),
          HeroText(
              widget.deviceWidth,
              '''Unlocking Knowledge: Discover, Explore, and Download Questions & Answers''',
              color1Gradient),
          const SizedBox(
            height: 10,
          ),
          HeroTextDetails(widget.deviceWidth, 10),
          const SizedBox(
            height: 20,
          ),
          Text(
            '+ ${snapshot.data!.docs.length.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.deviceWidth > 700 ? 38 : 18,
              fontWeight: FontWeight.bold,
              //color: Colors.white, // Text color for the gradient effect
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '''Question Uploaded''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: greyext, // Text color for the gradient effect
            ),
          ),
          Container(
              height: 200,
              margin: const EdgeInsets.only(top: 0),
              child: Image.asset(banner)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  _showDialog(context);
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.white60; // Text color when hovered
                      }
                      return blackText; // Default text color
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Color(
                            0xff0a6cba); // Background color when hovered
                      }
                      return Colors.blue; // Default background color
                    },
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isHovered ? Colors.white70 : blackText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding LargeDevice(BuildContext context, bool _isHovered,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 100, width: 200, child: Image.asset(logo)),
              Expanded(
                child: Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 50.0),
                  child: MouseRegion(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          _showDialog(context);
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors
                                    .white60; // Text color when hovered
                              }
                              return blackText; // Default text color
                            },
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color(
                                    0xff0a6cba); // Background color when hovered
                              }
                              return Colors
                                  .transparent; // Default background color
                            },
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(10.0),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isHovered ? Colors.white70 : blackText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          HeroText(
              widget.deviceWidth,
              '''Unlocking Knowledge: Discover, Explore, and Download Questions & Answers''',
              color1Gradient),
          const SizedBox(
            height: 30,
          ),
          HeroTextDetails(widget.deviceWidth, 18),
          const SizedBox(
            height: 50,
          ),
          Text(
            '+ ${snapshot.data!.docs.length.toString()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.deviceWidth > 700 ? 38 : 18,
              fontWeight: FontWeight.bold,
              //color: Colors.white, // Text color for the gradient effect
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '''Question Uploaded''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: greyext, // Text color for the gradient effect
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 0),
              child: Image.asset(banner)),
        ],
      ),
    );
  }
}
