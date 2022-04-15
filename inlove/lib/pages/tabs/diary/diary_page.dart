import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/memory_model.dart';
import 'memory/memory_page.dart';

Widget searchBar(BuildContext context) {
  double _w = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.fromLTRB(_w / 20, _w / 25, _w / 20, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: _w / 8.5,
          width: _w / 1.36,
          padding: EdgeInsets.symmetric(horizontal: _w / 60),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(99),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(.4),
                  fontWeight: FontWeight.w600,
                  fontSize: _w / 22),
              prefixIcon:
                  Icon(Icons.search, color: Colors.black.withOpacity(.6)),
              hintText: 'Search anything.....',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    ),
  );
}

List<Memory> destinations(BuildContext context) => [
      Memory(
        id: 1,
        coupleId: 1,
        title: 'title',
        description: 'description',
        date: DateTime.now(),
        location: 'location',
        photosId: <int>[],
      ),
      Memory(
        id: 1,
        coupleId: 1,
        title: 'title',
        description: 'description',
        date: DateTime.now(),
        location: 'location',
        photosId: <int>[],
      ),
      Memory(
        id: 1,
        coupleId: 1,
        title: 'title',
        description: 'description',
        date: DateTime.now(),
        location: 'location',
        photosId: <int>[],
      ),
    ];

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    Key? key,
    required this.memory,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final Memory memory;
  final bool isSelected;
  final VoidCallback onSelected;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 340.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(title: 'selectable title'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {},
                  onLongPress: () {
                    onSelected();
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        color: isSelected
                            // Generally, material cards use primary with 8% opacity for the selected state.
                            // See: https://material.io/design/interaction/states.html#anatomy
                            ? colorScheme.primary.withOpacity(0.08)
                            : Colors.transparent,
                      ),
                      TravelDestinationContent(memory: memory),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle,
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({Key? key, required this.memory})
      : super(key: key);

  final Memory memory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as
                // part of the Material and display ink effects above it. Using
                // a standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(
                    memory.photosId.first.toString(),
                  ),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    memory.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    memory.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(memory.date.toString()),
                Text(memory.location),
              ],
            ),
          ),
        ),
        // share, explore buttons
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('demoMenuShare',
                  semanticsLabel: 'cardsDemoShareSemantics'),
            ),
          ],
        ),
      ],
    );
  }
}

class DiaryTab extends StatefulWidget {
  const DiaryTab({Key? key}) : super(key: key);

  @override
  _DiaryTabState createState() => _DiaryTabState();
}

class _DiaryTabState extends State<DiaryTab> with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards_demo';

  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }

  @override
  void dispose() {
    _isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: searchBar(context),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                restorationId: 'cards_demo_list_view',
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                children: [
                  for (final destination in destinations(context))
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: SelectableTravelDestinationItem(
                        memory: destination,
                        isSelected: _isSelected.value,
                        onSelected: () {
                          setState(() {
                            _isSelected.value = !_isSelected.value;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            MemoryConstructor.routeName,
          );
        },
      ),
    );
  }
}
