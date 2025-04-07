import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/views/home/home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/views/jual_sampah/jual_sampah_view.dart';
import 'package:jeknyong_app/views/oleh_oleh/oleh_oleh_view.dart';
import 'package:jeknyong_app/views/profil/profil_view.dart';
import 'package:jeknyong_app/views/riwayat_transaksi/riwayat_transaksi_view.dart';

class NavigationBarView extends StatefulWidget {
  final int? initialIndex;
  const NavigationBarView({
    super.key,
    this.initialIndex,
  });

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 65,
            width: 65,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstant.whiteColor,
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentPageIndex = 2;
                });
              },
              backgroundColor: ColorConstant.primaryColor,
              elevation: 0,
              shape: const CircleBorder(),
              child: SvgPicture.asset(
                'assets/icons/sampah_navbar.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Jual Sampah',
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: 12,
              color: currentPageIndex == 2 ? ColorConstant.primaryColor : ColorConstant.darkColor3,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBar(
        pageIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
              const HomeView(),
              const OlehOlehView(),
              const JualSampahView(),
              const RiwayatTransaksiView(),
              const ProfilView()
            ][currentPageIndex],
    );
  }
}

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: Platform.isAndroid ? 0 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 30,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomAppBar(
        elevation: 8.0,
        color: Colors.white,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navItem(
              'assets/icons/home.svg',
              pageIndex == 0,
              'Beranda',
              onTap: () => onTap(0),
            ),
            navItem(
              'assets/icons/oleh_oleh2.svg',
              pageIndex == 1,
              'Oleh-Oleh',
              onTap: () => onTap(1),
            ),
            const SizedBox(width: 80),
            navItem(
              'assets/icons/riwayat.svg',
              pageIndex == 3,
              'Riwayat',
              onTap: () => onTap(3),
            ),
            navItem(
              'assets/icons/profile.svg',
              pageIndex == 4,
              'Profil',
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(dynamic icon, bool selected, String label, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon is String 
              ? SvgPicture.asset(
                  icon,
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    selected ? ColorConstant.primaryColor : ColorConstant.darkColor3,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(
                  icon,
                  size: 28,
                  color: selected ? ColorConstant.primaryColor : ColorConstant.darkColor3,
                ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: 12,
                color: selected ? ColorConstant.primaryColor : ColorConstant.darkColor3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}