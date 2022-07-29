import 'package:flutter/material.dart';

class BulletinDialog extends StatelessWidget {
  const BulletinDialog({Key? key}) : super(key: key);

  final String _content = '1. 因應疫情避免交叉就感染，卡個位目前僅提供線上付款方式。\n\n'
      '2. 若您需無接觸送餐，可寫在備註告知管家\n\n'
      '提醒您，無接觸送餐需明確備註放置地點，如：請放在xx號門口白色櫃子、請放在oo號門口籃子\n\n'
      '※請務必正確填收件人電話。\n\n'
      '3. 若您選擇無接觸送餐無法即刻對點，餐點若有問題請於送達後盡速拍照連繫我們。\n\n'
      '4. 若您的收件地址是在醫院，屆時都需請收件人至該醫院的一樓門口外取餐，感謝您的理解與體諒。\n\n';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const Positioned.fill(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '卡個位防疫公告',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            // padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      _content,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    '我知道了',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
