import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';

class CustomAnimatedSearchBar extends StatefulWidget {
  const CustomAnimatedSearchBar({super.key});

  @override
  State<CustomAnimatedSearchBar> createState() =>
      _CustomAnimatedSearchBarState();
}

class _CustomAnimatedSearchBarState extends State<CustomAnimatedSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return AnimatedSearchBar(
          width: MediaQuery.of(context).size.width * .8,
          textController: _searchController,
          searchHintText: "اسم الموديل او الرقم التعريفي",
          onChanged: (value) {
            context.read<HomeCubit>().setSearchedProducts(value);
            print('Search query: $value');
          },
          onSuffixTap: () {
            _searchController.clear();
            context.read<HomeCubit>().clearSearchedProducts();
          },

          textColor: Colors.black,
          searchIconColor: AppColors.primaryColor, // Optional
          closeIconColor: AppColors.primaryColor, // Optional
        );
      },
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  final double width;
  final TextEditingController textController;
  final Function(String) onChanged;
  final Function() onSuffixTap;
  final String searchHintText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? searchIconColor;
  final Color? closeIconColor;

  const AnimatedSearchBar({
    super.key,
    required this.width,
    required this.textController,
    required this.onChanged,
    required this.onSuffixTap,
    this.searchHintText = "Search here...",
    this.backgroundColor,
    this.textColor,
    this.searchIconColor,
    this.closeIconColor,
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _rotationAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: 35,
          width: _widthAnimation.value * widget.width + 48,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              if (_widthAnimation.value > 0)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: widget.textController,
                      onChanged: widget.onChanged,
                      style: TextStyle(
                        color: widget.textColor ?? Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.searchHintText,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        hintStyle: TextStyle(
                          color: widget.textColor?.withOpacity(0.5) ??
                              AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: 48,
                height: 48,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      if (_isOpen) {
                        widget.onSuffixTap();
                      }
                      _toggleSearch();
                    },
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 3.14159,
                      child: Icon(
                        _isOpen ? Icons.close_rounded : Icons.search,
                        color: _isOpen
                            ? (widget.closeIconColor ?? Colors.black)
                            : (widget.searchIconColor ?? Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
