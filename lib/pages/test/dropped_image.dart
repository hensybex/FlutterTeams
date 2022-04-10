import 'package:black_pearl/models/dropped.dart';
import 'package:black_pearl/pages/squad_builder/dropzone_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:black_pearl/sevices/sidebar.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => buildImage();

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No file');

    return Container();
  }

  Widget buildEmptyFile(String text) => Container(
      width: 120,
      height: 120,
      color: Colors.blue.shade300,
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: Colors.white),
      )));
}
