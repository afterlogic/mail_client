import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  final bool value;
  final Function(bool) onPressed;

  const Star({Key key, @required this.value, @required this.onPressed})
      : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  AnimationController _parentCtrl;
  Animation<double> _scaleAnimation;
  bool _isStarred;

  @override
  void initState() {
    super.initState();
    _isStarred = widget.value;
    _parentCtrl = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 130));
    _parentCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _parentCtrl.reverse();
      }
    });
    _parentCtrl.addListener(() {
      setState(() {});
    });
    _scaleAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
        new CurvedAnimation(parent: _parentCtrl, curve: Curves.easeInOut));
  }

  void _setStarred(bool isStarred) {
    _parentCtrl.forward(from: 0.0);
    setState(() => _isStarred = isStarred);
    widget.onPressed(isStarred);
  }

  @override
  Widget build(BuildContext context) {
    if (_isStarred) {
      return Transform.scale(
          scale: 1 + _scaleAnimation.value / 4,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.star, color: Colors.amber),
            onPressed: () => _setStarred(false),
          ));
    } else {
      return Transform.scale(
        scale: 1 - _scaleAnimation.value / 7,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.star_border,
            color: Theme.of(context).disabledColor.withOpacity(0.1),
          ),
          onPressed: () => _setStarred(true),
        ),
      );
    }
  }
}
