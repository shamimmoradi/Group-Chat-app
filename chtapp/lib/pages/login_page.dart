// ignore_for_file: non_constant_identifier_names

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                top: MediaQuery.of(context).padding.top,
              ),
              child: Container(
                height: AppBar().preferredSize.height,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).disabledColor.withOpacity(0.1),
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                  ),
                ], color: Theme.of(context).scaffoldBackgroundColor),
                child: Center(
                  child: Text(
                    "Registration",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "we will send an otp to this number :))",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2),
                                    offset: const Offset(4, 4),
                                    blurRadius: 10)
                              ]),
                          child: CountryCodePicker(
                            favorite: const ['+98'],
                            closeIcon: Icon(
                              Icons.close,
                              color: Theme.of(context).primaryColor,
                            ),
                            initialSelection: "+98",
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            alignLeft: false,
                            // ignore: avoid_types_as_parameter_names
                            onChanged: (CountryCode) {
                              print(CountryCode.dialCode);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.2),
                                      offset: const Offset(4, 4),
                                      blurRadius: 10)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    cursorColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        errorMaxLines: 1,
                                        errorText: "no error",
                                        contentPadding:
                                            const EdgeInsets.symmetric(vertical: 5),
                                        hintText: "Put your Number",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).disabledColor.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 10
                          ),

                        ]

                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                            child: Text(
                              "Send The Code",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    )
                    ,)
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }
}



////// this code involves the array.back 
///                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8),
                    //   child: SizedBox(
                    //     width: AppBar().preferredSize.height - 8,
                    //     height: AppBar().preferredSize.height - 8,
                    //     child: Material(
                    //       color: Colors.transparent,
                    //       borderRadius: BorderRadius.circular(32),
                    //       child: InkWell(
                    //         onTap: () {
                    //           Get.back();
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8),
                    //           child: Icon(
                    //             Icons.arrow_back_rounded,
                    //             color: Theme.of(context).primaryColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),



//CountryListPick(
              //   theme: CountryTheme(
              //     isShowFlag: true,
              //     isDownIcon: true,
              //     isShowTitle: true,
              //     isShowCode: true,
              //     showEnglishName: true,
              //   ),
              //   initialSelection: "+98",
              //   onChanged: (value) {
              //     // ignore: avoid_print
              //     print(value?.name);
              //   },
              //   pickerBuilder: (context, countryCode) {
              //     if (countryCode != null) {
              //       countrycodeContrloller.text = countryCode.dialCode!;
              //       return Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             border:
              //                 Border.all(color: Colors.grey.withOpacity(0.7))),
              //         padding: const EdgeInsets.all(15),
              //         child: Row(
              //           children: [
              //             Image.asset(
              //               countryCode.flagUri!,
              //               package: "country_list_pick",
              //               width: 32,
              //             ),
              //             const SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               countryCode.name!,
              //               style: const TextStyle(
              //                 color: Colors.white,
              //               ),
              //             )
              //           ],
              //         ),
              //       );
              //     }
              //     return const SnackBar(
              //       clipBehavior: Clip.none,
              //       content: Text("choose a country "),
              //     );
              //   },
              //   useUiOverlay: true,
              //   useSafeArea: true,
              // ),