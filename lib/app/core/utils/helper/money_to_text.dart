class MoneyToText{

  MoneyToText();

  static var numericWord = {
    '21': 'একুশ',
    '22': 'বাইশ',
    '23': 'তেইশ',
    '24': 'চব্বিশ',
    '25': 'পঁচিশ',
    '26': 'ছাব্বিশ',
    '27': 'সাতাশ',
    '28': 'আঠাশ',
    '29': 'ঊনত্রিশ',
    '30': 'ত্রিশ',
    '31': 'একত্রিশ',
    '32': 'বত্রিশ',
    '33': 'তেত্রিশ',
    '34': 'চৌত্রিশ',
    '35': 'পঁয়ত্রিশ',
    '36': 'ছত্রিশ',
    '37': 'সাঁইত্রিশ',
    '38': 'আটত্রিশ',
    '39': 'ঊনচল্লিশ',
    '40': 'চল্লিশ',
    '41': 'একচল্লিশ',
    '42': 'বিয়াল্লিশ',
    '43': 'তেতাল্লিশ',
    '44': 'চুয়াল্লিশ',
    '45': 'পঁয়তাল্লিশ',
    '46': 'ছেচল্লিশ',
    '47': 'সাতচল্লিশ',
    '48': 'আটচল্লিশ',
    '49': 'ঊনপঞ্চাশ',
    '50': 'পঞ্চাশ',
    '51': 'একান্ন',
    '52': 'বায়ান্ন',
    '53': 'তিপ্পান্ন',
    '54': 'চুয়ান্ন',
    '55': 'পঞ্চান্ন',
    '56': 'ছাপ্পান্ন',
    '57': 'সাতান্ন',
    '58': 'আটান্ন',
    '59': 'ঊনষাট',
    '60': 'ষাট',
    '61': 'একষট্টি',
    '62': 'বাষট্টি',
    '63': 'তেষট্টি',
    '64': 'চৌষট্টি',
    '65': 'পঁয়ষট্টি',
    '66': 'ছেষট্টি',
    '67': 'সাতষট্টি',
    '68': 'আটষট্টি',
    '69': 'ঊনসত্তর',
    '70': 'সত্তর',
    '71': 'একাত্তর',
    '72': 'বাহাত্তর',
    '73': 'তিয়াত্তর',
    '74': 'চুয়াত্তর',
    '75': 'পঁচাত্তর',
    '76': 'ছিয়াত্তর',
    '77': 'সাতাত্তর',
    '78': 'আটাত্তর',
    '79': 'ঊনআশি',
    '80': 'আশি',
    '81': 'একাশি',
    '82': 'বিরাশি',
    '83': 'তিরাশি',
    '84': 'চুরাশি',
    '85': 'পঁচাশি',
    '86': 'ছিয়াশি',
    '87': 'সাতাশি',
    '88': 'আটাশি',
    '89': 'ঊননব্বই',
    '90': 'নব্বই',
    '91': 'একানব্বই',
    '92': 'বিরানব্বই',
    '93': 'তিরানব্বই',
    '94': 'চুরানব্বই',
    '95': 'পঁচানব্বই',
    '96': 'ছিয়ানব্বই',
    '97': 'সাতানব্বই',
    '98': 'আটানব্বই',
    '99': 'নিরানব্বই',
  };

// Main function to convert money to words in English or Bengali based on language
  static String moneyToWordsBDT(double amount, String language) {
    int taka = amount.floor(); // Whole number part (Taka)
    int poisha = ((amount - taka) * 100).round(); // Fractional part (Poisha)

    String lang = language.toUpperCase();

    // Convert Taka and Poisha separately
    String takaInWords = convertNumberToWords(taka, lang);



    String poishaInWords = poisha > 0 ? (lang == 'BN' ? 'এবং ' : 'and ') + convertNumberToWords(poisha, lang) + (lang == 'BN' ? ' পয়সা' : ' poisha') : '';

    return takaInWords + (lang == 'BN' ? ' টাকা মাত্র ' : ' taka only ') + poishaInWords;
  }

// Function to convert numbers to words in English or Bengali
  static String convertNumberToWords(int num, String language) {

    String lang = language.toUpperCase();

    if (num == 0) return lang == 'BN' ? 'শূন্য' : 'zero';

    List<String> units = lang == 'BN' ? ['', 'হাজার', 'লক্ষ', 'কোটি'] : ['', 'thousand', 'lakh', 'crore'];
    List<int> divisors = [1, 1000, 100000, 10000000]; // Thousands, Lakhs, Crores

    List<String> parts = [];

    for (int i = divisors.length - 1; i >= 0; i--) {
      int divisor = divisors[i];
      int quotient = num ~/ divisor;
      if (quotient > 0) {
        parts.add(numberToWordsBelow1000(quotient, lang) + ' ' + units[i]);
        num = num % divisor; // Reduce the remaining part
      }
    }

    return parts.join(' ').trim();
  }

// Function to convert numbers below 1000 to words in English or Bengali
  static String numberToWordsBelow1000(int num, String language) {

    String lang = language.toUpperCase();

    List<String> belowTwenty = lang == 'BN'
        ? ['', 'এক', 'দুই', 'তিন', 'চার', 'পাঁচ', 'ছয়', 'সাত', 'আট', 'নয়', 'দশ', 'এগারো', 'বারো', 'তেরো', 'চৌদ্দ', 'পনেরো', 'ষোল', 'সতেরো', 'আঠারো', 'উনিশ']
        : ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'];

    List<String> tens = lang == 'BN'
        ? ['', '', 'কুড়ি', 'ত্রিশ', 'চল্লিশ', 'পঞ্চাশ', 'ষাট', 'সত্তর', 'আশি', 'নব্বই']
        : ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

    if (num < 20) {
      return belowTwenty[num];
    } else if (num > 20 && num <= 99 && lang == "BN") {
      return numericWord[num.toString()].toString();
    }else if (num < 100) {
      return tens[num ~/ 10] + (num % 10 != 0 ? '-${belowTwenty[num % 10]}' : '');
    }  else {
      return belowTwenty[num ~/ 100] + (lang == 'BN' ? 'শত' : ' hundred') + (num % 100 != 0 ? '${lang == 'BN' ? ' ' : ' and '}' + numberToWordsBelow1000(num % 100, lang) : '');
    }
  }

}