import 'package:cutaway/model/StoreSummary.dart';
import 'package:cutaway/tool/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final List<StoreSummary> _storeSummarys = [
    StoreSummary(1, Images.cake, '蛋糕專區', ''),
    StoreSummary(2, Images.breakfast, '早餐專區', ''),
    StoreSummary(3, Images.dinner, '派對專區', ''),
    StoreSummary(4, Images.fruit, '蔬食專區', ''),
    StoreSummary(5, Images.desert, '甜品專區', ''),
    StoreSummary(6, Images.food, '異國料理專區', ''),
    StoreSummary(7, Images.drink, '飲料專區', ''),
    StoreSummary(8, Images.bread, '麵包專區', ''),
    StoreSummary(9, Images.chineseFood, '中式料理', ''),
    StoreSummary(10, Images.japaneseFood, '日式料理', ''),
    StoreSummary(11, Images.fastFood, '快餐料理', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: _buildSearchBar(),
      ),

      // body: GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder),
      body: GridView.count(
        /**
         * 限制item比例，影響item高度
         */
        childAspectRatio: 12 / 9,
        shrinkWrap: true,
        crossAxisCount: 2,
        /**
         * 使用ScrollPhysics才能滑動
         * 無法使用NeverScrollableScrollPhysics取消滑動特效
         */
        // physics: const ScrollPhysics(),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        children: _storeSummarys.map<Widget>((e) => _buildStore(e)).toList(),
      ),
    );
  }
}

Widget _buildSearchBar() {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.black12),
    child: Row(
      children: [
        const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          '搜尋店家，例如：阜杭豆漿',
          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
        ),
      ],
    ),
  );
}

Widget _buildStore(StoreSummary storeSummary) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            /**
             * fit: BoxFit.cover, height: double.infinity, width: double.infinity
             * 才能延展，只有fit屬性不行
             */
            Image(
              image: AssetImage(storeSummary.imgUrl),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              color: const Color(0x77000000),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                storeSummary.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
