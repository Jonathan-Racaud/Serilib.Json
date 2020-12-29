using System;
using System.Collections;
using System.IO;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Tests.Validation.Impl
{
	public class JsonValidatorTest
	{
		[Test]
		public static void Validate_WhenHasValidJson_ReturnsTrue()
		{
			let values = scope List<String>() {
				"[]",
				"{}",
				"[{}]",
				"false",
				"true",
				"null",
				"\"a string\"",
				"42.05e-34",
				"[\"key\", null, true, 123e-5, false, {}, []]",
				"{\"key\": null, \"another\": true, \"number\":                 123e-5, \"false\":     false, \"object\": {\r\n\t\"key\": null,   \r\n     \t \"another\": true, \"number\":                 123e-5, \"false\":     false, \"object\": {}}, \"array\": [ [\"key\", null, true, 123e-5, false, {}, []]]}"
			};

			for (let str in values)
				Validate_WhenHasValidValues_ReturnsTrue(str);
		}

		private static void Validate_WhenHasValidValues_ReturnsTrue(String value)
		{
			// Arrange
			var sut = scope JsonValidator();
			var stream = scope MemoryStream();
			stream.Write(value);
			stream.Position = 0;

			// Act
			var result = sut.Validate(stream);

			// Assert
			Test.Assert(result == true);
			Test.Assert(stream.Position == 0);
		}
	}
}
