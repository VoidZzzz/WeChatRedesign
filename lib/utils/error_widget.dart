import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat/utils/super_scaffold.dart';

import '../view/widgets/common_widgets/text_view.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key, required this.errorDetails, required this.oneTwoThree}) : super(key: key);

  final FlutterErrorDetails errorDetails;
  final int oneTwoThree;

  @override
  Widget build(BuildContext context) {
    return FlutterSuperScaffold(isTopSafe: false, isBotSafe: false,
      body: SizedBox(width: Get.width, height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: (oneTwoThree == 1)?Image.asset(
                "assets/images/crying_memes.gif",
                fit: BoxFit.cover,
              ) : (oneTwoThree == 2)?Image.asset(
                "assets/images/crying_girl.gif",
                fit: BoxFit.cover,
              ) : Image.asset(
                "assets/images/dangin_girl.gif",
                fit: BoxFit.cover,
              ),
            ),
            Align(alignment: Alignment.center,
              child: TextView(
                text: errorDetails.exceptionAsString(),
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}