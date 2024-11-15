import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

// class CustomDropdownButtonFormField extends StatefulWidget {
//   const CustomDropdownButtonFormField({
//     super.key,
//     required this.labelText,
//     this.suffixIcon,
//     this.isRequired = false,
//     this.isNumbersOnly = false,
//     this.onChanged,
//     required this.categories,
//   });
//
//   final bool isRequired;
//   final String labelText;
//   final Widget? suffixIcon;
//   final bool isNumbersOnly;
//   final Function(String? value)? onChanged;
//   final List<String> categories;
//
//   @override
//   _CustomDropdownButtonFormFieldState createState() =>
//       _CustomDropdownButtonFormFieldState();
// }
//
// class _CustomDropdownButtonFormFieldState
//     extends State<CustomDropdownButtonFormField> {
//   late TextEditingController _controller;
//   List<String> _filteredCategories = [];
//   String? _selectedCategory;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _filteredCategories = widget.categories;
//   }
//
//   void _filterCategories() {
//     _filteredCategories = widget.categories
//         .where((category) =>
//             category.toLowerCase().contains(_controller.text.toLowerCase()))
//         .toList();
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: DropdownButtonFormField<String>(
//         value: _selectedCategory,
//         items: [
//           DropdownMenuItem<String>(
//             enabled: false,
//             child: SizedBox(
//               width: 200, // Ensures that the width is finite
//               child: TextField(
//                 controller: _controller,
//                 onChanged: (value) {
//                   _filterCategories();
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Search...',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.all(10),
//                 ),
//               ),
//             ),
//           ),
//           ..._filteredCategories.map((category) {
//             return DropdownMenuItem<String>(
//               value: category,
//               child: Text(category),
//             );
//           }).toList(),
//           const DropdownMenuItem<String>(
//             value: "add",
//             child: Text("Add New..."),
//           ),
//         ],
//         onChanged: (String? newValue) {
//           setState(() {
//             _selectedCategory = newValue;
//           });
//           widget.onChanged?.call(newValue);
//         },
//         validator: _validator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           label: _label(),
//           labelStyle: const TextStyle(color: AppColors.labelColor),
//           suffixIcon: widget.suffixIcon,
//         ),
//       ),
//     );
//   }
//
//   String? _validator(data) {
//     if (widget.isRequired && data!.isEmpty) {
//       return "هذا البيان مطلوب";
//     }
//     return null;
//   }
//
//   Text _label() {
//     return Text.rich(
//       TextSpan(
//         children: [
//           TextSpan(text: widget.labelText),
//           if (widget.isRequired)
//             const TextSpan(text: " *", style: TextStyle(color: Colors.red)),
//         ],
//       ),
//     );
//   }
// }

class CategorySelectionField extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String) onCategorySelected;
  final Function(String) onNewCategoryAdded;
  final bool isSearchable;
  final bool isEditable;
  final double height;

  const CategorySelectionField({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
    required this.onNewCategoryAdded,
    this.isSearchable = true,
    this.isEditable = true,
    this.height = 170,
  });

  @override
  State<CategorySelectionField> createState() => _CategorySelectionFieldState();
}

class _CategorySelectionFieldState extends State<CategorySelectionField> {
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  List<String> _filteredCategories = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _filteredCategories = widget.categories;
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedCategory ?? 'Category',
                  style: const TextStyle(fontSize: 16),
                ),
                Icon(_isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _filterCategories(String query) {
    setState(() {
      _filteredCategories = widget.categories
          .where((category) =>
              category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    _updateOverlay();
  }

  void _showAddCategoryDialog() {
    final TextEditingController controller = TextEditingController();
    _removeOverlay();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اضافة نوع جديد'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'النوع',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('الغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                widget.onNewCategoryAdded(controller.text.trim());
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text('اضافة'),
          ),
        ],
      ),
    );
  }

  void _createOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: _layerLink.leaderSize?.width ?? 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 65),
          child: Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              constraints: BoxConstraints(maxHeight: widget.height),
              child: Column(
                children: [
                  // Search Field
                  if (widget.isSearchable)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: 'بحث ...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16)),
                        onChanged: _filterCategories,
                      ),
                    ),
                  // Categories List
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredCategories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _filteredCategories.length) {
                          if (!widget.isEditable) return const SizedBox();
                          return ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('اضافة نوع جديد'),
                            onTap: _showAddCategoryDialog,
                          );
                        }

                        final category = _filteredCategories[index];
                        return ListTile(
                          title: Text(category),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          selected: widget.selectedCategory == category,
                          selectedTileColor: AppColors.primaryColor,
                          selectedColor: Colors.black,
                          onTap: () {
                            widget.onCategorySelected(category);
                            _searchController.clear();
                            _filterCategories('');
                            _removeOverlay();
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    if (!mounted) setState(() => _isDropdownOpen = false);
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
      if (_isDropdownOpen) {
        _createOverlay();
      } else {
        _removeOverlay();
      }
    });
  }
}
