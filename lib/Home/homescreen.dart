import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:deemo/Home/controller.dart';
import 'package:deemo/approutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  controller ctrlr = controller();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getColums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 229, 228, 228),
        title: Text("Find the word"),
        actions: [
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.Homescreen);
              },
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.restore_rounded),
                  Text(
                    "Reset",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .01),
                  )
                ],
              )),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Obx(
        () => ctrlr.isGeneratingGrrid.value.isSuccess
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter word here !",
                              border: InputBorder.none,
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            controller: ctrlr.searchKeey,
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              ctrlr.abcd = [];
                              ctrlr.findHorizonntal(ctrlr.searchKeey.text
                                  .toLowerCase()
                                  .toString());
                              ctrlr.findVertical(ctrlr.searchKeey.text
                                  .toLowerCase()
                                  .toString());
                              setState(() {});
                              ctrlr.findDiagonal(ctrlr.searchKeey.text
                                  .toLowerCase()
                                  .toString());
                              setState(() {});
                              if (ctrlr.abcd.isEmpty) {
                                AwesomeDialog(
                                        context: context,
                                        body: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .02),
                                          child: Text(
                                            "Word Not Found !",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        dialogType: DialogType.error)
                                    .show();
                              }
                            },
                            icon: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * .02),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Find",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            for (int i = 0; i < ctrlr.columns; i++)
                              Expanded(
                                child: Row(
                                  children: [
                                    for (int j = 0; j < ctrlr.rows; j++)
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: ctrlr.checkidx(i, j).value
                                                  ? Colors.green
                                                  : const Color.fromARGB(
                                                      255, 234, 234, 234),
                                              // color: const Color.fromARGB(
                                              //     255, 236, 236, 236),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: Offset(0, 15),
                                                    blurRadius: 3,
                                                    spreadRadius: -4)
                                              ],
                                            ),
                                            child: Center(
                                                child: Text(
                                              ctrlr.gridList[i][j],
                                              style: TextStyle(
                                                  color:
                                                      ctrlr.checkidx(i, j).value
                                                          ? Colors.white
                                                          : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .03),
                                            )),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              )
                          ],
                        )),
                  ],
                ),
              )
            : Center(
                child: Text("Loading"),
              ),
      ),
    );
  }

  void getColums() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        body: Column(
          children: [
            Text("Enter number of columns"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Allow only numeric characters
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                controller: ctrlr.colmn,
              ),
            ),
          ],
        ),
        btnOkOnPress: () {
          ctrlr.columns = int.parse(ctrlr.colmn.text.toString());
          getRows();
        },
      ).show();
    });
  }

  void getRows() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        body: Column(
          children: [
            Text("Enter number of rows"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Allow only numeric characters
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                controller: ctrlr.row,
              ),
            ),
          ],
        ),
        btnOkOnPress: () {
          ctrlr.rows = int.parse(ctrlr.row.text.toString());

          getAlphabts();
        },
      ).show();
    });
  }

  void getAlphabts() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        body: Column(
          children: [
            Text("Enter ${(ctrlr.columns * ctrlr.rows).toString()} alphabets"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z]')), // Allow only alphabetic characters
                  ],
                  maxLines: 8, //or null

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) {
                    if ((value?.length ?? 0) != ctrlr.rows * ctrlr.columns) {
                      return 'you need to enter ${(ctrlr.rows * ctrlr.columns).toString()}alphabets but\nyou enter ${(value?.length ?? 0).toString()}';
                    }
                    return null;
                  },
                  controller: ctrlr.alph,
                ),
              ),
            ),
            TextButton(
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              onPressed: () {
                ctrlr.alphabts.value = ctrlr.alph.text.toString();
                if (_formKey.currentState!.validate()) {
                  Get.back();

                  ctrlr.st();
                } else {}
              },
            ),
          ],
        ),

        // btnOkOnPress: () {
        //   ctrlr.alphabts.value = ctrlr.alph.text.toString();
        //   if (_formKey.currentState!.validate()) {
        //     ctrlr.st();
        //   } else {}
        // },
      ).show();
      // Show alert dialog here
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Enter alphabets"),
      // content: Form(
      //   key: _formKey,
      //   child: TextFormField(
      //     validator: (value) {
      //       if ((value?.length ?? 0) != ctrlr.rows * ctrlr.columns) {
      //         return 'you need to enter ${(ctrlr.rows * ctrlr.columns).toString()}alphabets but\nyou enter ${(value?.length ?? 0).toString()}';
      //       }
      //       return null;
      //     },
      //     controller: ctrlr.alph,
      //   ),
      // ),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text("Done"),
      //           onPressed: () {
      // ctrlr.alphabts.value = ctrlr.alph.text.toString();
      // if (_formKey.currentState!.validate()) {
      //   Navigator.of(context).pop();

      //   ctrlr.st();
      // } else {}
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    });
  }
}
