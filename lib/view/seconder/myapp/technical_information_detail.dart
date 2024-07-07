import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induktif/domain/logic/technical_info_detail/list_bloc.dart';
import 'package:induktif/view/seconder/post/post_item_detail.dart';
import 'package:induktif/view/seconder/post/post_loading.dart';
import 'package:induktif/view/seconder/post/post_second.dart';

class TechnicalInformationDetail extends StatelessWidget {
  final String? idUrl;
  final Map<String, String>? headers;
  final Map<String, String>? cookiesWeb;
  const TechnicalInformationDetail(
      {super.key, this.idUrl, this.headers, this.cookiesWeb});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechInfoDetBloc(TechInDetUninitialized())
        ..add(TechInDetEvent(
            idUrl: idUrl, headers: headers, cookiesWeb: cookiesWeb)),
      child: BlocBuilder<TechInfoDetBloc, TechInDetState>(
        builder: (context, state) {
          if (state is TechInDetUninitialized) {
            return const PostLoading();
          } else if (state is TechInDetSecond) {
            TechInDetSecond techInDetSecond = state;
            return BlocProvider(
              create: (context) => TechInfoDetBloc(TechInDetSecond())
                ..add(TechInDetEvent(
                    idUrl: idUrl, headers: headers, cookiesWeb: cookiesWeb)),
              child: BlocBuilder<TechInfoDetBloc, TechInDetState>(
                builder: (context, state) {
                  if (state is TechInDetSecond) {
                    return (techInDetSecond
                                .technicalModelDetail![0].detNomorTI ==
                            '0')
                        ? PostSecond(
                            technicalModelDetail:
                                techInDetSecond.technicalModelDetail![0],
                            content: Column(
                              children: [
                                techInDetSecond.pesan!,
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 20,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TechnicalInformationDetail(
                                                idUrl: idUrl,
                                                headers: headers,
                                                cookiesWeb: cookiesWeb,
                                              ),
                                            ));
                                      },
                                      child: const Text('Refresh')),
                                )
                              ],
                            ),
                          )
                        : PostSecond(
                            technicalModelDetail:
                                techInDetSecond.technicalModelDetail![0],
                            content: const Text('loading picture..'),
                          );
                  } else {
                    return PostItemDetail(
                      technicalModelDetail:
                          techInDetSecond.technicalModelDetail![0],
                    );
                  }
                },
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
