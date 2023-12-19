import 'package:flutter/material.dart';
import 'package:weather_flutter/core/components/base/base_icon_button.dart';
import 'package:weather_flutter/core/constants/color_constant.dart';
import 'package:weather_flutter/core/enums/app_navbar_pages.dart';

class WeatherNavbarButton extends StatefulWidget {
  const WeatherNavbarButton({super.key, required this.page, required this.onPressed});

  final AppNavbarPages page;
  final void Function() onPressed;

  @override
  State<WeatherNavbarButton> createState() => _WeatherNavbarButtonState();
}

class _WeatherNavbarButtonState extends State<WeatherNavbarButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() {
    if (_controller.isAnimating) {
      return;
    }

    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: BaseIconButton(
              iconData: widget.page.iconData,
              onPressed: () {
                _runAnimation();
                widget.onPressed();
              },
              iconColor: ColorConstant.navbarButtonColor,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 20,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        });
  }
}
