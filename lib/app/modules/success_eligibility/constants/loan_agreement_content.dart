class LoanAgreementContent {
  static const String pdfTitle = 'Loan Agreement';
  static const String previewTitle = 'Loan Agreement Terms';
  static const String shareText = 'Signed loan agreement PDF';
  static const String shareSubject = 'Loan Agreement';
  static const String footerNote =
      'This document was generated automatically after digital signature capture.';

  // Must-have agreement clauses. Edit these lines to customize PDF content.
  static const String clauseOfferAcceptance =
      'By signing this agreement, the customer accepts the loan offer, repayment schedule, fees, and privacy policy associated with this loan offer. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed nulla porttitor, accumsan purus sit amet, tempus nunc. Aliquam posuere rutrum egestas. Sed faucibus ullamcorper nisi at pulvinar. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed sit amet placerat lectus. Vestibulum a lorem viverra, fermentum dui fermentum, congue nunc. Fusce metus enim, aliquam at mollis et, elementum et nibh.\n\n';
  static const String clauseCopyAcknowledgement =
      'The customer acknowledges that a PDF copy of this agreement will be generated automatically after signing. Nullam vitae diam neque. Integer dignissim feugiat metus vitae rhoncus. Cras eu tristique lacus. Curabitur tempus massa at mauris cursus, in scelerisque enim venenatis. Morbi vel cursus leo. Maecenas fringilla gravida bibendum. Mauris vitae tincidunt lacus. Fusce vehicula mi efficitur dui vulputate, sed efficitur risus bibendum. Curabitur justo justo, facilisis nec metus ac, fermentum placerat ante. Integer sodales quam nisi, commodo pretium nisi scelerisque id. Morbi eget ex iaculis dolor tempor tristique. Pellentesque efficitur vulputate ligula vitae laoreet. Aliquam non enim non nibh luctus vehicula. Nullam porttitor in elit id varius.\n\n';
  static const String clauseDigitalConsent =
      'The customer consents to this digital signature process as a valid confirmation of agreement. Integer sit amet pretium nisi. Vivamus quis neque hendrerit metus pretium aliquet. Donec ultrices sem mauris, eu hendrerit justo accumsan eu. Mauris consequat laoreet odio. Nam rutrum, neque eget porttitor facilisis, nunc metus aliquam leo, at lobortis odio neque a erat. Nam quis fringilla orci. Sed ornare porttitor metus a scelerisque. Duis non blandit nulla. Suspendisse eget mi blandit, aliquet lectus eget, mollis justo. Etiam consectetur, ante eget feugiat porta, nisi mauris laoreet arcu, ut porttitor eros libero at lectus. Etiam a dapibus sem.\n\n';

  static const String bodyText =
      '$clauseOfferAcceptance $clauseCopyAcknowledgement $clauseDigitalConsent';
}
