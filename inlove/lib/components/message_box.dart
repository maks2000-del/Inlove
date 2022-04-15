import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String title;
  final String message;
  final bool memoryBox;
  final List<int>? photosId;

  const MessageBox({
    Key? key,
    required this.title,
    required this.message,
    required this.memoryBox,
    this.photosId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
