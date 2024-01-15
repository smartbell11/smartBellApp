import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_school_bill/style/fonts.dart';



class RoundedDialog2 extends StatefulWidget {
  final String title;
  final String message;
  final String imagePath;

  const RoundedDialog2(
      {super.key,
      required this.title,
      required this.message,
      required this.imagePath});

  @override
  _RoundedDialog2State createState() => _RoundedDialog2State();
}

class _RoundedDialog2State extends State<RoundedDialog2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(widget.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              widget.imagePath,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 5),
            Text(
              widget.message,
              style: robotoHuge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
