/// Payment card model for linking bank cards
class PaymentCard {
  final String id;
  final String cardNumber; // masked: **** **** **** 1234
  final String cardHolder;
  final String expiryDate;
  final CardType cardType;
  final bool isDefault;

  const PaymentCard({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    this.cardType = CardType.uzcard,
    this.isDefault = false,
  });

  /// Masked card number for display
  String get maskedNumber {
    if (cardNumber.length < 4) return cardNumber;
    final last4 = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $last4';
  }

  /// Card type display name
  String get typeName {
    switch (cardType) {
      case CardType.uzcard:
        return 'UzCard';
      case CardType.humo:
        return 'HUMO';
      case CardType.visa:
        return 'Visa';
      case CardType.mastercard:
        return 'Mastercard';
    }
  }
}

enum CardType {
  uzcard,
  humo,
  visa,
  mastercard,
}

// 

// good luck everyone
