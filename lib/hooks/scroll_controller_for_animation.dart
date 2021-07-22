import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// In order to dispose hooks, we have to create a entire class.

ScrollController useScrollControllerForAnimation(
  AnimationController animationController,
) {
  ///Calling this function would calls the animationhook without exposing it
  return use(_ScrollControllerForAnimationHook(
    animationController: animationController,
  ));
}

/// Privatized so that the boiler plate will not be exposed to the homepage.
class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
  final AnimationController animationController;

  const _ScrollControllerForAnimationHook({
    required this.animationController,
  });

  @override
  _ScrollControllerForAnimationHookState createState() =>
      _ScrollControllerForAnimationHookState();
}

class _ScrollControllerForAnimationHookState
    extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
  late ScrollController _scrollController;
  @override
  void initHook() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          hook.animationController.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          hook.animationController.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  ScrollController build(BuildContext context) => _scrollController;

  @override
  void dispose() => _scrollController.dispose();
}
