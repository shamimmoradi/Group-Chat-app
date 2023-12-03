import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../controllers/login_controller.dart';

class VerificationPage extends GetView<LoginController> {
    final String verificationId;
  const VerificationPage({super.key , required this.verificationId});

  @override
  Widget build(BuildContext context) {
    ///Sometimes, in an app, you want to perform an asynchronous operation and
    ///want to prevent the user from tapping/using the app while this operation is in progress.
    return Obx(() => LoaderOverlay(
        useDefaultLoading: controller.isLoading.value,
        overlayWidgetBuilder: (_) {
          //ignored progress for the moment
          return Center(
            child: SpinKitCubeGrid(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          );
        },
        child: Scaffold(
          body: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
                    height: AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(4, 4))
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: AppBar().preferredSize.height - 8,
                            height: AppBar().preferredSize.height - 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                borderRadius: BorderRadius.circular(32),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "OTP Verification",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Image.asset("assets/people.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Enter OTP that we already sent to you",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 40),
                          child: PinInputTextField(
                            pinLength: 6,
                            controller: controller.otpController,
                            decoration: CirclePinDecoration(
                              errorText: controller.pinError.value.isEmpty?null: controller.pinError.value,
                                strokeColorBuilder: FixedColorBuilder(
                                    Theme.of(context).primaryColor),
                                hintText: "345678",
                                // errorText: "Error",
                                strokeWidth: 2,
                                hintTextStyle:
                                    Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 40),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(4, 4),
                                      blurRadius: 10,
                                      color: Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.1))
                                ],
                                color: Theme.of(context).primaryColor),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.verifyOTP();
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Center(
                                  child: Text("Verify  OTP"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
