class Equation {
  static String equation = '';
  static String diffEquation = '';
  static String intEquation = '';

  static String toLatex(String equation) {
    if (!(equation.contains('sin') ||
        equation.contains('cos') ||
        equation.contains('tan') ||
        equation.contains('cot') ||
        equation.contains('sec') ||
        equation.contains('csc')))
      return equation.replaceAll(')/(', '}{').replaceAll('(', '\\frac{').replaceAll(')', '}');
      else return equation;
  }
}
