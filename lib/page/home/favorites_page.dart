import 'package:cutaway/router/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的選品'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppPage.notification.name);
            },
            icon: Stack(
              children: [
                Icon(Icons.notifications, color: Colors.yellow[100]),
                const Icon(Icons.notifications_none),
                Positioned(
                  top: 4,
                  right: 2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          '登入會員啟用此功能',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
