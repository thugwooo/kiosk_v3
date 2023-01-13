import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v3/components/style.dart';
import 'package:kiosk_v3/controllers/display_controller.dart';
import 'package:kiosk_v3/controllers/screen_controller.dart';

import '../data/category.dart';
import '../data/screen.dart';

class BasicForm extends StatelessWidget {
  BasicForm({super.key});
  var display_controller = Get.put(DisplayController());
  var screen_controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: Stack(
        children: [
          Column(
            children: [
              _header(),
              Obx(
                () => Expanded(
                  child: screen_list[screen_controller.screen_index.value],
                ),
              ),
              _custom_bottom_navigation(),
            ],
          ),

          Positioned(
            left: 300.w,
            bottom: 63.h,
            child: Container(
              width: 165.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: mint_color,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Center(
                  child: Text(
                '우리 아이에게 딱 맞는 사료를 찾으려면',
                style: TextStyle(fontSize: 9.sp),
              )),
            ),
          ),
          Positioned(
            left: 318.w,
            bottom: 55.h,
            child: Image.asset(
              'assets/icons/triangle.png',
              width: 13.w,
              color: mint_color,
            ),
          )
          // TODO:
          // 어두운 배경
          // 상품 상세
          // 검색
          // 광고
        ],
      ),
    );
  }

  Widget _custom_bottom_navigation() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black))),
      child: Row(
        children: [
          _navi_button(index: 0),
          _navi_button(index: 1),
          _navi_button(index: 2),
          _navi_button(index: 3),
          Expanded(
            child: Container(
              height: 63.h,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    right: 20.w,
                    top: 14.h,
                    child: Container(
                      width: 135.w,
                      height: 26.h,
                      decoration: BoxDecoration(color: grey_color, borderRadius: BorderRadius.circular(10.w)),
                    ),
                  ),
                  Positioned(
                    right: 30.w,
                    top: 17.h,
                    child: Image.asset(
                      'assets/icons/magnifying-glass.png',
                      width: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navi_button({index}) {
    return Obx(
      () => InkWell(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: screen_controller.is_selected_screen(index) ? main_color : Colors.white,
              ),
              width: 96.w,
              height: 63.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    navi_icons[index],
                    width: 18.w,
                    color: screen_controller.is_selected_screen(index) ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    navi_Text[index],
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: screen_controller.is_selected_screen(index) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 30.w,
              child: Visibility(
                visible: screen_controller.is_selected_screen(index),
                child: Image.asset('assets/icons/triangle.png', width: 13.w),
              ),
            ),
          ],
        ),
        onTap: () {
          screen_controller.set_navi_index(index);
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Column(
            children: [
              //강아지 고양이 버튼
              SizedBox(height: 20.h),
              Image.asset(
                'assets/icons/vertical_logo.png',
                width: 126.w,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  _pet_button(index: 0),
                  _pet_button(index: 1),
                ],
              ),
            ],
          ),
          SizedBox(width: 15.w),
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: Container(
              decoration: test_line,
              width: 420.w,
              height: 83.h,
              child: Center(child: Text('광고')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pet_button({index}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: 62.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: display_controller.is_selected_pet_type(index) ? main_color : grey_color,
            borderRadius:
                index == 0 ? BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)) : BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              '${pet_text[index]}',
              style: TextStyle(fontSize: 11.sp, color: display_controller.is_selected_pet_type(index) ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () {
          display_controller.set_pet_type(index);
        },
      ),
    );
  }
}