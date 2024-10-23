import 'package:flutter/material.dart';

import '../models/event_categories_enum.dart';
import 'filters_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(Map<String, dynamic>) onFilterChanged;

  const SearchBarWidget({
    super.key,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterExpanded = false;
  EventCategory _selectedCategory = EventCategory.all;
  DateTimeRange? _selectedDateRange;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
      if (_isFilterExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _applyFilter(EventCategory selectedCategory, DateTimeRange? dateRange) {
    widget.onFilterChanged({
      'category': selectedCategory,
      'dateRange': dateRange,
    });
    _toggleFilter();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 10 + _animation.value * 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1 + _animation.value * 0.1),
                blurRadius: 10 + _animation.value * 20,
                spreadRadius: 2 + _animation.value * 5,
                offset: Offset(0, 5 + _animation.value * 5),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            widget.onSearchChanged('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: widget.onSearchChanged,
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _animation.value *
                            250, // Adjust this value as needed
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Opacity(
                            opacity: _animation.value,
                            child: FiltersWidget(
                              selectedCategory: _selectedCategory,
                              selectedDateRange: _selectedDateRange,
                              onFilterChanged: (category, dateRange) {
                                setState(() {
                                  if (category != null)
                                    _selectedCategory = category;
                                  _selectedDateRange = dateRange;
                                });
                                _applyFilter(
                                    category ?? EventCategory.all, dateRange);
                              },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleFilter,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: AnimatedRotation(
                            turns: _animation.value * 0.5,
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
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
