import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:we_chat/utils/sizebox_extensions.dart';
import 'package:we_chat/view/widgets/common_widgets/custom_elevated_btn.dart';
import 'package:we_chat/view/widgets/common_widgets/text_view.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool xAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      setState(() {
        xAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSuperScaffold(
      isTopSafe: false,
      isBotSafe: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            300.heightBox(),
            Center(
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: xAnimate,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: "Text your friends and share moments"),
                  10.heightBox(),
                  TextView(
                      text:
                          "End to end secured messaging app with Social Elements"),
                  10.heightBox(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Sign Up",
                          onTap: () {},
                          textColor: Colors.blueGrey,
                          borderColor: Colors.blueGrey,
                          color: Colors.white,
                        ),
                      ),
                      15.widthBox(),
                      Expanded(
                        child: CustomElevatedButton(
                            text: "Login",
                            color: Colors.blueGrey,
                            onTap: () {}),
                      ),
                    ],
                  ),
                ],
              ).animate().slideX(duration: Duration(seconds: 2), begin: 3).shimmer(duration: Duration(seconds: 4),),
            ),
            50.heightBox()
          ],
        ),
      ),
    );
  }
}
