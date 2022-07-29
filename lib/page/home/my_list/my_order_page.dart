import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'my_order_view_model.dart';

// TODO('Hook')
class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with TickerProviderStateMixin {
  final tabs = const [Text('尚未付款'), Text('即將到來'), Text('歷史訂單')];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer(
            builder: (context, ref, child) {
              return TabBar(
                labelPadding: const EdgeInsets.all(12),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                controller: _tabController,
                tabs: tabs,
                onTap: (value) {
                  ref.read(_tabPosition.state).state = value;
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(_tabPosition.state).state != 0
                      ? Row(
                          children: [
                            Expanded(
                              child: Consumer(
                                builder: (context, ref, child) {
                                  return OutlinedButton(
                                      onPressed: () {
                                        ref.read(_labelPosition.state).state =
                                            0;
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: ref
                                                    .watch(_labelPosition.state)
                                                    .state ==
                                                0
                                            ? Colors.yellow[100]
                                            : Colors.white,
                                        side: const BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      child: Text(
                                        '外送訂單',
                                        style: TextStyle(
                                            color: ref
                                                        .watch(_labelPosition
                                                            .state)
                                                        .state ==
                                                    0
                                                ? Colors.black
                                                : Colors.grey),
                                      ));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Consumer(
                                builder: (context, ref, child) {
                                  return OutlinedButton(
                                      onPressed: () {
                                        ref.read(_labelPosition.state).state =
                                            1;
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: ref
                                                    .watch(_labelPosition.state)
                                                    .state ==
                                                1
                                            ? Colors.yellow[100]
                                            : Colors.white,
                                        side: const BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      child: Text(
                                        '宅配訂單',
                                        style: TextStyle(
                                            color: ref
                                                        .watch(_labelPosition
                                                            .state)
                                                        .state ==
                                                    1
                                                ? Colors.black
                                                : Colors.grey),
                                      ));
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
              const Divider(),
              const Expanded(child: Center(child: Text('登入會員查詢'))),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }
}
