import 'dart:async';

import 'package:cutaway/router/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/StoreSummary.dart';
import '../../model/TopicSummary.dart';
import '../../tool/images.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('珍貴選品'),
        actions: [
          IconButton(
              onPressed: () {
                var router = GoRouter.of(context);
                router.go('${router.location}${AppPage.notification.fullPath}');
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
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                  )
                ],
              ))
        ],
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({Key? key}) : super(key: key);

  final TopicSummary ad = TopicSummary('', '', [
    StoreSummary(0, Images.ad1, '', ''),
    StoreSummary(1, Images.ad2, '', ''),
    StoreSummary(2, Images.ad3, '', ''),
    StoreSummary(3, Images.ad4, '', ''),
    StoreSummary(4, Images.ad5, '', ''),
    StoreSummary(5, Images.ad6, '', ''),
  ]);

  final TopicSummary feature = TopicSummary('優選店家', '優選店家', [
    StoreSummary(0, Images.jellycat, 'JELLYCAT', '來自英國倫敦最富創意的絨毛玩具'),
    StoreSummary(1, Images.jellycat, 'JELLYCAT', '來自英國倫敦最富創意的絨毛玩具'),
    StoreSummary(2, Images.jellycat, 'JELLYCAT', '來自英國倫敦最富創意的絨毛玩具'),
    StoreSummary(3, Images.jellycat, 'JELLYCAT', '來自英國倫敦最富創意的絨毛玩具'),
    StoreSummary(4, Images.jellycat, 'JELLYCAT', '來自英國倫敦最富創意的絨毛玩具'),
  ]);

  final List<TopicSummary> _topics = [
    TopicSummary('露營', 'Chill Chill 去露營', [
      StoreSummary(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
    ]),
    TopicSummary('台北城', '台北城新店散策', [
      StoreSummary(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
    ]),
    TopicSummary('米其林', '米其林必比登推介', [
      StoreSummary(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      StoreSummary(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _topics.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ADPageView(ad);
          } else if (index == 1) {
            return FeatureStore(feature);
          } else {
            return TopicStore(_topics[index - 2]);
          }
          ;
        });
  }
}

class ADPageView extends StatefulWidget {
  const ADPageView(this.ad, {Key? key}) : super(key: key);

  final TopicSummary ad;

  @override
  State<ADPageView> createState() => _ADPageViewState();
}

class _ADPageViewState extends State<ADPageView> {
  final PageController _controller = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      var currentPage = (_controller.page ?? 0).toInt();

      _controller.animateToPage(
        currentPage < widget.ad.storeSummarys.length - 1
            ? (currentPage + 1)
            : 0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = height > width ? width : height;

    return SizedBox(
      height: size * 0.35,
      child: Stack(
        children: [
          PageView.builder(
              controller: _controller,
              itemCount: widget.ad.storeSummarys.length,
              itemBuilder: (context, index) {
                return _buildAD(context, widget.ad.storeSummarys[index]);
              }),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                  controller: _controller, // PageController
                  count: widget.ad.storeSummarys.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 24,
                    activeDotColor: Colors.black,
                  ), // your preferred effect
                  onDotClicked: (index) {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAD(BuildContext context, StoreSummary summary) {
    return Center(
        child: Image(
      image: AssetImage(summary.imgUrl),
      fit: BoxFit.fill,
      height: double.infinity,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}

class FeatureStore extends StatelessWidget {
  const FeatureStore(this.feature, {Key? key}) : super(key: key);

  final TopicSummary feature;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = height > width ? width : height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            feature.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size * 0.4,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: feature.storeSummarys.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildStore(context, feature.storeSummarys[index])),
        ),
      ],
    );
  }

  Widget _buildStore(BuildContext context, StoreSummary store) {
    return SizedBox(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 8),
        child: Card(
          /**
           * clipBehavior讓圖片不會超出範圍
           */
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(store.imgUrl),
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white70),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.favorite_border)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      store.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      store.description,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopicStore extends StatelessWidget {
  const TopicStore(this.topics, {Key? key}) : super(key: key);

  final TopicSummary topics;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = height > width ? width : height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            topics.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size * 0.4,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: topics.storeSummarys.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildStore(context, topics.storeSummarys[index])),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
              onPressed: () => context,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(6)),
                  // shape: MaterialStateProperty.all<StadiumBorder>(
                  //     const StadiumBorder(side: BorderSide()))
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      side: const BorderSide(),
                      borderRadius: BorderRadius.circular(4)))),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    '更多店家',
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget _buildStore(BuildContext context, StoreSummary store) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image(
                      image: AssetImage(store.imgUrl),
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white70),
                      child: InkWell(
                          onTap: () {},
                          child: const Icon(Icons.favorite_border)),
                    ),
                  )
                ],
              ),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              store.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              store.description,
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
