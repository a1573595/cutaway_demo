import 'package:cutaway/database/preferences.dart';
import 'package:cutaway/model/Guide.dart';
import 'package:cutaway/router/route_utils.dart';
import 'package:cutaway/tool/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstGuidePage extends HookWidget {
  FirstGuidePage({super.key});

  final _guides = [
    Guide(Images.intro_step1, '線上訂購', '網站APP下單、菜單點餐方便快速。'),
    Guide(Images.intro_step2, '管家代管', '無合作幫你排、官方合作免排隊費。'),
    Guide(Images.intro_step3, '輕鬆享受', '外送早餐點心、內用拉麵火鍋都行。'),
  ];

  @override
  Widget build(BuildContext context) {
    final headerController = usePageController();
    final footerController = usePageController();

    final isLast = useState(false);

    final size = MediaQuery.sizeOf(context);

    headerController.addListener(() {
      final page = headerController.offset ~/ size.width;
      final pagePosition = page * size.width;

      final transformedValue = Curves.easeOutSine.transform((headerController.offset - pagePosition) / size.width);
      final offset = transformedValue * size.width;

      footerController.jumpTo(pagePosition + offset);
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: footerController,
              pageSnapping: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _guides.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.65,
                  ),
                  Text(
                    _guides[index].title,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(_guides[index].description),
                ],
              ),
            ),
            PageView.builder(
              controller: headerController,
              physics: const ClampingScrollPhysics(),
              itemCount: _guides.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: size.height / 6,
                  ),
                  Image.asset(
                    _guides[index].image,
                    height: size.width / 4 * 3,
                  ),
                ],
              ),
              onPageChanged: (position) {
                isLast.value = position == _guides.length - 1;
              },
            ),
            Visibility(
              visible: !isLast.value,
              child: Positioned(
                top: 0,
                right: 0,
                child: TextButton(
                  onPressed: () => goToHome(context),
                  child: Text(
                    '略過',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 42,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                  controller: headerController,
                  count: _guides.length,
                  effect: CustomizableEffect(
                    spacing: 12.sp,
                    dotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(64),
                      color: Colors.grey,
                      height: 8.sp,
                      width: 8.sp,
                    ),
                    activeDotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(64),
                      color: Colors.black,
                      height: 8.sp,
                      width: 24.sp,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Align(
                alignment: Alignment.bottomRight,
                child: AnimatedContainer(
                  height: 48,
                  width: isLast.value ? size.width - 32 : 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(milliseconds: 100),
                  child: InkWell(
                    onTap: () => _onNextClick(context, headerController),
                    child: SizedBox(
                      width: double.infinity,
                      child: isLast.value
                          ? Text(
                              '開始使用',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                            )
                          : const Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNextClick(BuildContext context, PageController controller) {
    var page = controller.page;
    if (page != null) {
      if (page + 1 < _guides.length) {
        controller.animateToPage(
          page.toInt() + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      } else {
        goToHome(context);
      }
    }
  }

  void goToHome(BuildContext context) =>
      Hive.box(tablePreferences).put(keyIsFirstEntry, true).whenComplete(() => context.goNamed(AppPage.home.name));
}
