using System;
using System.IO;
using Serilib.Parsers.Core;

namespace Serilib.Json.Validation.Impl
{
	public class NullLiteralValidator : BaseValidator, INullLiteralValidator
	{
		private String _value = "null";
		private StringParser _stringParser = new .() ~ delete _;

		public bool Validate(Stream stream, bool resetPos = true)
		{
			let pos = stream.Position;

			String _;
			var isValid = _stringParser.Parse(stream, _value, out _) case .Ok;
			delete _;

			if (isValid)
				return resetPos ? Success(stream, pos) : true;
			else
				return false;
		}
	}
}
