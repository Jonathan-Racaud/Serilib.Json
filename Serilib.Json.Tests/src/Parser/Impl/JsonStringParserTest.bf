using System;
using System.Collections;
using System.IO;
using Serilib.Json.Parser.Impl;

namespace Serilib.Json.Tests.Parser.Impl
{
	public class JsonStringParserTest
	{
		[Test]
		public static void Parse_WhenCalledWithGoodValue_ReturnsOkAndObjectSet()
		{
			let strings = scope List<String>() {
				"Hello world, this is a valid JSON String",
				"u{32}Hello4896\\\"548*/-/[];\',/.\\n\r\twqw"
			};

			for (let str in strings)
			{
				let formatted = scope String();
				formatted.AppendF("\"{}\"", str);
				Parse_WhenCalledWithGoodValue_ReturnsOkAndObjectSet(formatted, str);
			}
		}

		private static void Parse_WhenCalledWithGoodValue_ReturnsOkAndObjectSet(String value, String expectedString)
		{
			// Arrange
			let stream = scope MemoryStream();
			stream.Write(value);
			stream.Position = 0;

			String dest;

			let sut = scope JsonStringParser();

			// Act
			let result = sut.Parse(stream, out dest);

			// Assert
			Test.Assert(result == .Ok);
			Test.Assert(dest.Equals(expectedString));

			delete dest;
		}
	}
}
