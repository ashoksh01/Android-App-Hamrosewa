import 'package:flutter_test/flutter_test.dart';
import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/repository/productRepository.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/response/product_response.dart';

void main() {
  UserRepository? userRepository;

  group("test user register and login", () {
    setUp(() {
      userRepository = UserRepository();
    });

    test("user registration test", () async {
      bool expectedResult = true;
      User user = User(
          name: "test",
          email: "tengopggggo@gmail.com",
          password: "Nabin123456@",
          image:
              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAAsSAAALEgHS3X78AAAB3UlEQVRIx91Wu0rEQBTNw+ALexHMHWZc1Fq0sBGs/AAVwWZB9zu0E7SwFFsF7RU/QLdeH+CzWP0B3W/wzM6dZIzrZhO7DRzmJpOcc59JPK+vD0nCUzEZO4ZN5GtIvqawb+3Chya25FgDEKd7WphEkIgQlfHeek5BSkxKwxEyIoiuZIoMOVIlIXQN8ncN2HWgwuRBWXKf10HgBWk6APkACEOc70HgDfYop9AvXgMSIa9VENV/79MNCl/jKML/COzAwyMbDewhFjiGvcspLCEQJ12yjHR8uMVmsSaurdguK14D7nu2T0DyDNJ1YBX2I3DG3vuq6Cw4/e+ptF23IHSB80uI1LKD1vPAud5ISlsQBDPYW1M6iphms7PQk4gemGTAkiGiJZA2cK7b8sqAXoE7YPnHwJHIy3sSbsiCGyBvAdsdnKnivhaw6XadzBOxQ4NIKrA/Qb7IbakRGgguPs2D8AvrtB3Oqcm4e/5tT8M+xYOHTBR1iDbidR/PnPMzYW4NeB0GHuApey8inecMIt5bgOdPkgewa6HTN6gYgX2LdDSVWe//QEPfI00TjLnvsNw2xY3j7RzHNJcD1IEmsi3e8yyUGc6uKXIi0J/HQL+D9HdBdUD7utn3nSbpsx+Hb2C9ep0rImHOAAAAAElFTkSuQmCC");
      bool actial = await userRepository!.registerUser(user);
      expect(actial, expectedResult);
    });

    tearDown(() {
      userRepository = null;
    });

    test("user login test", () async {
      bool expectedResult = true;

      String email = "baba@gmail.com";
      String password = "Baba1412914@";

      bool actial = await UserRepository().login(email, password);

      expect(actial, expectedResult);
    });

    test("user product review test", () async {
      bool expectedResult = true;

      String productId = "62d506544b36b2f220bebc70";
      String comment = "baba@gmail.com";
      int rating = 2;

      bool actial =
          await ProductRepository().givereview(productId, comment, rating);

      expect(actial, expectedResult);
    });

    test("user change password", () async {
      bool expectedResult = true;

      String oldPassword = "Baba1412914@";
      String newPassword = "Baba1412914@";
      String confirmPassword = "Baba1412914@";

      bool actial = await UserRepository()
          .userchangePassword(oldPassword, newPassword, confirmPassword);
      expect(actial, expectedResult);
    });

    test("get all product", () async {
      ProductResponse? actial = await ProductRepository().getproduct();
      expect(actial, isNotNull);
    });
  });
}
