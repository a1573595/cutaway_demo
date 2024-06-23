import 'package:cutaway/router/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  child: Text(
                    '訪',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                const Text(
                  '訪客',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Card(
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppPage.notification.name);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Column(
                        children: [
                          Stack(
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
                          const Text('通知中心')
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () => context.push(AppPage.welcome.fullPath),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Column(
                          children: [
                            Icon(Icons.account_circle_outlined),
                            Text('會員資料'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () => context.push(AppPage.welcome.fullPath),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.login),
                            Text('註冊/登入'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            _CardButton('優惠券', false, () {}),
            _CardButton('我的分享碼', true, () {}),
            _CardButton('聯絡我們', false, () {}),
            _CardButton('服務內容', false, () {}),
            const Spacer(),
            const Center(
              child: Text(
                '目前版本',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Center(
              child: Text(
                'Release 2.9.10 build 75',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton(this.title, this.isNew, this.callback, {Key? key}) : super(key: key);

  final String title;
  final bool isNew;
  final GestureTapCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: callback,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Text(title),
                isNew
                    ? Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: const BoxDecoration(
                            color: Colors.yellowAccent, borderRadius: BorderRadius.all(Radius.circular(24))),
                        child: Text(
                          'New',
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox(),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
