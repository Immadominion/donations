import 'dart:async' show Timer;
import 'package:lottie/lottie.dart';

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
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FlashScreen(),
  ));
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
  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/car.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _riveArtboard = file.mainArtboard;
      _riveController = SimpleAnimation('idle');
    });
  }

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
  late final AnimationController _ontroller;

  //int maxDonation = int.parse();

  @override
  void initState() {
    _loadRiveFile();
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
    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  // void _loadRiveFile() async {
  //   // Load the Rive file
  //   final bytes = await rootBundle.load('assets/car.riv');
  //   final bytes = await rootBundle.load('assets/bus_anime.riv');
  //   final file = RiveFile();
  //   if (file.import(bytes)) {
  //     // Extract the animation by its name
  //     final animation = file.mainArtboard.animationByName('car');
  //     if (animation != null) {
  //       // Create a RiveAnimationController
  //       _riveController = SimpleAnimation(animation: animation);
  //       setState(() {});
  //     }
  //   }
  // }

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
            totalDonation >= maxDonation ? 200 : (totalDonation / 3000000);
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
            if (totalDonation < maxDonation)
              Positioned(
                top: size.height * 0.25,
                left: size.width * 0.1,
                child: Lottie.asset("assets/lottie_bus.json",
                    controller: _busScaleAnimation, onLoaded: (composition) {}),
              )
            else
              Positioned(
                top: size.height * 0.25,
                left: size.width * 0.1,
                child: Lottie.asset(
                  "assets/lottie_bus.json",
                  controller: _busScaleAnimation,
                  onLoaded: (composition) {},
                ),
              ),
            Positioned.fill(
              child: CustomPaint(
                painter: MyPainter(
                  firstAnimation.value,
                  secondAnimation.value,
                  thirdAnimation.value,
                  fourthAnimation.value,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  donationAmount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    wordSpacing: 3,
                    color: Colors.white.withOpacity(.5),
                  ),
                  textScaleFactor: 9,
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Total Donation: NGN${totalDonation.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DonationButton(amount: 1000, onPressed: _donate),
                      const SizedBox(width: 10),
                      DonationButton(amount: 2000, onPressed: _donate),
                      const SizedBox(width: 10),
                      DonationButton(amount: 5000, onPressed: _donate),
                      const SizedBox(width: 10),
                      DonationButton(amount: 10000, onPressed: _donate),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DonationButton(amount: 20000, onPressed: _donate),
                      const SizedBox(width: 10),
                      DonationButton(amount: 50000, onPressed: _donate),
                      const SizedBox(width: 10),
                      DonationButton(amount: 100000, onPressed: _donate),
                      const SizedBox(width: 10),
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
      ..color = const Color.fromARGB(255, 70, 114, 190).withOpacity(.4)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
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
        backgroundColor: Color.alphaBlend(Colors.blueGrey, Colors.amberAccent),
      ),
      child: Text('NGN$amount'),
    );
  }
}

class LiquidDonationAnimation extends StatefulWidget {
  final double donationPercentage;

  LiquidDonationAnimation({required this.donationPercentage});

  @override
  _LiquidDonationAnimationState createState() =>
      _LiquidDonationAnimationState();
}

class _LiquidDonationAnimationState extends State<LiquidDonationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..value = widget.donationPercentage / 100;

    _waveAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant LiquidDonationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.value = widget.donationPercentage / 100;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: LiquidCircularProgressIndicator(
          value: _waveAnimation.value,
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          backgroundColor: Colors.white,
          borderColor: Colors.blue,
          borderWidth: 5.0,
          direction: Axis.vertical,
          center: Text(
            "${widget.donationPercentage.toStringAsFixed(0)}%",
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          ),
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
