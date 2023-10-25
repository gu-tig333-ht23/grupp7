import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider_party_view.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _textEditingController,
        onChanged: (searchTerm) {
          context
              .read<ProviderPartyView>()
              .searchLedamot(_textEditingController.text);
        },
        decoration: InputDecoration(
            labelText: "  Sök ledamot",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //
            ),
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 4) //
            ),
      ),
    );
  }
}
