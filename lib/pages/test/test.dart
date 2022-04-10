import 'package:black_pearl/models/dropped.dart';
import 'package:black_pearl/pages/squad_builder/dropzone_widget.dart';
import 'package:black_pearl/pages/test/dropped_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:black_pearl/sevices/sidebar.dart';

class TestPage extends StatefulWidget {
  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  DroppedFile? file;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        drawer: SideBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DroppedFileWidget(file: file),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: DropzoneWidget(
                onDroppedFile: (file) => setState(() => this.file = file),
              ),
            ),
          ],
        ),
      );
}
