part of 'my_order_page.dart';

// TODO('保留資料與不用時釋放')
// var _tabPosition = StateProvider.autoDispose<int>((ref) {
//   ref.maintainState = true;
//   return 0;
// });
//
// ProviderContainer container = ProviderScope.containerOf(context);
// container.read(_tabPosition.notifier).dispose();

var _tabPosition = StateProvider((ref) => 0);

var _labelPosition = StateProvider((ref) => 0);
