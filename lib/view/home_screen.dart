import 'package:eldeep/view_model/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.red,
                title: const Text('Assignment '),

              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.topStart,
                                  child: TextFormField(
                                    controller: cubit.textController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('enter text'),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.addText();
                                  },
                                  child: const Text('add Text'),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              DropdownMenu(
                                dropdownMenuEntries: [
                                  for (String fontFamily in cubit.fontFamilies)
                                    DropdownMenuEntry(
                                        value: fontFamily, label: fontFamily),
                                ],
                                label: const Text('font'),
                                onSelected: (value){
                                  cubit.selectedFont=value!;
                                },
                                initialSelection: cubit.selectedFont,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      const Text('Size'),
                                      Row(
                                        children: [
                                          Text(
                                            '${cubit.size}',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  cubit.increaseSize();
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_upward_outlined),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    cubit.decreaseSize();
                                                  },
                                                  icon: const Icon(Icons
                                                      .arrow_downward_outlined)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text('Color'),
                                      MaterialButton(
                                        height: 50,
                                        elevation: 14,
                                        onPressed: () {
                                          cubit.pickColor(context);
                                        },
                                        color: cubit.color,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child:cubit.inputTextList.isEmpty? const Center(
                        child: Text(
                          'there\'s no text yet'
                        ),
                      ): ListView.builder(itemBuilder:(context, index) {
                        return cubit.buildListView(index);
                      },
                      itemCount: cubit.inputTextList.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
