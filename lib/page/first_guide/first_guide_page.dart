import 'package:cutaway/model/Guide.dart';
import 'package:cutaway/router/route_utils.dart';
import 'package:cutaway/tool/images.dart';
import 'package:cutaway/tool/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'first_guide_view_model.dart';

class FirstGuidePage extends ConsumerWidget {
  FirstGuidePage({Key? key}) : super(key: key);

  final PageController _controller = PageController();

  final _guides = [
    Guide(Images.intro_step1, '線上訂購', '網站APP下單、菜單點餐方便快速。'),
    Guide(Images.intro_step2, '管家代管', '無合作幫你排、官方合作免排隊費。'),
    Guide(Images.intro_step3, '輕鬆享受', '外送早餐點心、內用拉麵火鍋都行。'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: _controller,
              onPageChanged: (value) {
                ref.read(_pagePosition.state).state = value;
              },
              itemCount: _guides.length,
              itemBuilder: (context, index) {
                /**
                 * 沒有用Center包裹則Image的height、width無效
                 */
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(_guides[index].image,
                          height: MediaQuery.of(context).size.width / 4 * 3),
                      SizedBox(
                        height: 64.sp,
                      ),
                      Text(
                        _guides[index].title,
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(_guides[index].description)
                    ],
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.all(64.sp),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                  controller: _controller, // PageController
                  count: _guides.length,
                  effect: WormEffect(
                    dotHeight: 8.sp,
                    dotWidth: 8.sp,
                    spacing: 24.sp,
                    activeDotColor: Colors.black,
                  ), // your preferred effect
                  onDotClicked: (index) {}),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(36.sp),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => _onNextClick(context),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(18.sp),
                  primary: Colors.black, // <-- Button color
                  // onPrimary: Colors.red, // <-- Splash color
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 32,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onNextClick(BuildContext context) {
    var page = _controller.page;
    if (page != null) {
      if (page + 1 < _guides.length) {
        _controller.animateToPage(page.toInt() + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate);
      } else {
        sharedPrefs
            .setIsFirstEntry(true)
            .whenComplete(() => GoRouter.of(context).go(AppPage.home.fullPath));
      }
    }
  }
}
