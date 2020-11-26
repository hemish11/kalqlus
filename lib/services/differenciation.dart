import 'dart:math';

class Differentiation {
  static String derivative(String func) {
    if (func.contains(')*(')) {
      String a = func.split(')*(')[0].split('(')[1];
      String b = func.split(')*(')[1].split(')')[0];

      func = sum(product(a, derivative(b)), product(derivative(a), b));
    } else if (func.contains(')/(')) {
      String a = func.split(')/(')[0].split('(')[1];
      String b = func.split(')/(')[1].split(')')[0];

      func = '(' + difference(product(derivative(a), b), product(a, derivative(b))) + ')/(' + product(b, b) + ')';
    } else if ((func.contains('+') || func.contains('-')) &&
        !(func.contains('ln') ||
            func.contains('log') ||
            func.contains('sin') ||
            func.contains('cos') ||
            func.contains('tan') ||
            func.contains('cot') ||
            func.contains('sec') ||
            func.contains('csc') ||
            func.contains('/-') ||
            func[0] == '-')) {
      func = sumRule(func);
    } else {
      if (func.contains('sin') ||
          func.contains('cos') ||
          func.contains('tan') ||
          func.contains('cot') ||
          func.contains('sec') ||
          func.contains('csc'))
        func = diffTrig(func);
      else if (func.contains('^x'))
        func = diffVarPow(func);
      else if (func.contains('ln') || func.contains('log'))
        func = diffLog(func);
      else
        func = diffPow(func);
    }

    return func;
  }

  static int hcf(int a, int b) {
    if (a == 0) return b;
    if (b == 0) return a;
    if (a == b) return a;
    if (a > b) return hcf(a - b, b);

    return hcf(a, b - a);
  }

  static String diffPow(String func) {
    if (func.contains('/') && func.split('/')[1].contains('x')) {
      String denominator = func.split('/')[1];
      String numerator = func.split('/')[0];

      if (!denominator.contains('^')) denominator += '^1';

      String base = denominator.split('^')[0];
      double pow = double.parse(denominator.split('^')[1] ?? 0);
      int a;
      int b;
      int c;

      a = int.parse(numerator) * pow.toInt();
      if (base.contains('*'))
        b = int.parse(base.split('*')[0]);
      else if (base.contains('-'))
        b = -1;
      else
        b = 1;

      c = hcf(a.abs(), b.abs());

      if (func[0] == '-' || b < 0) {
        func = '${a ~/ c}/${(b ~/ c).abs()}*x^${pow + 1}';
      } else {
        func = '-${a ~/ c}/${b ~/ c}*x^${pow + 1}';
      }
    } else {
      if (double.tryParse(func) != null) {
        func = '0';
      } else {
        if (!func.contains('^')) func += '^1';

        String base = func.split('^')[0];
        double pow = double.parse(func.split('^')[1] ?? 0);

        if (pow - 1 == 1)
          func = '$pow*$base';
        else if (pow - 1 == 0 && func.contains('*'))
          func = '${base.substring(0, base.length - 2)}';
        else if (pow - 1 == 0)
          func = pow.toString();
        else
          func = '$pow*$base^${pow - 1}';

        List<String> prodList = func.split('*');
        double prod = 1;

        for (int i = 0; i < prodList.length - 1; i++) prod *= double.parse(prodList[i]);

        func = prod == 1 ? prodList[prodList.length - 1] : '$prod*${prodList[prodList.length - 1]}';
      }
    }
    return func;
  }

  static String diffTrig(String func) {
    String angle = func.substring(func.indexOf('(') + 1, func.lastIndexOf(')'));
    String differentiateAngle = derivative(angle);

    if (double.tryParse(angle) != null) {
      func = '0';
    } else {
      if (!angle.contains('^')) angle += '^1';

      int power;

      if (func.contains('asin') ||
          func.contains('acos') ||
          func.contains('atan') ||
          func.contains('acot') ||
          func.contains('asec') ||
          func.contains('acsc')) power = (int.parse(angle.split('^')[1] ?? 1)) * 2;
      String base = angle.split('^')[0];

      if (func.contains('asin')) {
        func = '$differentiateAngle/sqrt(1-$base^$power)';
      } else if (func.contains('acos')) {
        func = '-' + '$differentiateAngle/sqrt(1-$base^$power)';
      } else if (func.contains('atan')) {
        func = '$differentiateAngle/($base^$power+1)';
      } else if (func.contains('acot')) {
        func = '-' + '$differentiateAngle/($base^$power+1)';
      } else if (func.contains('asec')) {
        func = '$differentiateAngle/|x|*sqrt(1-$base^$power)';
      } else if (func.contains('acsc')) {
        func = '-' + '$differentiateAngle/|x|*sqrt(1-$base^$power)';
      } else if (func.contains('sin')) {
        if (angle.contains('+') || angle.contains('-'))
          func = '($differentiateAngle)*cos($angle)';
        else
          func = '$differentiateAngle*cos($angle)';
      } else if (func.contains('cos')) {
        if (angle.contains('+') || angle.contains('-'))
          func = '-($differentiateAngle)*sin($angle)';
        else
          func = '-$differentiateAngle*sin($angle)';
      } else if (func.contains('tan')) {
        if (angle.contains('+') || angle.contains('-'))
          func = '(($differentiateAngle)*sec($angle))^2';
        else
          func = '($differentiateAngle*sec($angle))^2';
      } else if (func.contains('cot')) {
        if (angle.contains('+') || angle.contains('-'))
          func = '-(($differentiateAngle)*csc($angle))^2';
        else
          func = '-($differentiateAngle*csc($angle))^2';
      } else if (func.contains('sec')) {
        if (angle.contains('+') || angle.contains('-'))
          func = '($differentiateAngle)*sec($angle)*tan($angle)';
        else
          func = '$differentiateAngle*sec($angle)*tan($angle)';
      } else {
        if (angle.contains('+') || angle.contains('-'))
          func = '-($differentiateAngle)*csc($angle)*cot($angle)';
        else
          func = '-$differentiateAngle*csc($angle)*cot($angle)';
      }
    }

    if (func.substring(0, 4) == '-(1*') {
      func = func.replaceRange(2, 4, '');
    } else if (func.substring(0, 3) == '-1*' || func.substring(0, 3) == '-(*') {
      func = func.replaceRange(1, 3, '');
    } else if (func.substring(0, 2) == '1*') {
      func = func.replaceRange(0, 2, '');
    }

    return func;
  }

  static String diffLog(String func) {
    if (func.contains('ln')) {
      if (func.contains('+') || func.contains('-')) {
        String x = func.split('(')[1].split(')')[0];

        return derivative(x) + '/$x';
      } else {
        if (func.contains('^')) {
          String pow = func.split('^')[1].split(')')[0];

          return '$pow/x';
        }

        return '1/x';
      }
    } else {
      String base = func.replaceAll('log', '').split('(')[0];

      if (func.contains('+') || func.contains('-')) {
        String x = func.split('(')[1].split(')')[0];

        return derivative(x) + '/ln($base)*[$x]';
      } else {
        if (func.contains('^')) {
          String pow = func.split('^')[1].split(')')[0];

          return '$pow/x*ln($base)';
        }

        return '1/x*ln($base)';
      }
    }
  }

  static String diffVarPow(String func) {
    String base = func.split('^')[0];
    String pow = func.split('^')[1] ?? 1;

    if (base != 'e') {
      func = 'ln($base)*$base^$pow';
    }

    return func;
  }

  static int findDegree(String poly) {
    List<int> powers = List();
    int index = poly.indexOf('^');
    int degree;

    poly += ' ';

    if (!poly.contains('^') && poly.contains('x')) powers.add(1);
    if (!(poly.contains('^') && poly.contains('x'))) powers.add(0);

    while (poly.contains('^')) {
      int power;

      while ((int.tryParse(poly[index + 1]) != null) || poly[index + 1] == '.') index++;

      power = int.parse(poly.substring(poly.indexOf('^') + 1, index + 1));
      try {
        poly = poly.replaceAll('^${power.toInt()}', '');
      } catch (e) {
        poly = poly.replaceAll('^$power', '');
      }

      index = poly.indexOf('^');
      powers.add(power);
    }

    degree = powers[0];
    for (int i = 0; i < powers.length; i++) if (powers[i] > degree) degree = powers[i];

    return degree;
  }

  static List<double> coefficents(String poly) {
    int degree = findDegree(poly);
    List<double> coefficents = List();

    for (int i = 0; i <= degree; i++) {
      if (i == 0) {
        List<String> terms = poly.split('+');
        List<String> finalTerms = List();
        int constIndex;
        bool hasConstTerm = false;

        for (int i = 0; i < terms.length; i++) finalTerms.addAll(terms[i].split('-'));

        finalTerms.forEach((element) {
          if (!element.contains('x')) hasConstTerm = true;

          if (hasConstTerm) constIndex = finalTerms.indexOf(element);
        });

        if (hasConstTerm) {
          poly.lastIndexOf('-' + finalTerms[constIndex]) != -1
              ? coefficents.add(double.parse('-' + finalTerms[constIndex]))
              : coefficents.add(double.parse(finalTerms[constIndex]));
        } else {
          coefficents.add(0);
        }
      } else if (i == 1) {
        if (poly.contains('x-') || poly.contains('x+')) {
          int index = poly.lastIndexOf('x');

          if (index != 0) {
            if (poly[index - 1] != '*') {
              coefficents.add(1);
            } else {
              index = poly.lastIndexOf('*x');

              while ((double.tryParse(poly[index - 1]) != null) || poly[index - 1] == '.') {
                if (index == 1) {
                  index = 0;

                  break;
                } else {
                  index--;
                }
              }

              coefficents.add(double.parse(poly.substring(index, poly.lastIndexOf('*x'))));
            }
          } else
            coefficents.add(1);
        } else
          coefficents.add(0);
      } else {
        if (poly.contains('x^$i')) {
          int index = poly.lastIndexOf('x^$i');

          if (index == 0) {
            coefficents.add(1);
          } else if (poly[index - 1] != '*') {
            coefficents.add(1);
          } else {
            index = poly.lastIndexOf('*x^$i');

            while ((double.tryParse(poly[index - 1]) != null) || poly[index - 1] == '.') {
              if (index == 1) {
                break;
              } else {
                index--;
              }
            }

            coefficents.add(double.parse(poly.substring(index - 1, poly.lastIndexOf('*x^$i'))));
          }
        } else
          coefficents.add(0);
      }
    }

    return List.from(coefficents.reversed);
  }

  static String product(String poly1Str, String poly2Str) {
    List<double> poly1 = coefficents(poly1Str);
    List<double> poly2 = coefficents(poly2Str);

    List<double> prod = List(poly1.length + poly2.length - 1);

    prod.fillRange(0, prod.length, 0);

    for (int i = 0; i < poly1.length; i++) {
      for (int j = 0; j < poly2.length; j++) {
        prod[i + j] += poly1[i] * poly2[j];
      }
    }

    String sum = '';

    for (int i = prod.length - 1; i >= 0; i--) {
      sum += prod[prod.length - i - 1].toString();
      if (i != 0) sum += i == 1 ? '*x' : '*x^$i';

      if (i != 0) sum += (prod[prod.length - i] < 0 ? '' : "+");
    }

    return sum;
  }

  static String sum(String poly1Str, String poly2Str) {
    List<double> poly1 = coefficents(poly1Str);
    List<double> poly2 = coefficents(poly2Str);

    List<double> sum = List();

    poly1 = poly1.reversed.toList();
    poly2 = poly2.reversed.toList();

    while (poly1.length != poly2.length) {
      if (poly1.length > poly2.length)
        poly2.add(0);
      else
        poly1.add(0);
    }

    for (int i = max(poly1.length, poly2.length) - 1; i >= 0; i--) sum.add(poly1[i] + poly2[i]);

    String answer = '';

    for (int i = sum.length - 1; i >= 0; i--) {
      answer += sum[sum.length - i - 1].toString();
      if (i != 0) answer += i == 1 ? '*x' : '*x^$i';

      if (i != 0) answer += (sum[sum.length - i] < 0 ? '' : "+");
    }

    return answer;
  }

  static String difference(String poly1Str, String poly2Str) {
    List<double> poly1 = coefficents(poly1Str);
    List<double> poly2 = coefficents(poly2Str);

    List<double> sum = List();

    poly1 = poly1.reversed.toList();
    poly2 = poly2.reversed.toList();

    while (poly1.length != poly2.length) {
      if (poly1.length > poly2.length)
        poly2.add(0);
      else
        poly1.add(0);
    }

    for (int i = max(poly1.length, poly2.length) - 1; i >= 0; i--) sum.add(poly1[i] - poly2[i]);

    String answer = '';

    print(poly1.reversed);
    print(poly2.reversed);
    print(sum);

    for (int i = sum.length - 1; i >= 0; i--) {
      answer += sum[sum.length - i - 1].toString();
      if (i != 0) answer += i == 1 ? '*x' : '*x^$i';

      if (i != 0) answer += (sum[sum.length - i] < 0 ? '' : "+");
    }

    return answer;
  }

  static String sumRule(String func) {
    List<String> terms = func.split('+');
    List<String> finalTerms = List();
    List<String> diffTerms = List();
    List<String> operators = List();

    for (int i = 0; i < terms.length; i++) finalTerms.addAll(terms[i].split('-'));

    diffTerms = finalTerms
        .map((val) => Differentiation.derivative(val)
            .replaceAll('.0', '')
            .replaceAll('^1.0', '')
            .replaceAll('^1', '')
            .replaceAll('*1.0', '')
            .replaceAll('*1', '')
            .replaceAll('1.0*', '')
            .replaceAll('1*', '')
            .replaceAll('+0', '')
            .replaceAll('0+', ''))
        .toList();

    for (int i = 0; i < finalTerms.length - 1; i++) {
      operators.add(func.split(finalTerms[i])[1].split(finalTerms[i + 1])[0]);
    }

    func = diffTerms[0];

    for (int i = 0; i < operators.length; i++) {
      func += operators[i] + diffTerms[i + 1];
    }

    func = func.replaceAll('-0', '');
    func = func.replaceAll('+0', '');

    return func;
  }
}

//TODO: Make proper Sign operators
//TODO: Add ln formulas
