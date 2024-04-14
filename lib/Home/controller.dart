import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class controller extends GetxController {
  TextEditingController colmn = TextEditingController();
  TextEditingController searchKeey = TextEditingController();
  TextEditingController row = TextEditingController();
  TextEditingController alph = TextEditingController();
  Rx<RxStatus> isGeneratingGrrid = RxStatus.loading().obs;

  int columns = 0;
  int rows = 0;

  RxString alphabts = "".obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    // Delay execution by one frame using SchedulerBinding to ensure context is available.

    super.onInit();
  }

  List<dynamic> gridList = [];
  List<List<int>> abcd = [];

  void st() {
    print("cll");

    isGeneratingGrrid.value = RxStatus.loading();
    gridList = [];
    int s = 0;
    for (int i = 0; i < columns; i++) {
      List<String> sublist = [];
      for (int j = 0; j < rows; j++) {
        sublist.add(alphabts.value[s]);
        s++;
      }
      gridList.add(sublist);
    }
    isGeneratingGrrid.value = RxStatus.success();
  }

  findVertical(String word) {
    searchText.value = word;

    for (int i = 0; i <= columns - word.length; i++) {
      for (int j = 0; j < rows; j++) {
        String verticalString = '';
        for (int k = 0; k < word.length; k++) {
          verticalString += gridList[i + k][j];
          print(verticalString);
        }
        if (verticalString == word) {
          // Handle word found vertically
          print('Word found vertically at position: ($i, $j)');
          highlightWord(i, j, word.length, false);
        }
      }
    }
  }

  findHorizonntal(String word) {
    searchText.value = word;

    for (int i = 0; i < columns; i++) {
      for (int j = 0; j <= rows - word.length; j++) {
        String horizontalString =
            gridList[i].sublist(j, j + word.length).join('');

        if (horizontalString == word) {
          // Handle word found horizontally
          print('Word found horizontally at position: ($i, $j)');

          highlightWord(i, j, word.length, true);
        }
      }
    }
  }

  RxBool checkidx(int ii, int jj) {
    RxBool isidx = false.obs;
    for (int i = 0; i < abcd.length; i++) {
      if (ii == abcd[i][0] && jj == abcd[i][1]) {
        isidx = true.obs;
        break;
      } else {
        isidx = false.obs;
      }
    }
    isidx.refresh();
    return isidx;
  }

  void findDiagonal(String word) {
    // Search from top-left to bottom-right
    for (int i = 0; i <= columns - word.length; i++) {
      for (int j = 0; j <= rows - word.length; j++) {
        String diagonalString = '';
        for (int k = 0; k < word.length; k++) {
          diagonalString += gridList[i + k][j + k];
          print(diagonalString);
        }
        if (diagonalString == word) {
          highlightWordd(i, j, word.length);
          // return; // Exit the function once the word is found
        }
      }
    }

    // Search from top-right to bottom-left
  }

  //bool aaa = abcd.contains([1,1]);

  void highlightWord(int startX, int startY, int length, bool horizontal) {
    for (int i = 0; i < length; i++) {
      try {
        if (horizontal) {
          abcd.add([startX, startY + i]);
        } else {
          abcd.add([startX + i, startY]);
        }
      } catch (E) {
        print(E);
      }
    }
    print(abcd);
  }

  void highlightWordd(int startX, int startY, int length) {
    for (int i = 0; i < length; i++) {
      try {
        abcd.add([startX + i, startY + i]);
      } catch (E) {
        print(E);
      }
    }
    print(abcd);
  }
}
