using System;
using System.Collections;
using System.IO;
using Serilib.Json.Validation.Impl;
using Serilib.Json.Tests.Validation.Mock;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class ObjectValidatorTest
	{
		[Test]
		public static void Validate_WhenHasValidObject_ReturnsTrue()
		{
			let objects = scope List<String>() {
				"{}",
				"{\"key\": \"value\", \"anotherKey\": 123e-5, \"object\": {}, \"array\": []}"
			};

			for (let str in objects)
				Validate_WhenHasValidObject_ReturnsTrue(str);
		}

		private static void Validate_WhenHasValidObject_ReturnsTrue(String value)
		{
			// Arrange
			var sut = scope ObjectValidator(
				scope ArrayValidatorMock(),
				scope StringValidator(),
				scope NumberValidator(),
				scope TrueLiteralValidator(),
				scope FalseLiteralValidator(),
				scope NullLiteralValidator());
			var stream = scope MemoryStream();
			stream.Write(value);
			stream.Position = 0;

			// Act
			var result = sut.Validate(stream);

			// Assert
			Test.Assert(result == true);
			Test.Assert(stream.Position == 0);
		}

		/*[Test]
		public static void Validate_WhenHasInvalidString_ReturnsFalse()
		{
			let strings = scope List<String>() {
				"",
				"\"",
				"\"duihwehdwe"
			};

			for (let str in strings)
				Validate_WhenHasInvalidString_ReturnsFalse(str);
		}

		private static void Validate_WhenHasInvalidString_ReturnsFalse(String value)
		{
			// Arrange
			var sut = scope StringValidator();
			var stream = scope MemoryStream();
			stream.Write(value);
			stream.Position = 0;

			// Act
			var result = sut.Validate(stream);

			// Assert
			Test.Assert(result == false);
			Test.Assert(stream.Position == 0);
		}*/
	}
}
