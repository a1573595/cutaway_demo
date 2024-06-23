import 'package:cutaway/database/preferences.dart';
import 'package:cutaway/page/home/account/account_page.dart';
import 'package:cutaway/page/home/bulletin_dialog.dart';
import 'package:cutaway/page/home/favorites_page.dart';
import 'package:cutaway/page/home/my_list/my_order_page.dart';
import 'package:cutaway/page/home/search/search_page.dart';
import 'package:cutaway/page/home/store/store_page.dart';
import 'package:cutaway/widget/keep_alive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'home_view_model.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController(initialPage: ref.read(_pagePosition.notifier).state);

    final pages = useMemoized(() => const [
          KeepAliveWidget(
            child: StorePage(),
          ),
          KeepAliveWidget(
            child: FavoritesPage(),
          ),
          KeepAliveWidget(
            child: SearchPage(),
          ),
          KeepAliveWidget(
            child: MyOrderPage(),
          ),
          KeepAliveWidget(
            child: AccountPage(),
          ),
        ]);

    ref.listen(_pagePosition, (previous, next) {
      controller.jumpToPage(next);
    });

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final box = Hive.box(tablePreferences);
        final isLogged = box.get(keyIsBulletinBeenShown) == true;

        if (!isLogged) {
          box.put(keyIsBulletinBeenShown, true);
          showBulletinDialog(context);
        }
      });

      return;
    }, const []);

    return Scaffold(
      body: PageView.builder(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[index],
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends HookConsumerWidget {
  const _BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = useMemoized(() => [
          const BottomNavigationBarItem(
            label: '珍貴選品',
            icon: Icon(Icons.storefront),
          ),
          const BottomNavigationBarItem(
            label: '我的選品',
            icon: Icon(Icons.favorite),
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
        ]);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14.sp,
      unselectedFontSize: 12.sp,
      currentIndex: ref.watch(_pagePosition),
      onTap: (index) => ref.read(_pagePosition.notifier).state = index,
      items: items,
    );
  }
}
