import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/repository/compliment_repository.dart';

import '../../../components/connection_problecms_animation.dart';
import '../../../injector.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';

class ComplimentTab extends StatefulWidget {
  static const routeName = '/complimentPage';

  const ComplimentTab({Key? key}) : super(key: key);
  @override
  _ComplimentTabState createState() => _ComplimentTabState();
}

class _ComplimentTabState extends State<ComplimentTab> {
  final _user = GetIt.instance.get<User>();
  final _complimantRepository = GetIt.instance.get<ComplimantRepository>();
  String _complimentText = "";
  final String _cardTitle = "Check for compliment";

  void getCompliment() async {
    final date = DateTime.now();
    final complimentText =
        await _complimantRepository.getCompliment(_user.id, date, _user.sex);
    setState(() {
      _complimentText = complimentText;
    });
  }

  @override
  void initState() {
    super.initState();
    getCompliment();
  }

  final internetConnection = locator.get<InternetConnection>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: const Icon(Icons.emoji_emotions),
        title: const Text('My compliments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              getCompliment();
            },
          ),
        ],
      ),
      body: internetConnection.status
          ? AnimCard(
              null,
              const Color(0xffFF6594),
              _cardTitle,
              _complimentText,
            )
          : connectionProblemsAnimation(),
    );
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final String title;
  final String content;

  const AnimCard(
    Key? key,
    this.color,
    this.title,
    this.content,
  ) : super(key: key);

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 150.0;
  var bottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPadding(
            padding: EdgeInsets.only(top: padding, bottom: bottomPadding),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,
            child: CardItem(
              title: widget.title,
              color: widget.color,
              content: widget.content,
              onTap: () => {
                setState(() {
                  padding = padding == 0 ? 150.0 : 0.0;
                  bottomPadding = bottomPadding == 0 ? 150 : 0.0;
                }),
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                top: 200,
              ),
              height: 180,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                  ),
                ],
                color: Colors.grey.shade200.withOpacity(1.0),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: const Color(0xffFF6594).withOpacity(1.0),
                  size: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Color color;
  final String content;
  final String title;
  final VoidCallback onTap;

  const CardItem({
    Key? key,
    required this.title,
    required this.content,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: 220,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xffFF6594).withOpacity(0.2),
              blurRadius: 25,
            ),
          ],
          color: color.withOpacity(1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
