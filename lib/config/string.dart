const appName = "SETTHI";
const descriptionText =
    "Application to help you manage manage your expenses and transactions in your daily life and also allow you to split your money by the purpose.";
const forgetText = "Forget password ?";
const suggestRegisterQuestion = "New here ? ";
const suggestRegisterText = "Create Account";
const suggestSigninQuestion = "Already have an account ? ";
const suggestSigninText = "Sign In";
const createWalletText = "Create a new wallet";
const createBudgetText = "Create a new budget";
const noBudgetText = "No budget now :(";

const authenticateException = "Please login.";
const internetException = "Please check your internet connection.";
const generalException = "Something went wrong. Please try again later.";
const incorrectAuthException = "Your email or password is incorrect.";
String invalidException(type) {
  return "The $type is invalid.";
}

const usedEmailException = "This email is already used.";
String overLimitException(String type, int number) {
  return "You can't have more than $number $type";
}

String atleastException(String type) {
  return "You need to have at least 1 $type";
}
