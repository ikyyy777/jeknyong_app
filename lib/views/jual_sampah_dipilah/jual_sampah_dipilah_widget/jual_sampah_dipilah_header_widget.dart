import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:provider/provider.dart';

class JualSampahDipilahHeaderWidget extends StatefulWidget {
  const JualSampahDipilahHeaderWidget({super.key});

  @override
  State<JualSampahDipilahHeaderWidget> createState() =>
      _JualSampahDipilahHeaderWidgetState();
}

class _JualSampahDipilahHeaderWidgetState
    extends State<JualSampahDipilahHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Column(
      children: [
        CustomAppbarGlobalWidget(title: "Jual Sampah Dipilah"),
        SizedBox(height: scaleHelper.scaleHeight(16)),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorConstant.borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: ColorConstant.darkColor3,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Cari jenis sampah...",
                              hintStyle: TextStyle(
                                color: ColorConstant.darkColor3,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.cancel_outlined,
                          color: ColorConstant.darkColor3,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorConstant.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: SvgPicture.asset('assets/icons/filter.svg'),
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
