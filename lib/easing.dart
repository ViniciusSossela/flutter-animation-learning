import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EasingAnimationWidget extends StatefulWidget {
  @override
  EasingAnimationWidgetState createState() => EasingAnimationWidgetState();
}

class EasingAnimationWidgetState extends State<EasingAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    // _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.fastOutSlowIn,
    // ));

    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler);
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              body: Transform(
            transform:
                Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
            child: new Center(
                child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.black12,
            )),
          ));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class EasingAnimationWidgetState extends State<EasingAnimationWidget>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   Animation _animation;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
//     _animation = Tween(begin: -1.0, end: 0.0).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return AnimatedBuilder(
//         animation: _animationController,
//         builder: (BuildContext context, Widget child) {
//           return Scaffold(
//               body: Transform(
//             transform:
//                 Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
//             child: new Center(
//                 child: Container(
//               width: 200.0,
//               height: 200.0,
//               color: Colors.black12,
//             )),
//           ));
//         });
//   }
// }

class LoginAnimationWidget extends StatefulWidget {
  @override
  LoginAnimationWidgetState createState() => LoginAnimationWidgetState();
}

class LoginAnimationWidgetState extends State<LoginAnimationWidget>
    with TickerProviderStateMixin {
  Animation textAnimation;
  Animation buttonSqueezeAnimation;
  AnimationController loginButtonController;

  Future<Null> _playAnimation() async {
    // setState(() {});

    try {
      await loginButtonController.forward();
      await loginButtonController.reverse();
      await loginButtonController.forward();
      await loginButtonController.reverse();
      await loginButtonController.forward();
      await loginButtonController.reverse();
      await loginButtonController.forward();
      await loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

    loginButtonController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 50));

    buttonSqueezeAnimation = new Tween(
      begin: 50.0,
      end: 20.0,
    ).animate(new CurvedAnimation(
        parent: loginButtonController,
        curve: Curves.fastOutSlowIn)); //new Interval(0.0, 0.250)));

    textAnimation = new Tween(
      begin: 0.0,
      end: 120.0,
    ).animate(new CurvedAnimation(
        parent: loginButtonController,
        curve: Curves.bounceOut)); //new Interval(0.0, 0.250)));

    buttonSqueezeAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    loginButtonController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Scaffold(
  //     body: Center(
  //       child: Padding(
  //         padding: EdgeInsets.only(left: 50, right: 50),
  //         child: AnimatedBuilder(
  //             animation: textAnimation,
  //             child: new Container(
  //               // width: buttonSqueezeAnimation.value,
  //               height: 60.0,
  //               alignment: FractionalOffset.center,
  //               decoration: new BoxDecoration(
  //                   color: const Color.fromRGBO(247, 64, 106, 1.0),
  //                   borderRadius:
  //                       const BorderRadius.all(const Radius.circular(30.0))),
  //               child: InkWell(
  //                 onTap: () {
  //                   _playAnimation();
  //                 },
  //                 child: new Text(
  //                   "Sign In",
  //                   style: new TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.w300,
  //                     letterSpacing: 0.3,
  //                   ),
  //                 ),
  //                 // : new CircularProgressIndicator(
  //                 //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
  //                 //   ),
  //               ),
  //             ),
  //             builder: (context, Widget child) {
  //               return Transform.rotate(
  //                 angle: loginButtonController.value * 2.0 * pi,
  //                 child: child,
  //               );
  //             }),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: 50,
              right: 50),
          child: new Container(
            // width: buttonSqueezeAnimation.value,
            padding: EdgeInsets.only(left: textAnimation.value),
            height: 60.0,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
                color: const Color.fromRGBO(247, 64, 106, 1.0),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(30.0))),
            child: InkWell(
              onTap: () {
                _playAnimation();
              },
              child: new Text(
                "Sign In",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                ),
              ),
              // : new CircularProgressIndicator(
              //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              //   ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParentingAnimationWidget extends StatefulWidget {
  @override
  ParentingAnimationWidgetState createState() =>
      ParentingAnimationWidgetState();
}

class ParentingAnimationWidgetState extends State<ParentingAnimationWidget>
    with TickerProviderStateMixin {
  Animation growingAnimation;
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    growingAnimation = Tween(begin: 10.0, end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Scaffold(
              body: new Align(
                  alignment: Alignment.center,
                  child: new Container(
                      child: new Center(
                          child:
                              new ListView(shrinkWrap: true, children: <Widget>[
                    Transform(
                        transform: Matrix4.translationValues(
                            animation.value * width, 0.0, 0.0),
                        child: Center(
                            child: AnimatedBuilder(
                          animation: growingAnimation,
                          builder: (BuildContext context, Widget child) {
                            return new Center(
                                child: Container(
                              height: growingAnimation.value,
                              width: growingAnimation.value * 2,
                              color: Colors.black12,
                            ));
                          },
                        ))),
                    Transform(
                        transform: Matrix4.translationValues(
                          animation.value * width,
                          0.0,
                          0.0,
                        ),
                        child: new Center(
                            child: new Container(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            width: 200.0,
                            height: 100.0,
                            color: Colors.black12,
                          ),
                        ))),
                  ])))));
        });
  }
}
