using System;
using System.IO;
using Serilib.Core.Parsers.Impl;

namespace Serilib.Json.Validation.Impl
{
	public class TrueLiteralValidator : BaseValidator, ITrueLiteralValidator
	{
		private String _value = "true";
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
