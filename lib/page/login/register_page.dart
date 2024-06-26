import 'package:cutaway/router/route_utils.dart';
import 'package:cutaway/utils/image_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'register_view_model.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageUtil.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          '註冊會員',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Expanded(
              child: _NameField(accountController: _nameController),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _AppellationPicker(),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const _BirthdayPicker(),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => context.go(AppPage.home.fullPath),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
              backgroundColor: WidgetStateProperty.all(Colors.grey),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
            ),
            child: const Text(
              '下一步',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: TextButton(
            onPressed: () => context.go(AppPage.home.fullPath),
            child: const Text(
              '忘記密碼?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NameField extends ConsumerWidget {
  const _NameField({
    super.key,
    required TextEditingController accountController,
  }) : _controller = accountController;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        ref.read(_isNameNotEmpty.notifier).state = value.isNotEmpty;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: '姓名',
        suffixIcon: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Consumer(builder: (context, ref, child) {
              return ref.watch(_isNameNotEmpty.notifier).state
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        ref.read(_isNameNotEmpty.notifier).state = false;
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox();
            }),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}

class _AppellationPicker extends ConsumerWidget {
  _AppellationPicker({super.key});

  final items = [
    "先生",
    "小姐",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _showAppellationPicker(context, ref),
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
        side: WidgetStateProperty.all(const BorderSide(color: Colors.black, width: 0.5)),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final appellation = ref.watch(_appellation.notifier).state;
          return Text(
            appellation.isEmpty ? '稱謂' : appellation,
            style: TextStyle(color: appellation.isEmpty ? Colors.grey : Colors.black, fontSize: 16.sp),
          );
        },
      ),
    );
  }

  void _showAppellationPicker(context, ref) {
    if (ref.read(_appellation.notifier).state.isEmpty) {
      ref.read(_appellation.notifier).state = items[0];
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 190,
        color: CupertinoColors.white,
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: _buildCupertinoPicker(ref),
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoPicker(ref) {
    return CupertinoPicker(
      magnification: 1.5,
      backgroundColor: Colors.white,
      itemExtent: 40,
      children: items
          .map((item) => Center(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 24.sp),
                ),
              ))
          .toList(),
      onSelectedItemChanged: (index) => ref.read(_appellation.notifier).state = items[index],
    );
  }
}

class _BirthdayPicker extends ConsumerWidget {
  const _BirthdayPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => _showDatePicker(context, ref),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
          side: WidgetStateProperty.all(const BorderSide(
            color: Colors.black,
            width: 0.5,
          )),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final birthday = ref.watch(_birthday.notifier).state;
            return Text(
              birthday.isEmpty ? '生日' : birthday,
              style: TextStyle(
                color: birthday.isEmpty ? Colors.grey : Colors.black,
                fontSize: 16.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDatePicker(context, ref) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 190,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(1900, 1, 1),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (value) =>
                    ref.read(_birthday.notifier).state = '${value.year}-${value.month}-${value.day}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
