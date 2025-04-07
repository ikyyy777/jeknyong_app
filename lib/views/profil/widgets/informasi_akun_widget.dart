import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class InformasiAkunWidget extends StatelessWidget {
  const InformasiAkunWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Akun',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(16)),
        _buildMenuItem(
          context: context,
          iconPath: 'assets/icons/profile.svg',
          title: 'Profil Saya',
          onTap: () {
            // TODO: Navigate to Profil Saya
          },
        ),
        Divider(color: ColorConstant.greyColor),
        _buildMenuItem(
          context: context,
          iconPath: 'assets/icons/lock.svg',
          title: 'Ubah Password',
          onTap: () {
            // TODO: Navigate to Ubah Password
          },
        ),
        Divider(color: ColorConstant.greyColor),
        SizedBox(height: scaleHelper.scaleHeight(24)),
        Text(
          'Informasi Lainnya',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(16)),
        _buildMenuItem(
          context: context,
          iconPath: 'assets/icons/call.svg',
          title: 'Hubungi Kami',
          onTap: () {
            // TODO: Navigate to Hubungi Kami
          },
        ),
        Divider(color: ColorConstant.greyColor),
        _buildMenuItem(
          context: context,
          iconPath: 'assets/icons/faq.svg',
          title: 'Pertanyaan Umum',
          onTap: () {
            // TODO: Navigate to Pertanyaan Umum
          },
        ),
        Divider(color: ColorConstant.greyColor),
        _buildMenuItem(
          context: context,
          iconPath: 'assets/icons/logout.svg',
          title: 'Keluar',
          textColor: ColorConstant.redColor,
          onTap: () {
            // TODO: Handle Logout
          },
        ),
        Divider(color: ColorConstant.greyColor),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String iconPath,
    required String title,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: scaleHelper.scaleHeight(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: scaleHelper.scaleWidth(24),
              height: scaleHelper.scaleWidth(24),
              colorFilter: ColorFilter.mode(
                textColor ?? ColorConstant.darkColor1,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: scaleHelper.scaleWidth(12)),
            Expanded(
              child: Text(
                title,
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: textColor ?? ColorConstant.darkColor1,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: scaleHelper.scaleWidth(24),
              color: ColorConstant.darkColor3,
            ),
          ],
        ),
      ),
    );
  }
}
