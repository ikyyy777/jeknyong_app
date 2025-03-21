import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/views/home/home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key});

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  int currentPageIndex = 0;
  bool showJualSampahPage = false;

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
                  showJualSampahPage = true;
                  currentPageIndex = -1;
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
              color: showJualSampahPage ? ColorConstant.primaryColor : ColorConstant.navbarUnselectedColor,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBar(
        pageIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            showJualSampahPage = false;
            currentPageIndex = index;
          });
        },
      ),
      body: showJualSampahPage
          ? Container(
              color: Colors.orange,
              alignment: Alignment.center,
              child: const Text('Halaman Jual Sampah'),
            )
          : <Widget>[
              const HomeView(),
              Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text('Page 2'),
              ),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Page 3'),
              ),
              Container(
                color: Colors.yellow,
                alignment: Alignment.center,
                child: const Text('Page 4'),
              ),
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
              pageIndex == 2,
              'Riwayat',
              onTap: () => onTap(2),
            ),
            navItem(
              'assets/icons/profile.svg',
              pageIndex == 3,
              'Profil',
              onTap: () => onTap(3),
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
                    selected ? ColorConstant.primaryColor : ColorConstant.navbarUnselectedColor,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(
                  icon,
                  size: 28,
                  color: selected ? ColorConstant.primaryColor : ColorConstant.navbarUnselectedColor,
                ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: 12,
                color: selected ? ColorConstant.primaryColor : ColorConstant.navbarUnselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}