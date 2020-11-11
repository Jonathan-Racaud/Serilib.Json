using System;
using System.Collections;
using System.IO;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class StringValidatorTest
	{
		[Test]
		public static void Validate_WhenHasValidString_ReturnsTrue()
		{
			let strings = scope List<String>() {
				"\"Hello world, this is a valid JSON String\"",
				"\"u{32}Hello4896548*/-/[]\\[;\',/.\\n\r\twqw\""
			};

			for (let str in strings)
				Validate_WhenHasValidString_ReturnsTrue(str);
		}

		private static void Validate_WhenHasValidString_ReturnsTrue(String value)
		{
			// Arrange
			var sut = scope StringValidator();
			var stream = scope MemoryStream();
			stream.Write(value);
			stream.Position = 0;

			// Act
			var result = sut.Validate(stream);

			// Assert
			Test.Assert(result == true);
			Test.Assert(stream.Position == 0);
		}

		[Test]
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
		}
	}
}
