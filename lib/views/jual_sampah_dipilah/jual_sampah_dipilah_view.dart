import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/views/jual_sampah_dipilah/jual_sampah_dipilah_widget/jual_sampah_dipilah_grid_content_widget.dart';
import 'package:jeknyong_app/views/jual_sampah_dipilah/jual_sampah_dipilah_widget/jual_sampah_dipilah_header_widget.dart';

class JualSampahDipilahView extends StatefulWidget {
  const JualSampahDipilahView({super.key});

  @override
  State<JualSampahDipilahView> createState() => _JualSampahDipilahViewState();
}

class _JualSampahDipilahViewState extends State<JualSampahDipilahView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JualSampahDipilahHeaderWidget(),
            JualSampahDipilahGridContentWidget(),
          ],
        ),
      ),
    );
  }
}
