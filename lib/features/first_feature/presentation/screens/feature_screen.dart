import 'package:e_chat/features/first_feature/presentation/manager/cat_fact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CatFactCubit>(),
      child: BlocBuilder<CatFactCubit, CatFactState>(
        builder: (context, state) {
          final CatFactCubit catFactCubit = CatFactCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (state is CatFactErrorState) ...[
                    Text(
                      state.errMsg,
                    ),
                  ] else if (state is CatFactSuccessState) ...[
                    Text(
                      state.catFactEntity.fact,
                    ),
                    Text(
                      state.catFactEntity.length.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ] else
                    ...[]
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                catFactCubit.getCatFact();
              },
              tooltip: 'try',
              child: const Icon(Icons.search),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
