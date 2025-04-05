import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/text_form_field_global_widget.dart';
import 'package:provider/provider.dart';

class DaftarUsernameFormWidget extends StatefulWidget {
  const DaftarUsernameFormWidget({super.key});

  @override
  State<DaftarUsernameFormWidget> createState() =>
      _DaftarUsernameFormWidgetState();
}

class _DaftarUsernameFormWidgetState extends State<DaftarUsernameFormWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyleConstant.textStyleRegular.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.blackColor,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(4)),
        TextFormFieldGlobalWidget(controller: _controller, hintText: 'Masukkan Username'),
      ],
    );
  }
}
