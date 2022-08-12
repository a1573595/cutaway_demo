import 'package:cutaway/tool/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'account_page.dart';
import 'favorites_page.dart';
import 'my_list/my_order_page.dart';
import 'bulletin_dialog.dart';
import 'search/search_page.dart';
import 'store_page.dart';

part 'home_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    /**
     * 在build時不能處理其他變動
     * 使用addPostFrameCallback監聽build完成
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!sharedPrefs.getIsBulletinBeenShown()) {
        sharedPrefs.setIsBulletinBeenShown(true);

        _showDialog(context);
      }
    });

    return Scaffold(
      body: _PageView(_controller),
      bottomNavigationBar: _BottomNavigationBar(_controller),
    );
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          /**
           * 要用Align或Center等Widget包裹才能限制大小
           */
          return const Center(child: BulletinDialog());
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(animation),
            child: child,
          );
        });
  }
}

class _PageView extends ConsumerWidget {
  _PageView(this._controller, {Key? key}) : super(key: key);

  final PageController _controller;

  final List<Widget> _pages = [
    const StorePage(),
    const FavoritesPage(),
    SearchPage(),
    const MyOrderPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (value) {
          ref.read(_pagePosition.state).state = value;
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _pages[index];
        });
  }
}

class _BottomNavigationBar extends ConsumerWidget {
  const _BottomNavigationBar(this._controller, {Key? key}) : super(key: key);

  final PageController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(.3),
      selectedFontSize: 14.sp,
      unselectedFontSize: 12.sp,
      onTap: (value) {
        _controller.jumpToPage(value);
      },
      currentIndex: ref.watch(_pagePosition.state).state,
      items: [
        const BottomNavigationBarItem(
          label: '珍貴選品',
          icon: Icon(Icons.storefront),
        ),
        BottomNavigationBarItem(
          label: '我的選品',
          icon: Consumer(
            builder: (context, ref, child) {
              return Icon(Icons.favorite,
                  color: ref.watch(_pagePosition.state).state == 1
                      ? Colors.redAccent
                      : Colors.grey);
            },
          ),
        ),
        const BottomNavigationBarItem(
          label: '搜尋',
          icon: Icon(Icons.search),
        ),
        const BottomNavigationBarItem(
          label: '我的訂單',
          icon: Icon(Icons.list),
        ),
        const BottomNavigationBarItem(
          label: '個人帳戶',
          icon: Icon(Icons.account_circle),
        ),
      ],
    );
  }
}
