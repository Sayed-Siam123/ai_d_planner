import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_event.dart';
import 'package:ai_d_planner/app/services/filter/bloc/filter_cubit.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/expansion/bloc/expansion_tile_bloc.dart';
import '../../services/sorting/bloc/sorting_event.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/custom_pop_scope.dart';
import 'app_widgets.dart';
import 'custom_buttons_widget.dart';

class CustomDialog {
  dynamic appExit(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          // actionsPadding: const EdgeInsets.all(20),
          backgroundColor: AppColors.whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(logo,height: 25,width: 25,),
              // AppWidgets().gapW8(),
              Text(
                'Warning',
                style: textRegularStyle(context,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.warningRed),
              ),
            ],
          ),
          content: Text(
            'Are you sure to exit the app?',
            style: textRegularStyle(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12.0, 5.0, 12.0),
              child: CustomAppTextButton(
                title: "Exit",
                textColor: AppColors.warningRed,
                onPressed: () async {
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
              ),
            ),
            AppWidgets().gapW8(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
              child: CustomAppTextButton(
                title: "Cancel",
                textColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static simpleDialog(context, {title = "Warning", message}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          // actionsPadding: const EdgeInsets.all(20),
          backgroundColor: AppColors.whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(logo,height: 25,width: 25,),
              // AppWidgets().gapW8(),
              Text(
                '$title',
                style: textRegularStyle(context,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.warningRed),
              ),
            ],
          ),
          content: Text(
            '$message',
            style: textRegularStyle(context, fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
              child: CustomAppTextButton(
                title: "I Understand",
                textColor: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static customMessageDialog(
    context, {
    title = "Warning",
    message,
    String? cancelButtonTitle = "",
    String? confirmButtonTitle = "",
    Color? titleTextColor = AppColors.primaryColor,
    Color? cancelButtonTextColor = AppColors.primaryColor,
    Color? confirmButtonTextColor = AppColors.primaryColor,
    Function()? cancelButtonOnTap,
    Function()? confirmButtonOnTap,
    bool? barrierDismissal = true,
    bool popScope = false,
  }) async {
    //popScope = false means there will be no popscope, popScope = true means there can be popScope feature

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissal ?? true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return !popScope
            ? CustomPopScope(
                onPopScope: () {},
                child: AlertDialog(
                  surfaceTintColor: Colors.transparent,
                  // actionsPadding: const EdgeInsets.all(20),
                  backgroundColor: AppColors.whitePure,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset(logo,height: 25,width: 25,),
                      // AppWidgets().gapW8(),
                      Text(
                        '$title',
                        style: textRegularStyle(context,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: titleTextColor),
                      ),
                    ],
                  ),
                  content: Text(
                    '$message',
                    style:
                        textRegularStyle(context, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    if (cancelButtonTitle!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
                        child: CustomAppTextButton(
                          title: cancelButtonTitle,
                          textColor: cancelButtonTextColor,
                          fontWeight: FontWeight.w600,
                          onPressed: () {
                            cancelButtonOnTap!();
                          },
                        ),
                      ),
                    if (confirmButtonTitle!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
                        child: CustomAppTextButton(
                          title: confirmButtonTitle,
                          textColor: confirmButtonTextColor,
                          fontWeight: FontWeight.w600,
                          onPressed: () {
                            confirmButtonOnTap!();
                          },
                        ),
                      ),
                  ],
                ),
              )
            : AlertDialog(
                surfaceTintColor: Colors.transparent,
                // actionsPadding: const EdgeInsets.all(20),
                backgroundColor: AppColors.whitePure,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Image.asset(logo,height: 25,width: 25,),
                    // AppWidgets().gapW8(),
                    Text(
                      '$title',
                      style: textRegularStyle(context,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: titleTextColor),
                    ),
                  ],
                ),
                content: Text(
                  '$message',
                  style: textRegularStyle(context, fontWeight: FontWeight.w500),
                ),
                actions: [
                  if (cancelButtonTitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
                      child: CustomAppTextButton(
                        title: cancelButtonTitle,
                        textColor: cancelButtonTextColor,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          cancelButtonOnTap!();
                        },
                      ),
                    ),
                  if (confirmButtonTitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 16.0, 12.0),
                      child: CustomAppTextButton(
                        title: confirmButtonTitle,
                        textColor: confirmButtonTextColor,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          confirmButtonOnTap!();
                        },
                      ),
                    ),
                ],
              );
      },
    );
  }

  static sortDialog() async {
    return showDialog(
      context: AppWidgets().globalContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort By'),
          content: BlocConsumer<SortBloc, SortState>(
            listener: (context, state) {
              if (state is SortByBudgetHighToLow) {
                // getIt<ExploreBloc>().add();
              }
            },
            builder: (context, state) {
              return BlocBuilder<SortBloc, SortState>(
                builder: (context, state) {
                  // SortSelectedItem selectedSort = SortSelectedItem.none;
                  // if (state is SortSelected) {
                  //   selectedSort = state.sortOption;
                  // }

                  // printLog(selectedSort);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption == SortSelectedItem.none
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: "None",
                        onTap: () {
                          getIt<SortBloc>().add(SortByNone());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: false,
                              sortSelectedItem: SortSelectedItem.none));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption ==
                                    SortSelectedItem.budgetLowToHigh
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'Budget (Low to High)',
                        onTap: () {
                          getIt<SortBloc>().add(SortByBudgetLowToHigh());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: true,
                              sortSelectedItem:
                                  SortSelectedItem.budgetLowToHigh));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption ==
                                    SortSelectedItem.budgetHighToLow
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'Budget (High to Low)',
                        onTap: () {
                          getIt<SortBloc>().add(SortByBudgetHighToLow());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: false,
                              sortSelectedItem:
                                  SortSelectedItem.budgetHighToLow));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption == SortSelectedItem.aToZ
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'A-Z',
                        onTap: () {
                          getIt<SortBloc>().add(SortByAToZ());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: true,
                              sortSelectedItem: SortSelectedItem.aToZ));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption == SortSelectedItem.zToA
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'Z-A',
                        onTap: () {
                          getIt<SortBloc>().add(SortByZToA());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: false,
                              sortSelectedItem: SortSelectedItem.zToA));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption ==
                                    SortSelectedItem.newestToOldest
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'Newest to Oldest',
                        onTap: () {
                          getIt<SortBloc>().add(SortByNewestToOldest());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: false,
                              sortSelectedItem:
                                  SortSelectedItem.newestToOldest));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                      _listTileWidget(
                        color: state is SortSelected
                            ? state.sortOption ==
                                    SortSelectedItem.oldestToNewest
                                ? AppColors.primaryColor.withValues(alpha: 0.5)
                                : AppColors.transparentPure
                            : AppColors.transparentPure,
                        title: 'Oldest to Newest',
                        onTap: () {
                          getIt<SortBloc>().add(SortByOldestToNewest());
                          getIt<ExploreBloc>().add(SortPlansList(
                              ascending: true,
                              sortSelectedItem:
                                  SortSelectedItem.oldestToNewest));
                          Navigator.pop(AppWidgets().globalContext);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
  static _listTileWidget({title, Color? color, VoidCallback? onTap}) {
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        title: Text(
          '$title',
          style: textRegularStyle(AppWidgets().globalContext,
              fontWeight: color == AppColors.transparentPure ? FontWeight.normal : FontWeight.bold,
              fontSize: 16,
              isWhiteColor: color == AppColors.transparentPure ? false : true),
        ),
        onTap: () => onTap?.call(),
      ),
    );
  }

/*  customLocationDateTimeDialog(
      BuildContext context, {
        String title = "Select Date, Location",
        String confirmButtonTitle = "Confirm",
        String cancelButtonTitle = "Cancel",
        String resetButtonTitle = "Reset",
        Color titleTextColor = Colors.black,
        Color confirmButtonTextColor = Colors.blue,
        Color cancelButtonTextColor = Colors.red,
        Function(String location, DateTime dateTime)? onConfirm,
        Function()? onCancel,
        Function()? onReset,
        bool barrierDismissal = true,
      }) async
  {
    TextEditingController locationController = TextEditingController();
    // DateTime selectedDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTimeRange? selectedDateRange;
    RangeValues budgetRange = RangeValues(100, 1000);
    String? selectedMood;
    String? selectedDateType;

    final List<String> filters = [
      "Location",
      "Date Range",
      "Budget Range",
      "Mood Type",
      "Date type"
    ];

    final List<Widget> filterItem = [
      _locationWidget(locationController),
      _dateRangeWidget(selectedDateRange),
      _budgetRangeWidget(budgetRange),
      _moodTypeWidget(selectedMood),
      _dateTypeWidget(selectedDateType),
    ];

    List<ExpansionTileController> controllers = List.generate(
      filters.length,
          (_) => ExpansionTileController(),
    );

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissal,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: titleTextColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ExpansionBloc, ExpansionState>(
                builder: (context, state) {
                  var expansionBloc = getIt<ExpansionBloc>();

                  return SingleChildScrollView(
                    child: Column(
                      children: filters.map(
                            (e) {
                          int index = filters.indexOf(e);
                          final isExpanded = state.expandedIndex == index;

                          return Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: AppColors.grayDark, // Keep the whole panel (title + arrow) same color
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: AppColors.grayDark),
                                ),
                                child: ExpansionTile(
                                  key: Key(index.toString()),
                                  controller: controllers[index],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        color: AppColors.grayDark,
                                      )
                                  ),
                                  collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  backgroundColor: Colors.transparent, // Prevents ExpansionTile from overriding background
                                  collapsedBackgroundColor: Colors.transparent,
                                  tilePadding: const EdgeInsets.symmetric(horizontal: 16), // Adjust padding
                                  title: Text(
                                    e,
                                    style: TextStyle(color: AppColors.blackPure), // Keep text color white
                                  ),
                                  initiallyExpanded: false,
                                  onExpansionChanged: (expanded) {
                                    if (expanded) {
                                      for (int i = 0; i < controllers.length; i++) {
                                        if (i != index) controllers[i].collapse();
                                      }
                                      expansionBloc.add(ExpansionEvent(index));
                                      // isExpanded == false ? controllers[index].expand() : controllers[index].collapse();
                                    } else {
                                      expansionBloc.add(ExpansionEvent(null));
                                      // controllers[index].collapse();
                                    }
                                  },
                                  children: [
                                    Container(
                                        width: double.maxFinite,
                                        color: Colors.white, // Expanded section background
                                        padding: const EdgeInsets.all(16.0),
                                        child: filterItem[index]
                                    ),
                                  ],
                                ),
                              ),
                              AppWidgets().gapH8(),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (onReset != null) onReset();
                Navigator.of(context).pop();
              },
              child: Text(
                resetButtonTitle,
                style: TextStyle(color: confirmButtonTextColor),
              ),
            ),
            // Cancel Button
            TextButton(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.of(context).pop();
              },
              child: Text(
                cancelButtonTitle,
                style: TextStyle(color: cancelButtonTextColor),
              ),
            ),
            // Confirm Button
            TextButton(
              onPressed: () {
                if (onConfirm != null) {
                  // onConfirm(
                  //   locationController.text,
                  //   selectedDateTime,
                  // );
                  printLog(selectedDateType);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                confirmButtonTitle,
                style: TextStyle(color: confirmButtonTextColor),
              ),
            ),
          ],
        );
      },
    );
  }
  _locationWidget(TextEditingController locationController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: locationController,
          decoration: InputDecoration(
            hintText: "Enter location",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }
  _dateRangeWidget(DateTimeRange? selectedDateRange) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    selectedDateRange = picked;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedDateRange == null
                      ? "Select Date Range"
                      : "${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  _budgetRangeWidget(RangeValues budgetRange) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Budget Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RangeSlider(
              values: budgetRange,
              min: 0,
              max: 5000,
              divisions: 50,
              labels: RangeLabels(
                "\$${budgetRange.start.toInt()}",
                "\$${budgetRange.end.toInt()}",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  budgetRange = values;
                });
              },
            ),
            Text(
              "Selected Range: \$${budgetRange.start.toInt()} - \$${budgetRange.end.toInt()}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        );
      },
    );
  }
  _moodTypeWidget(String? selectedMood) {
    List<String> moods = ["Happy", "Relaxed", "Adventurous", "Romantic"];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mood Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: moods.map((mood) {
                return ChoiceChip(
                  label: Text(mood),
                  selected: selectedMood == mood,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedMood = selected ? mood : null;
                    });
                  },
                );
              }).toList(),
            ),
            if (selectedMood != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Selected Mood: $selectedMood",
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }
  _dateTypeWidget(String? selectedDateType) {
    List<String> dateTypes = ["Single Date", "Date Range"];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: dateTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: selectedDateType == type,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedDateType = selected ? type : null;
                    });
                  },
                );
              }).toList(),
            ),
            if (selectedDateType != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Selected Date Type: $selectedDateType",
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }*/
}

class CustomLocationDateTimeDialog extends StatefulWidget {
  final String title;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final String resetButtonTitle;
  final Color titleTextColor;
  final Color confirmButtonTextColor;
  final Color cancelButtonTextColor;
  final Function(String location, DateTimeRange? dateRange, RangeValues budgetRange, String? mood, String? dateType)? onConfirm;
  final Function()? onCancel;
  final Function()? onReset;

  const CustomLocationDateTimeDialog({
    Key? key,
    this.title = "Select Date, Location",
    this.confirmButtonTitle = "Confirm",
    this.cancelButtonTitle = "Cancel",
    this.resetButtonTitle = "Reset",
    this.titleTextColor = Colors.black,
    this.confirmButtonTextColor = AppColors.primaryColor,
    this.cancelButtonTextColor = Colors.red,
    this.onConfirm,
    this.onCancel,
    this.onReset,
  }) : super(key: key);

  @override
  _CustomLocationDateTimeDialogState createState() => _CustomLocationDateTimeDialogState();
}

class _CustomLocationDateTimeDialogState extends State<CustomLocationDateTimeDialog> {

  final List<String> filters = [
    "Location",
    "Date Range",
    "Budget Range",
    "Mood Type",
    "Date type"
  ];

  List<ExpansionTileController> controllers = [];

  final List<Widget> filterItem = [];

  var filterCubit = getIt<FilterCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers.addAll(List.generate(
      filters.length,
          (_) => ExpansionTileController(),
    ));

    filterItem.addAll([
      _locationWidget(),
      _dateRangeWidget(),
      _budgetRangeWidget(),
      _moodTypeWidget(),
      _dateTypeWidget(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.titleTextColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (widget.onCancel != null) widget.onCancel!();
              Navigator.of(context).pop();
            },
            child: Text(
              widget.cancelButtonTitle,
              style: TextStyle(color: widget.cancelButtonTextColor,fontSize: 18),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ExpansionBloc, ExpansionState>(
            builder: (context, state) {
              var expansionBloc = getIt<ExpansionBloc>();

              return SingleChildScrollView(
                child: Column(
                  children: filters.map(
                        (e) {
                      int index = filters.indexOf(e);
                      final isExpanded = state.expandedIndex == index;

                      return Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.15), // Keep the whole panel (title + arrow) same color
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.15)),
                            ),
                            child: ExpansionTile(
                              key: Key(index.toString()),
                              controller: controllers[index],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(
                                    color: AppColors.grayDark,
                                  )
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor: Colors.transparent, // Prevents ExpansionTile from overriding background
                              collapsedBackgroundColor: Colors.transparent,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 16), // Adjust padding
                              title: Text(
                                e,
                                style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w600), // Keep text color white
                              ),
                              initiallyExpanded: false,
                              onExpansionChanged: (expanded) {
                                if (expanded) {
                                  for (int i = 0; i < controllers.length; i++) {
                                    if (i != index) controllers[i].collapse();
                                  }
                                  expansionBloc.add(ExpansionEvent(index));
                                } else {
                                  expansionBloc.add(ExpansionEvent(null));
                                }
                              },
                              children: [
                                Container(
                                    width: double.maxFinite,
                                    color: Colors.white, // Expanded section background
                                    padding: const EdgeInsets.all(16.0),
                                    child: filterItem[index]
                                ),
                              ],
                            ),
                          ),
                          AppWidgets().gapH8(),
                        ],
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        // Reset Button
        TextButton(
          onPressed: () {
            filterCubit.resetFilters();
            if (widget.onReset != null) widget.onReset!();
            Navigator.of(context).pop();
          },
          child: Text(
            widget.resetButtonTitle,
            style: TextStyle(color: widget.confirmButtonTextColor,fontSize: 18),
          ),
        ),
        // Confirm Button
        TextButton(
          onPressed: () {
            if (widget.onConfirm != null) {
              widget.onConfirm!(
                  filterCubit.state.location,
                  filterCubit.state.dateRange,
                  filterCubit.state.budgetRange,
                  filterCubit.state.mood,
                  filterCubit.state.dateType
              );
            }
            Navigator.of(context).pop();
          },
          child: Text(
            widget.confirmButtonTitle,
            style: TextStyle(color: widget.confirmButtonTextColor,fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _locationWidget() {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {

        final TextEditingController _controller = TextEditingController(text: state.location);

        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _controller,
              onChanged: (value) => getIt<FilterCubit>().updateLocation(value),
              decoration: InputDecoration(
                hintText: "Enter location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dateRangeWidget() {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year-5),
                  lastDate: DateTime(DateTime.now().year+1),
                );
                if (picked != null) {
                  getIt<FilterCubit>().updateDateRange(picked);
                }
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text.rich(
                        state.dateRange == null ? TextSpan(
                          text: "Select Date Range",
                        ) : TextSpan(
                          children: [
                            TextSpan(text: _getDateFormat(state.dateRange!.start.toLocal().toString()),style: textRegularStyle(context,fontWeight: FontWeight.w800)),
                            TextSpan(text: " - ",style: textRegularStyle(context,fontWeight: FontWeight.w600)),
                            TextSpan(text: _getDateFormat(state.dateRange!.end.toLocal().toString()),style: textRegularStyle(context,fontWeight: FontWeight.w800)),
                          ]
                        )
                    ),
                  ),
                  state.dateRange != null ? Row(
                    children: [
                      AppWidgets().gapW12(),
                      Text("Edit",style: textRegularStyle(context,fontWeight: FontWeight.w500,color: AppColors.primaryColor,fontSize: 17)),
                    ],
                  ) : const SizedBox(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _budgetRangeWidget() {
    return BlocBuilder<FilterCubit,FilterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Budget Range",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RangeSlider(
              values: state.budgetRange,
              min: 0,
              max: 5000,
              divisions: 50,
              labels: RangeLabels(
                "\$${state.budgetRange.start.toInt()}",
                "\$${state.budgetRange.end.toInt()}",
              ),
              onChanged: (RangeValues values) {
                getIt<FilterCubit>().updateBudgetRange(values);
              },
            ),
            Text(
              "Selected Range: \$${state.budgetRange.start.toInt()} - \$${state.budgetRange.end.toInt()}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        );
      },
    );
  }

  Widget _moodTypeWidget() {
    List<String> moods = ["Romantic and intimate", "Adventurous and exciting", "Relaxing and cozy", "Energetic and fun"];

    return BlocBuilder<FilterCubit,FilterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mood Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: moods.map((mood) {
                return ChoiceChip(
                  label: Text(mood),
                  selected: state.mood == mood,
                  onSelected: (bool selected) {
                   getIt<FilterCubit>().updateMood(selected ? mood : null);
                  },
                );
              }).toList(),
            ),
            if (state.mood != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Selected Mood: ${state.mood}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _dateTypeWidget() {
    List<String> dateTypes = ["Indoor", "Outdoor"];

    return BlocBuilder<FilterCubit,FilterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: dateTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: state.dateType == type,
                  onSelected: (bool selected) {
                    getIt<FilterCubit>().updateDateType(selected ? type : null);
                  },
                );
              }).toList(),
            ),
            if (state.dateType != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Selected Date Type: ${state.dateType}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }

  String? _getDateFormat(String? dateTime) {
    // Parse the input string
    // DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = DateTime.parse(dateTime!);

    // Format the date
    String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);

    return formattedDate;
  }
}
