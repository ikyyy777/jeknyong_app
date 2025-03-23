import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class OlehOlehSearchBarWidget extends StatefulWidget {
  const OlehOlehSearchBarWidget({super.key});

  @override
  State<OlehOlehSearchBarWidget> createState() =>
      _OlehOlehSearchBarWidgetState();
}

class _OlehOlehSearchBarWidgetState extends State<OlehOlehSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      children: [
        SizedBox(
          height: scaleHelper.scaleHeight(48),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Produk, Toko disini',
                    hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                      fontSize: scaleHelper.scaleText(14),
                      color: ColorConstant.darkColor3,
                    ),
                    prefixIcon: Container(
                      padding: EdgeInsets.only(
                        left: scaleHelper.scaleWidth(15),
                        right: scaleHelper.scaleWidth(15),
                      ),
                      child: SvgPicture.asset('assets/icons/search.svg'),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        scaleHelper.scaleWidth(10),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorConstant.borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        scaleHelper.scaleWidth(10),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorConstant.borderColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        scaleHelper.scaleWidth(10),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorConstant.borderColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: scaleHelper.scaleWidth(8)),
              Container(
                width: scaleHelper.scaleWidth(48),
                height: scaleHelper.scaleHeight(48),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    scaleHelper.scaleWidth(10),
                  ),
                  border: Border.all(
                    width: 1,
                    color: ColorConstant.borderColor,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: ColorConstant.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
