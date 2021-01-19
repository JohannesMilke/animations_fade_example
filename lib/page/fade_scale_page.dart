import 'package:animations/animations.dart';
import 'package:animations_fade_example/main.dart';
import 'package:animations_fade_example/widget/button_widget.dart';
import 'package:flutter/material.dart';

class FadeScalePage extends StatefulWidget {
  @override
  _FadeScalePageState createState() => _FadeScalePageState();
}

class _FadeScalePageState extends State<FadeScalePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  bool get isForwardAnimation =>
      controller.status == AnimationStatus.forward ||
      controller.status == AnimationStatus.completed;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 2000),
      reverseDuration: Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((status) => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonWidget(
                text: 'SHOW MODAL',
                onClicked: () => showCustomDialog(context),
              ),
              SizedBox(height: 24),
              ButtonWidget(
                text: isForwardAnimation ? 'HIDE FAB' : 'SHOW FAB',
                onClicked: toggleFAB,
              ),
            ],
          ),
        ),
        floatingActionButton: buildFloatingActionButton(),
      );

  Widget buildFloatingActionButton() => AnimatedBuilder(
        animation: controller,
        builder: (context, child) => FadeScaleTransition(
          animation: controller,
          child: child,
        ),
        child: Visibility(
          visible: controller.status != AnimationStatus.dismissed,
          child: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
        ),
      );

  Future toggleFAB() =>
      isForwardAnimation ? controller.reverse() : controller.forward();

  Future showCustomDialog(BuildContext context) => showModal(
        configuration: FadeScaleTransitionConfiguration(
          transitionDuration: Duration(seconds: 2),
          reverseTransitionDuration: Duration(seconds: 2),
        ),
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Animated Dialog'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCEL'),
            ),
          ],
        ),
      );
}
