import 'dart:io';
import 'package:Prism/global/svgAssets.dart';
import 'package:Prism/routes/routing_constants.dart';
import 'package:Prism/theme/jam_icons_icons.dart';
import 'package:Prism/theme/themeModeProvider.dart';
import 'package:Prism/ui/pages/profile/reviewScreen.dart';
import 'package:Prism/ui/widgets/animated/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Prism/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Prism/logger/logger.dart';
import 'package:Prism/global/globals.dart' as globals;

class DraftSetupScreen extends StatefulWidget {
  const DraftSetupScreen();

  @override
  _DraftSetupScreenState createState() => _DraftSetupScreenState();
}

class _DraftSetupScreenState extends State<DraftSetupScreen> {
  Future<bool> onWillPop() async {
    if (navStack.length > 1) navStack.removeLast();
    logger.d(navStack.toString());
    return true;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final CollectionReference draftSetups = firestore.collection('draftSetups');
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            "Setup Drafts",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: draftSetups
                .where("email", isEqualTo: globals.prismUser.email)
                .where("review", isEqualTo: false)
                .orderBy('created_at', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Loader(),
                );
              } else {
                if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length ?? 0,
                    itemBuilder: (context, index) =>
                        SetupTile(snapshot.data!.docs[index], true),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                          "Your saved setup drafts show up here. Simply click the Save button when uploading a setup to save the draft."),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}
