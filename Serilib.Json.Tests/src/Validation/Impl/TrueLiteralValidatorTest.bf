using System;
using System.IO;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class TrueLiteralValidatorTest
	{
		private static TrueLiteralValidator _sut = new .() ~ delete _;

		[Test]
		public static void Validate_WhenHasValue_ReturnsTrue()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("true");
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
			stream.Write("anything");
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
	}
}
