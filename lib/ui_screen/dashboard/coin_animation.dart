import 'package:flutter/material.dart';

class CoinAnimation extends StatefulWidget {
  final double startX;
  final double startY;
  final double endX;
  final double endY;

  CoinAnimation(
      {required this.startX,
      required this.startY,
      required this.endX,
      required this.endY});

  @override
  _CoinAnimationState createState() => _CoinAnimationState();
}

class _CoinAnimationState extends State<CoinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<Offset>(
      // begin: Offset(widget.startX, widget.startY),
      // end: Offset(widget.endX, widget.endY),
      begin: Offset(widget.startX, widget.startY),
      end: Offset(widget.endX, widget.endY),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: Opacity(
            opacity: 1.0 - _controller.value,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
