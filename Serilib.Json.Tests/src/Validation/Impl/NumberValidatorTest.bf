using System;
using System.Collections;
using System.IO;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class NumberValidatorTest
	{
		[Test]
		public static void Validate_WhenHasValidNumber_ReturnsTrue()
		{
			var numbers = scope List<String>() {
				"0",
				"12",
				"-1673",
				"32132.4321",
				"-878794.76234862",
				"132e45",
				"132e+45",
				"132e-45",
				"1.32e10",
				"1.32e+10",
				"1.32e-10",
				"-767e13",
				"-767e+13",
				"-767e-13",
				"-76.7e13",
				"-76.7e+13",
				"-76.7e-13"
			};

			for (let num in numbers)
				Validate_WhenHasValidNumber_ReturnsTrue(num);
		}

		private static void Validate_WhenHasValidNumber_ReturnsTrue(String value)
		{
			// Arrange
			var sut = scope NumberValidator();
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
		public static void Validate_WhenHasInvalidNumber_ReturnsFalse()
		{
			var numbers = scope List<String>() {
				"0ee",
				"12e-+",
				"--1673",
				"=32132.4321",
				"-878=794.76234862",
				"asdbahb",
				"12.3.4",
			};

			for (let num in numbers)
				Validate_WhenHasInvalidNumber_ReturnsFalse(num);
		}

		private static void Validate_WhenHasInvalidNumber_ReturnsFalse(String value)
		{
			// Arrange
			var sut = scope NumberValidator();
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
