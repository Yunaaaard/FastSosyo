import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoanReceiptPage extends StatelessWidget {
  const LoanReceiptPage({super.key});

  static const Color _pageBg = Color(0xFFD3D3D3);
  static const Color _primaryBlue = Color(0xFF2E5DC8);
  static const Color _labelText = Color(0xFF8C8F94);
  static const Color _valueText = Color(0xFF5F646A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.maxWidth;
            final double horizontalPadding = width * 0.055;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints areaConstraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: areaConstraints.maxHeight,
                            ),
                            child: Center(
                              child: _ReceiptCard(
                                width: width - (horizontalPadding * 2),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 26),
                  _BackToHomeButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((Route<dynamic> route) {
                        return route.isFirst;
                      });
                    },
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  const _ReceiptCard({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cardWidth = width.clamp(280.0, constraints.maxWidth);
        final double cardHeight = cardWidth * (478 / 320);
        final double scale = (cardWidth / 320).clamp(0.86, 1.0).toDouble();

        return Center(
          child: Container(
            width: cardWidth,
            height: cardHeight,
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(
                  'assets/icons/receipt-template.svg',
                  width: cardWidth,
                  height: cardHeight,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: -68 * scale,
                  child: Container(
                    width: 156 * scale,
                    height: 156 * scale,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x99C2DFFB),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/check-receipt-icon.svg',
                      width: 106 * scale,
                      height: 106 * scale,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      35 * scale,
                      125 * scale,
                      35 * scale,
                      50 * scale,
                    ),
                    child: Column(
                      children: [
                        _ReceiptHeaderSection(scale: scale),
                        const Spacer(),
                        _ReceiptDetailsSection(scale: scale),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReceiptHeaderSection extends StatelessWidget {
  const _ReceiptHeaderSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Thank you!',
          style: TextStyle(
            color: const Color(0xFF171B22),
            fontSize: 23 * scale,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),
        SizedBox(height: 10 * scale),
        Text(
          'Your payment has been sent\nsuccessfully',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF8A8D91),
            fontSize: 17 * scale,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _ReceiptDetailsSection extends StatelessWidget {
  const _ReceiptDetailsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ReceiptInfoRow(
          label: 'From:',
          value: 'Daven Reez Nemenzo',
        ),
        SizedBox(height: 24 * scale),
        const _ReceiptInfoRow(
          label: 'To:',
          value: 'Fast Sosyo Nestle',
        ),
        SizedBox(height: 24 * scale),
        const _ReceiptInfoRow(
          label: 'Ref No:',
          value: '1123 5093 2134 8893',
        ),
        SizedBox(height: 24 * scale),
        const _ReceiptInfoRow(
          label: 'Date:',
          value: '03-25-26 | 04:48',
        ),
        SizedBox(height: 34 * scale),
        Text(
          'Amount Sent',
          style: TextStyle(
            color: const Color(0xFF8F9398),
            fontSize: 18 * scale,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6 * scale),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '\u20B1 ',
                style: TextStyle(
                  color: LoanReceiptPage._primaryBlue,
                  fontSize: 40 * scale,
                  fontWeight: FontWeight.w700,
                  height: 1.08,
                ),
              ),
              TextSpan(
                text: '231,055.08',
                style: TextStyle(
                  color: LoanReceiptPage._primaryBlue,
                  fontSize: 35 * scale,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReceiptInfoRow extends StatelessWidget {
  const _ReceiptInfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              color: LoanReceiptPage._labelText,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: LoanReceiptPage._valueText,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _BackToHomeButton extends StatelessWidget {
  const _BackToHomeButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: LoanReceiptPage._primaryBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Back to Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
