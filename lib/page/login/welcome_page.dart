import 'package:cutaway/tool/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Images.background), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Spacer(),
            Image(
              image: const AssetImage(Images.launch_logo),
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
                  onPressed: () {
                    final router = GoRouter.of(context);
                    router.go('${router.location}/register');
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(16)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellowAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)))),
                  child: const Text(
                    '立即註冊',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  final router = GoRouter.of(context);
                  router.go('${router.location}/login');
                },
                child: const Text(
                  '已有會員？登入',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () => GoRouter.of(context).go('/home'),
                child: const Text('以訪客模式登入',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
