using System;
using System.IO;
using Serilib.Core.Parsers;
using Serilib.Core.Parsers.Impl;

namespace Serilib.Json.Parser.Impl
{
	abstract class BaseLiteralParser
	{
		protected String _value;
		private StringParser _stringParser = new .() ~ delete _;

		public Result<void, ParseErrors> Parse(Stream stream)
		{
			String str;
			if (_stringParser.Parse(stream, _value, out str) case .Err)
				return .Err(.ValueNotFound);
			delete str;

			return .Ok;
		}
	}
}
