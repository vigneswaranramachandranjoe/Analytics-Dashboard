import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_dashboard/CUSTOM_WIDGETS/custom_text.dart';
import 'package:web_dashboard/DASHBOARD/bloc/dash_board_bloc.dart';
import 'package:web_dashboard/DASHBOARD/model/dash_board_model.dart';
import 'package:web_dashboard/DASHBOARD/repo/dash_board_repository.dart';

import '../../CONSTANT/constant.dart';

class DashBoardView extends StatelessWidget {
  DashBoardView({super.key});

  ValueNotifier<String?> selectedSite = ValueNotifier(null);
  ValueNotifier<String?> selectIndividual = ValueNotifier(null);
  ValueNotifier<String> selectDate = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashBoardBloc(
        dashBoardRepository: RepositoryProvider.of<DashBoardRepository>(
          context,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: SizedBox(),
          leadingWidth: 0,
          title: CustomText(
            txt: AppStrings.dashboardTitle,
            clr: Colors.white,
            size: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // DashboardFilterWidget(),
              RepositoryProvider(
                create: (context) => DashBoardRepository(),
                child: BlocProvider(
                  create: (context) =>
                      DashBoardBloc(
                          dashBoardRepository:
                              RepositoryProvider.of<DashBoardRepository>(
                                context,
                              ),
                        )
                        ..add(LoadChartData())
                        ..add(FilterChartData()),
                  child: BlocBuilder<DashBoardBloc, DashBoardState>(
                    builder: (context, state) {
                      if (state is DashBoardLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is DashBoardLoadedState) {
                        final sites = state.filterData
                            .map((e) => e.site)
                            .toSet()
                            .toList();
                        final individuals = state.filterData
                            .map((e) => e.individual)
                            .toSet()
                            .toList();

                        return Column(
                          children: [
                            LayoutBuilder(
                              builder: (context, constrains) {
                                return Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: buildDropdownButton(
                                        selectedSite,
                                        sites,
                                        false,
                                        (val) async {
                                          try {
                                            print("val $val");

                                            selectedSite.value = await val;
                                            print(selectedSite.value);
                                            if (selectedSite.value != null) {
                                              context.read<DashBoardBloc>().add(
                                                LoadChartData(
                                                  site: val,
                                                  individual:
                                                      selectIndividual.value ??
                                                      "",
                                                  date: selectDate.value ?? "",
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            print("e r in $e");
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: buildDropdownButton(
                                        selectIndividual,
                                        individuals,
                                        false,
                                        (val) {
                                          selectIndividual.value = val;
                                          if (selectIndividual.value != null) {
                                            context.read<DashBoardBloc>().add(
                                              LoadChartData(
                                                site: selectedSite.value ?? "",
                                                individual: val,
                                                date: selectDate.value ?? "",
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),

                                    buildDatePicker(selectDate, () {
                                      context.read<DashBoardBloc>()..add(
                                        LoadChartData(
                                          date: selectDate.value!,
                                          individual:
                                              selectIndividual.value ?? "",
                                          site: selectedSite.value ?? "",
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),

                            Container(
                              child: SfCartesianChart(
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePinching: true,
                                  enablePanning: true,
                                  zoomMode: ZoomMode.x,
                                ),

                                title: ChartTitle(
                                  text: 'Parameter A vs Time',
                                  textStyle: TextStyle(
                                    color: AppColors.txtGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                    text: 'Time',
                                    textStyle: TextStyle(
                                      color: AppColors.txtGrey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                    text: 'Parameter A',
                                    textStyle: TextStyle(
                                      color: AppColors.txtGrey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                series: [
                                  LineSeries<DashBoardModel, String>(
                                    color: AppColors.primaryColor,
                                    dataSource: state.dashBoardModel,

                                    xValueMapper: (row, index) =>
                                        row.time.toString(),
                                    yValueMapper: (row, _) =>
                                        double.tryParse(
                                          row.parameterA.toString(),
                                        ) ??
                                        0,
                                    markerSettings: const MarkerSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: SfCartesianChart(
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePinching: true,
                                  enablePanning: true,
                                  zoomMode: ZoomMode.x,
                                ),

                                title: ChartTitle(
                                  text: 'Parameter B vs Time',
                                  textStyle: TextStyle(
                                    color: AppColors.txtGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                    text: 'Time',
                                    textStyle: TextStyle(
                                      color: AppColors.txtGrey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                    text: 'Parameter B',
                                    textStyle: TextStyle(
                                      color: AppColors.txtGrey,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                series: [
                                  LineSeries<DashBoardModel, String>(
                                    color: AppColors.backgroundColor,
                                    dataSource: state.dashBoardModel,
                                    xValueMapper: (row, index) =>
                                        row.time.toString(),
                                    yValueMapper: (row, _) =>
                                        double.tryParse(
                                          row.parameterB.toString(),
                                        ) ??
                                        0,
                                    markerSettings: const MarkerSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return SizedBox(child: Text("sdfjladsjf"));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            DashBoardRepository().fetchData();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildDropdownButton(
    ValueNotifier<String?> valueLister,
    List<String?> sites,
    bool isMobile,
    Function(String)? action,
  ) {
    return ValueListenableBuilder<String?>(
      valueListenable: valueLister,
      builder: (context, value, child) {
        return DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.arrow_drop_down_outlined,
              color: AppColors.primaryColor,
            ),
            hintText: "Select",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: isMobile ? 14 : 16,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 12,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          hint: CustomText(txt: "Select Site", size: isMobile ? 14 : 16),
          items: sites.map((site) {
            return DropdownMenuItem<String>(
              value: site,
              child: CustomText(txt: site ?? "", size: isMobile ? 14 : 16),
            );
          }).toList(),
          onChanged: (val) {
            valueLister.value = val;
            action!(val ?? "");
          },
          // onChanged: (val) {
          //   valueLister.value = val!;
          //   action!();
          //
          //   // Trigger BLoC event here
          // },
        );
      },
    );
  }

  Widget buildDatePicker(
    ValueNotifier<String> selectedDate,
    Function()? action,
  ) {

    return ValueListenableBuilder(
      valueListenable: selectedDate,
      builder: (context, value, child) {
        return InkWell(
          onTap: () async {
            try {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                final formatted = DateFormat("yyyy-MM-dd").format(pickedDate);
                selectedDate.value = formatted.toString();
                action!();
              }
            } catch (e) {
              print("cat $e");
            }
          },
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              border: Border(bottom: BorderSide(
                color: AppColors.txtGrey
              )),
            ),
            width: 270,


            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    const Icon(Icons.calendar_today,color: AppColors.primaryColor,),
                    CustomText(txt: "${selectedDate.value}"),


                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
