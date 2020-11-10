using System.IO;
using System;
using Serilib.Parsers.Core;

namespace Serilib.Json.Validation.Impl
{
	public class StringValidator: BaseValidator, IStringValidator
	{
		private CharParser _charParser = new .() ~ delete _;
		private StringParser _stringParser = new .() ~ delete _;

		public bool Validate(Stream stream, bool resetPos = true)
		{
			let pos = stream.Position;

			char8 ch;
			if (_charParser.Parse(stream, '"', out ch) case .Err)
				return false;

			/*String str;
			if (_stringParser.Any(stream, out str) case .Err)
				return false;*/

			while ((_charParser.Any(stream, out ch) case .Ok) && (ch != '"'))
				continue;

			/*if (str.Length > 1)
				ch = str[str.Length - 1];
			else
				ch = default;

			delete str;*/

			if (ch != '"')
				return false;

			return resetPos ? Success(stream, pos) : true;
		}
	}
}
