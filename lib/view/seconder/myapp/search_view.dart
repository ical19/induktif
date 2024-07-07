import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/logic/searching_tab/search_bloc.dart';
import 'package:induktif/view/seconder/post/search_result.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController inputTextController = TextEditingController();
  String inputText = "";
  late BuildContext pencarianContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      color: InduktifTheme.spacer,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + 25,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.01),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextFormField(
                    controller: inputTextController,
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty
                            ? inputText = value
                            : inputText = inputTextController.text;
                      });
                    },
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      pencarianContext
                          .read<SearchingBloc>()
                          .add(SearchEvent(keyWord: value));
                    },
                    cursorHeight: 25,
                    cursorColor: InduktifTheme.dark_grey,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(
                            color: InduktifTheme.dark_grey,
                            fontFamily: "Roboto"),
                        filled: true,
                        fillColor: InduktifTheme.nearlyWhite,
                        hintText: ''),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(InduktifTheme.dark_grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                        fontSize: 16, color: InduktifTheme.nearlyBlack),
                  )),
            ),
          ],
        ),
        BlocProvider(
            create: (context) => SearchingBloc(),
            child: BlocBuilder<SearchingBloc, SearchState>(
                builder: (context, state) {
              if (state is SearchStarting) {
                pencarianContext = context;
                return inputText.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Material(
                          child: ListTile(
                            tileColor: InduktifTheme.spacer,
                            leading: inputText.isNotEmpty
                                ? const Icon(Icons.search_rounded)
                                : const SizedBox(),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<SearchingBloc>()
                                  .add(SearchEvent(keyWord: inputText));
                            },
                            title: Text(
                              'Cari $inputText',
                              style: InduktifTheme.display1.copyWith(
                                  color: InduktifTheme.nearlyBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              } else {
                SearchLoaded searchLoaded = state as SearchLoaded;
                pencarianContext = context;

                return Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: searchLoaded.searchingModel!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            inputText.isNotEmpty && index == 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Material(
                                      child: ListTile(
                                        tileColor: InduktifTheme.spacer,
                                        leading: inputText.isNotEmpty
                                            ? const Icon(Icons.search_rounded)
                                            : const SizedBox(),
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          context.read<SearchingBloc>().add(
                                              SearchEvent(keyWord: inputText));
                                        },
                                        title: Text(
                                          'Cari $inputText',
                                          style: InduktifTheme.display1
                                              .copyWith(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            index == 0
                                ? Material(
                                    color: InduktifTheme.spacer,
                                    child: ListTile(
                                      title: Text(searchLoaded
                                                  .searchingModel![0]
                                                  .idLinkJudul ==
                                              "empty"
                                          ? "Sedang memuat ..."
                                          : 'Hasil pencarian : ${searchLoaded.searchingModel!.length} item'),
                                    ),
                                  )
                                : const SizedBox(),
                            searchLoaded.searchingModel![0].idLinkJudul ==
                                    "empty"
                                ? searchLoaded.pesan!
                                : SearchResult(
                                    nomorUrut: index + 1,
                                    model: searchLoaded.searchingModel![index],
                                  ),
                          ],
                        );
                      }),
                );
              }
            })),
      ]),
    );
  }
}

class SearchChoice extends StatefulWidget {
  final String? label;
  const SearchChoice({super.key, this.label});

  @override
  State<SearchChoice> createState() => _SearchChoiceState();
}

class _SearchChoiceState extends State<SearchChoice> {
  bool checked = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );

    return Theme(
      data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(widget.label!),
        onChanged: (_) {
          setState(() {
            checked = !checked;
          });
        },
        checkColor: InduktifTheme.nearlyWhite,
        activeColor: Colors.green,
        value: checked,
      ),
    );
  }
}
