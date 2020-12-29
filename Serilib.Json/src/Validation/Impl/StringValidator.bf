using System.IO;
using System;
using Serilib.Core.Parsers.Impl;

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

			while ((_charParser.Any(stream, out ch) case .Ok) && (ch != '"'))
				continue;

			if (ch != '"')
				return false;

			return resetPos ? Success(stream, pos) : true;
		}
	}
}
