import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class HomeMenuLainWidget extends StatefulWidget {
  const HomeMenuLainWidget({super.key});

  @override
  State<HomeMenuLainWidget> createState() => _HomeMenuLainWidgetState();
}

class _HomeMenuLainWidgetState extends State<HomeMenuLainWidget> {
  Widget _buildMenuIcon(String iconName, double width, double height, String menuName) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: ColorConstant.greyColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset('assets/icons/$iconName.png'),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        SizedBox(
          width: width + 1,
          child: Text(
            menuName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConstant.textStyleReguler.copyWith(
              fontSize: scaleHelper.scaleText(14),
              color: ColorConstant.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Transform.translate(
      offset: Offset(0, scaleHelper.scaleHeight(-95)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Lain',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
                color: ColorConstant.blackColor,
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement the logic for the oleh_oleh menu
                    },
                    child: _buildMenuIcon(
                      'oleh_oleh',
                      scaleHelper.scaleWidth(76),
                      scaleHelper.scaleHeight(76),
                      'Oleh-Olehe Nyong',
                    ),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement the logic for the pangan menu
                    },
                    child: _buildMenuIcon(
                      'pangan',
                      scaleHelper.scaleWidth(76),
                      scaleHelper.scaleHeight(76),
                      'Pangane Nyong',
                    ),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement the logic for the wisatane menu
                    },
                    child: _buildMenuIcon(
                      'wisatane',
                      scaleHelper.scaleWidth(76),
                      scaleHelper.scaleHeight(76),
                      'Wisatane Nyong',
                    ),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement the logic for the ojeke menu
                    },
                    child: _buildMenuIcon(
                      'ojeke',
                      scaleHelper.scaleWidth(76),
                      scaleHelper.scaleHeight(76),
                      'Ojeke Nyong'
                    ),
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
