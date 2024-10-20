import 'package:flutter/material.dart';

class NotifyModal extends StatefulWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed; // Made nullable

  const NotifyModal({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    this.onButtonPressed, // Made optional
  });

  @override
  State<NotifyModal> createState() => _NotifyModalState();

  static void show(
    BuildContext context,
    String title,
    String message,
    String buttonText, [
    VoidCallback? onButtonPressed, // Made optional
  ]) {
    showDialog(
      context: context,
      builder: (context) {
        return NotifyModal(
          title: title,
          message: message,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }
}

class _NotifyModalState extends State<NotifyModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
            if (widget.onButtonPressed != null) {
              widget.onButtonPressed!(); // Call the callback if it's provided
            }
          },
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}
