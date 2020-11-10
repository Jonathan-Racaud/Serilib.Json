using System.IO;
using System;
using Serilib.Parsers.Core;

namespace Serilib.Json.Validation.Impl
{
	public class NumberValidator : BaseValidator, INumberValidator
	{
		private NumberParser _numberParser = new .() ~ delete _;
		private CharParser _charParser = new .() ~ delete _;

		public bool Validate(Stream stream, bool resetPos = true)
		{
			let pos = stream.Position;

			if (!ValidNumberPart(stream))
				return false;

			if (ParseChar(stream, '.'))
				return false;

			if (!stream.HasData())
			{
				stream.Back((uint32)stream.Position);
				return resetPos ? Success(stream, pos) : true;
			}

			if (!ValidScientificNotation(stream))
				return false;

			stream.Back((uint32)stream.Position);
			return resetPos ? Success(stream, pos) : true;
		}

		private bool ValidNumberPart(Stream stream)
		{
			String number;

			if (_numberParser.Any(stream, out number) case .Err)
				return false;

			delete number;

			return true;
		}

		private bool ParseChar(Stream stream, char8 char)
		{
			char8 _;
			var isValid = _charParser.Parse(stream, char, out _) == .Ok;

			return isValid;
		}

		private bool ValidScientificNotation(Stream stream)
		{
			if (ParseChar(stream, 'e'))
			{
				char8 sign;
				_charParser.Any(stream, out sign);

				if (!sign.IsDigit && (sign != '+') && (sign != '-'))
					return false;

				if (!ValidNumberPart(stream))
					return false;

				return true;
			}
			else
				return false;
		}
	}
}
