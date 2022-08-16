import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../database/preferences.dart';
import '../../widget/KeepAlivePage.dart';
import 'account/account_page.dart';
import 'favorites_page.dart';
import 'my_list/my_order_page.dart';
import 'bulletin_dialog.dart';
import 'search/search_page.dart';
import 'store/store_page.dart';

part 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    /**
     * 在build時不能處理其他變動
     * 使用addPostFrameCallback監聽build完成
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var box = Hive.box(tablePreferences);
      var isLogged = box.get(keyIsBulletinBeenShown) == true;

      if (!isLogged) {
        box.put(keyIsBulletinBeenShown, true);
        _showDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Body();
  }

  void _showDialog() {
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

class _Body extends StatelessWidget {
  _Body({Key? key}) : super(key: key);

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PageView(_controller),
      bottomNavigationBar: _BottomNavigationBar(_controller),
    );
  }
}

class _PageView extends ConsumerWidget {
  _PageView(this._controller, {Key? key}) : super(key: key);

  final PageController _controller;

  final List<Widget> _pages = [
    const KeepAlivePage(child: StorePage()),
    const KeepAlivePage(child: FavoritesPage()),
    KeepAlivePage(child: SearchPage()),
    const KeepAlivePage(child: MyOrderPage()),
    const KeepAlivePage(child: AccountPage()),
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
