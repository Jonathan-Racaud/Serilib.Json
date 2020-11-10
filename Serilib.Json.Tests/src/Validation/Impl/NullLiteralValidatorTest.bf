using System;
using System.IO;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class NullLiteralValidatorTest
	{
		private static NullLiteralValidator _sut = new .() ~ delete _;

		[Test]
		public static void Validate_WhenHasValue_ReturnsTrue()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("null");
			stream.Position = 0;

			// Act
			var result = _sut.Validate(stream);

			// Assert
			Test.Assert(result == true);
		}

		[Test]
		public static void Validate_WhenHasWrongValue_ReturnsFalse()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("false");
			stream.Position = 0;

			// Act
			var result = _sut.Validate(stream);

			// Assert
			Test.Assert(result == false);
		}

		[Test]
		public static void Validate_WhenHasNoValue_ReturnsFalse()
		{
			// Arrange
			var stream = scope MemoryStream();

			// Act
			var result = _sut.Validate(stream);

			// Assert
			Test.Assert(result == false);
		}

		[Test]
		public static void ValidateWithValue_WhenHasValue_ReturnsTrue()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("null");
			stream.Position = 0;

			// Act
			var result = _sut.Validate(stream, "null");

			// Assert
			Test.Assert(result == true);
		}

		[Test]
		public static void ValidateWithValue_WhenWrongParameter_ReturnsFalse()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("null");
			stream.Position = 0;

			// Act
			var result = _sut.Validate(stream, "anything");

			// Assert
			Test.Assert(result == false);
		}

		[Test]
		public static void ValidateWithValue_WhenHasNoValue_ReturnsFalse()
		{
			// Arrange
			var stream = scope MemoryStream();

			// Act
			var result = _sut.Validate(stream, "null");

			// Assert
			Test.Assert(result == false);
		}

		[Test]
		public static void ValidateWithValue_WhenHasWrongValue_ReturnsFalse()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("false");
			stream.Position = 0;

			// Act
			var result = _sut.Validate(stream, "null");

			// Assert
			Test.Assert(result == false);
		}
	}
}
