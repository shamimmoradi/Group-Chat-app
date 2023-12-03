import 'dart:io';

import 'package:chatapplication/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../controllers/login_controller.dart';

class UserInfoScreen extends GetView<LoginController> {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
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
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: Container(
                        height: AppBar().preferredSize.height,
                        // width: AppBar().preferredSize.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.1),
                                  offset: const Offset(4, 4),
                                  blurRadius: 10)
                            ]),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SizedBox(
                              height: AppBar().preferredSize.height - 8,
                              width: AppBar().preferredSize.height - 8,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(32),
                                  onTap: () {
                                    Get.back();
                                  },
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
                              "User Information",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TextButton(
                                onPressed: () {
                                  Get.to(HomePage());
                                },
                                child: Text(
                                  "Skip",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                )),
                          )
                        ]),
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .disabledColor
                                                    .withOpacity(0.1),
                                                blurRadius: 8,
                                                offset: const Offset(4, 4))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child:
                                              controller.selectedImage.value ==
                                                      ""
                                                  ? Image.asset(
                                                      "assets/avatar.jpg",
                                                    )
                                                  : Image.file(
                                                      File(controller
                                                          .selectedImage.value),
                                                    ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .disabledColor
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: const Offset(4, 4))
                                            ]),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            onTap: () {
                                              controller.showPicker(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(4, 4))
                                    ],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                          child: TextField(
                                        controller:
                                            controller.userNameController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            errorText: controller
                                                    .userNameError.value.isEmpty
                                                ? null
                                                : controller
                                                    .userNameError.value,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                            border: InputBorder.none,
                                            hintText: "Username"),
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 24),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4))
                                ],
                                color: Theme.of(context).primaryColor),
                            child: Material(
                              color: Theme.of(context).primaryColor,
                              child: InkWell(
                                onTap: () {
                                        controller.uploadUserData();                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
