import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_en/page/home_page.dart';
import 'package:flutter_en/values/app_assets.dart';
import 'package:flutter_en/values/app_color.dart';
import 'package:flutter_en/values/app_style.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16), //set padding chiều ngang 16
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Text('Welcome to', style: AppStyles.h3),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, //đẩy container to ra
                  children: [
                    Text(
                      'English',
                      style: AppStyles.h2.copyWith(
                          color: AppColor.blackGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Quotes"',
                        style: AppStyles.h4.copyWith(height: 0.5),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                // color: Colors.yellow,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false);
                    },
                    shape: CircleBorder(),
                    fillColor: AppColor.lighBlue,
                    child: Image.asset(AppAssets.rightArrow)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
