import 'package:cutaway/router/route_utils.dart';
import 'package:cutaway/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageUtil.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Spacer(),
            Image(
              image: const AssetImage(ImageUtil.launchLogo),
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Text(
              'Cutaway',
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => context.pushNamed(AppPage.register.name),
                style: ButtonStyle(
                    padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: WidgetStateProperty.all(Colors.yellowAccent),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                child: const Text(
                  '立即註冊',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () => context.pushNamed(AppPage.login.name),
              child: const Text(
                '已有會員？登入',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () => context.go('/home'),
              child: const Text(
                '以訪客模式登入',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
