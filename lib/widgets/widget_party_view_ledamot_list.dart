import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/provider_ledamot.dart';

import '../models/model_party_view_ledamot.dart';
import '../models/model_party_view_ledamotresult.dart';
import '../provider/provider_party_view.dart';
import '../theme/theme.dart';
import '../screens/ledamot_view.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
    required this.ledamotList,
  });

  final List<LedamotResult> ledamotList;

  @override
  Widget build(BuildContext context) {
    final List<LedamotResult> ledamotList =
        context.watch<ProviderPartyView>().ledamotResultList;

    final itemCount = ledamotList.length;

    return ListView.builder(
      itemBuilder: (context, index) {
        return LedamotItem(ledamotList[index]);
      },
      itemCount: itemCount,
      shrinkWrap: true,
      physics: ScrollPhysics(),
    );
  }
}

class LedamotItem extends StatelessWidget {
  // Widget to build list of ledamöter in party_view.dart depending
  // on what party is selected from infovy.dart

  final LedamotResult ledamot;

  LedamotItem(
    this.ledamot, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProviderPartyView providerPartyView = context.watch<ProviderPartyView>();
    //final String fullName = '${ledamot.tilltalsnamn} ${ledamot.efternamn}';
    final Ledamot ledamotImage =
        providerPartyView.findLedamotByIntressentId(ledamot.intressentId);

    final String imageUrl = ledamotImage.bildUrl80;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
        child: GestureDetector(
          // Set iid for provider_ledamot and jump to page LedamotVy
          onTap: () {
            context.read<ProviderLedamot>().setIid(ledamot.intressentId);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LedamotView()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              border: Border.all(
                color: AppColors.yellow, // Outline color
                width: 2.0, // Outline width
              ),
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    ledamot.namn,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.circle,
                            color: getVoteColor(ledamot.vote)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Color getVoteColor(String vote) {
  // Customize this function based on your specific logic
  if (vote == 'Ja') {
    return AppColors.green;
  } else if (vote == 'Nej') {
    return AppColors.red;
  } else if (vote == 'Avstår') {
    return AppColors.yellow; // Default color for other cases
  } else if (vote == 'Frånvarande') {
    return AppColors.blue;
  } else {
    return AppColors.black;
  }
}
