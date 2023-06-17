import 'dart:async' show Timer;
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart'
    show
        AlwaysStoppedAnimation,
        Animation,
        AnimationController,
        AnimationStatus,
        Axis,
        BoxDecoration,
        Brightness,
        BuildContext,
        Canvas,
        Center,
        Color,
        Colors,
        Column,
        Container,
        CurvedAnimation,
        Curves,
        CustomPaint,
        CustomPainter,
        ElevatedButton,
        FontWeight,
        MainAxisAlignment,
        MaterialApp,
        MaterialPageRoute,
        MediaQuery,
        ModalRoute,
        Paint,
        PaintingStyle,
        Path,
        Positioned,
        Row,
        Scaffold,
        SingleTickerProviderStateMixin,
        Size,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        TextStyle,
        ThemeData,
        TickerProviderStateMixin,
        Tween,
        Widget,
        runApp;
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart'
    show
        Brightness,
        Color,
        FontWeight,
        Size,
        SystemChrome,
        SystemUiOverlayStyle,
        rootBundle;
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:rive/rive.dart';

import 'flash_screen.dart';

void main() async {
  runApp(ScreenUtilInit(
      designSize: const Size(1600, 900),
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FlashScreen(),
        );
      }));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class DonationApp extends StatefulWidget {
  DonationApp({super.key});

  @override
  _DonationAppState createState() => _DonationAppState();
}

class _DonationAppState extends State<DonationApp>
    with TickerProviderStateMixin {
  late Artboard _riveArtboard;
  late RiveAnimationController _riveController;
  double totalDonation = 0;
  double liquidHeight = 0.0;
  String donationAmount = '0.0%';
  AnimationController? _animationController;
  late Animation<double> _busScaleAnimation;
  late AnimationController firstController;
  late Animation<double> firstAnimation;
  late AnimationController secondController;
  late Animation<double> secondAnimation;
  late AnimationController thirdController;
  late Animation<double> thirdAnimation;
  late AnimationController fourthController;
  late Animation<double> fourthAnimation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1000),
      vsync: this,
    );

    _busScaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );

    firstController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });
    Timer(const Duration(seconds: 2), () {
      firstController.forward();
    });
    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String inputValue = ModalRoute.of(context)!.settings.arguments as String;
    final path = FullScreenShapePainter()
        .createFullScreenPath(MediaQuery.of(context).size);

    String inputValue = ModalRoute.of(context)!.settings.arguments as String;
    final maxDonation = int.parse(inputValue);

    Size size = MediaQuery.of(context).size;
    if (totalDonation >= maxDonation) {
      _animationController?.forward(from: 0.0);
    }

    void _donate(double amount) {
      setState(() {
        totalDonation += amount;
        liquidHeight =
            totalDonation >= maxDonation ? 200 : (totalDonation / maxDonation);
        donationAmount =
            '${((totalDonation / maxDonation) * 100).toStringAsFixed(1)}%';
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Donation App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 51, 126, 103),
        body: Stack(
          children: [
            LiquidCustomProgressIndicator(
              value: liquidHeight, // Defaults to 0.5.
              valueColor: const AlwaysStoppedAnimation(
                  Colors.pink), // Defaults to the current Theme's accentColor.
              backgroundColor: const Color.fromARGB(255, 71, 113,
                  133), // Defaults to the current Theme's backgroundColor.
              direction: Axis
                  .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right).
              shapePath:
                  path, // A Path object used to draw the shape of the progress indicator. The size of the progress indicator is created from the bounds of this path.
            ),
            Positioned.fill(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      donationAmount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        wordSpacing: 3.sp,
                        color: Colors.white,
                      ),
                      textScaleFactor: 25.sp,
                    ),
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DonationButton(amount: 1000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 2000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 5000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 10000, onPressed: _donate),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 20.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DonationButton(amount: 20000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 50000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 100000, onPressed: _donate),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                      ),
                      DonationButton(amount: 200000, onPressed: _donate),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color.fromARGB(255, 162, 70, 190).withOpacity(.4)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DonationButton extends StatelessWidget {
  final double amount;
  final Function(double) onPressed;

  const DonationButton(
      {super.key, required this.amount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[300],
      ),
      child: Text(
        'NGN$amount',
        style: TextStyle(
          letterSpacing: 4.sp,
          height: 2.5.h,
          color: Colors.black,
          fontSize: 29.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FullScreenShapePainter extends CustomPainter {
  Path createFullScreenPath(Size size) {
    final path = Path()
      ..moveTo(0, 0) // Starting point
      ..lineTo(size.width, 0) // Top right corner
      ..lineTo(size.width, size.height) // Bottom right corner
      ..lineTo(0, size.height) // Bottom left corner
      ..close(); // Connects the last point to the starting point

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Not used in this implementation
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Since the shape doesn't change, we can return false here
  }
}
