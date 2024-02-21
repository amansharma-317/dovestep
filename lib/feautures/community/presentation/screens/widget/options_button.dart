import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/community_providers.dart';

class HorizontalScrollButtons extends ConsumerStatefulWidget {
  const HorizontalScrollButtons({Key? key}) : super(key: key);

  @override
  ConsumerState<HorizontalScrollButtons> createState() =>
      _HorizontalScrollButtonsState();
}

class _HorizontalScrollButtonsState
    extends ConsumerState<HorizontalScrollButtons> {
  final _buttonNames = [
    "All",
    'Anxiety',
    'Depression',
    'Stress',
    'Relationships',
    'Trauma',
    'Addiction',
    'Self-esteem',
    'Loneliness',
  ];
  String _selectedButton = 'All';

  @override
  Widget build(BuildContext context) {
    final selectedButtonProvider = ref.watch(selectedCommunitySectionProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buttonNames
            .map(
              (name) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 104,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(selectedCommunitySectionProvider.notifier).state = name;
                  ref.refresh(communityProvider);
                },
                child: Text(name,style: TextStyle( fontFamily: GoogleFonts.epilogue().fontFamily,fontWeight: FontWeight.w700,fontSize: 12),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: selectedButtonProvider == name
                      ? Color(0xFF112E06)
                      : Color(0xFF98B88B),
                  foregroundColor: selectedButtonProvider == name ? Color(0xFFF4F0F0) : Color(0xFF121212),
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
