using System;
using System.IO;
using Serilib.Json.Parser.Impl;

namespace Serilib.Json.Tests.Parser.Impl
{
	public class JsonFalseParserTest
	{
		[Test]
		public static void Parse_WhenCalled_ReturnsOk()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("false");
			stream.Position = 0;

			var sut = scope JsonFalseParser();

			// Act
			var result = sut.Parse(stream);

			// Assert
			Test.Assert(result == .Ok);
		}

		[Test]
		public static void Parse_WhenWrongValue_ReturnsError()
		{
			// Arrange
			var stream = scope MemoryStream();
			stream.Write("null");
			stream.Position = 0;

			var sut = scope JsonFalseParser();

			// Act
			var result = sut.Parse(stream);

			// Assert
			Test.Assert(result == .Err(.ValueNotFound));
		}
	}
}
