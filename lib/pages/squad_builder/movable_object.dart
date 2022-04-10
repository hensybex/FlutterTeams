import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:black_pearl/pages/squad_builder/dropzone_widget.dart';

/* class DisplayPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
          left: position1.value.dx,
          top: position1.value.dy - 56,
          child: Draggable(
            feedback: child,
            childWhenDragging: Opacity(
              opacity: .03,
              child: child,
            ),
            onDragEnd: (details) => position1.value = details.offset,
            child: child,
          ),
        );
} */

class DragArea extends HookWidget {
  late int acceptedData = 0;
  final Widget child;
  final double xPos1,
      yPos1,
      xPos2,
      yPos2,
      xPos3,
      yPos3,
      xPos4,
      yPos4,
      xPos5,
      yPos5,
      xPos6,
      yPos6,
      xPos7,
      yPos7,
      xPos8,
      yPos8;

  DragArea(
      {required this.child,
      required this.xPos1,
      required this.yPos1,
      required this.xPos2,
      required this.yPos2,
      required this.xPos3,
      required this.yPos3,
      required this.xPos4,
      required this.yPos4,
      required this.xPos5,
      required this.yPos5,
      required this.xPos6,
      required this.yPos6,
      required this.xPos7,
      required this.yPos7,
      required this.xPos8,
      required this.yPos8})
      : super();

  @override
  Widget build(BuildContext context) {
    final position1 = useState(Offset(xPos1, yPos1));
    final position2 = useState(Offset(xPos2, yPos2));
    final position3 = useState(Offset(xPos3, yPos3));
    final position4 = useState(Offset(xPos4, yPos4));
    final position5 = useState(Offset(xPos5, yPos5));
    final position6 = useState(Offset(xPos6, yPos6));
    final position7 = useState(Offset(xPos7, yPos7));
    final position8 = useState(Offset(xPos8, yPos8));

    var children2 = [
      displayPlayer(position5),
      targetMarker(position6),

      /* displayPlayer(position2),
      displayPlayer(position3),
      displayPlayer(position4),
      displayPlayer(position5),
      displayPlayer(position6),
      displayPlayer(position7),
      displayPlayer(position8), */
      /* Positioned(
        top: 100,
        left: 100,
        child: DragTarget(
          builder: (BuildContext context, List<dynamic> accepted,
                  List<dynamic> rejected) =>
              Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(color: Colors.cyan),
            child: Center(
              child: Text(acceptedData.toString()),
            ),
          ),
          onAccept: (int data) {
            acceptedData = data;
          },
        ),
      ), */
    ];

    return Stack(
      children: children2,
    );
  }

  Positioned targetMarker(ValueNotifier<Offset> position) {
    bool isHighlighted = false;
    final colorBackground = isHighlighted
        ? Colors.blue.withOpacity(0.5)
        : Colors.green.withOpacity(0.5);

    return Positioned(
      left: position.value.dx,
      top: position.value.dy - 56,
      child: DragTarget<bool>(
        builder: (BuildContext context, List<dynamic> accepted,
                List<dynamic> rejected) =>
            Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: colorBackground,

            //shape: BoxShape.circle,
          ),
        ),
        //onAccept: (int data) {
        //  acceptedData = data;
        //},
      ),
    );
  }

  Positioned displayPlayer(ValueNotifier<Offset> position) {
    return Positioned(
      left: position.value.dx,
      top: position.value.dy - 56,
      child: Draggable(
        feedback: Card(
          child: Column(
            children: [
              Text("Player Photo"),
              Text("Player Name"),
            ],
          ),
        ),
        childWhenDragging: Opacity(
          opacity: .03,
          child: Card(
            child: Column(
              children: [
                Text("Player Photo"),
                Text("Player Name"),
              ],
            ),
          ),
        ),
        onDragEnd: (details) {
          position.value = details.offset;
          print(position.value.dx);
          print(position.value.dy);
        },
        child: Card(
          child: Column(
            children: [
              Text("Player Photo"),
              Text("Player Name"),
            ],
          ),
        ),
      ),
    );
  }

  setState(bool Function() param0) {}
}
