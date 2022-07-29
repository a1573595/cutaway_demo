import 'package:cutaway/router/route_utils.dart';
import 'package:cutaway/tool/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
  _Body({Key? key}) : super(key: key);

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        const Text(
          '會員登入',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 32,
        ),
        _AccountField(accountController: _accountController),
        const SizedBox(
          height: 16,
        ),
        _PasswordField(passwordController: _passwordController),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () => GoRouter.of(context).go(AppPage.home.fullPath),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)))),
              child: const Text(
                '登入',
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: TextButton(
              onPressed: () => GoRouter.of(context).go(AppPage.home.fullPath),
              child: const Text(
                '忘記密碼?',
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }
}

class _AccountField extends ConsumerWidget {
  const _AccountField({
    Key? key,
    required TextEditingController accountController,
  })  : _controller = accountController,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        ref.read(_isAccountNotEmpty.state).state = value.isNotEmpty;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '信箱',
          suffixIcon: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Consumer(builder: (context, ref, child) {
                return ref.watch(_isAccountNotEmpty.state).state
                    ? IconButton(
                        onPressed: () {
                          _controller.clear();
                          ref.read(_isAccountNotEmpty.state).state = false;
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
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5))),
    );
  }
}

class _PasswordField extends ConsumerWidget {
  const _PasswordField({
    Key? key,
    required TextEditingController passwordController,
  })  : _controller = passwordController,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        ref.read(_isPasswordNotEmpty.state).state = value.isNotEmpty;
      },
      obscureText: !ref.watch(_isPasswordVisible.state).state,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '密碼',
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Consumer(
                    builder: (context, ref, child) {
                      return IconButton(
                          onPressed: () {
                            ref
                                .read(_isPasswordVisible.state)
                                .update((state) => !state);
                          },
                          icon: Icon(
                            !ref.watch(_isPasswordVisible.state).state
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          ));
                    },
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Consumer(builder: (context, ref, child) {
                    return ref.watch(_isPasswordNotEmpty.state).state
                        ? IconButton(
                            onPressed: () {
                              _controller.clear();
                              ref.read(_isPasswordNotEmpty.state).state = false;
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                          )
                        : const SizedBox();
                  }),
                ),
              )
            ],
          ),
          contentPadding: const EdgeInsets.only(left: 12),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5))),
    );
  }
}
