using System;
using System.IO;
using Serilib.Parsers.Core;
using Serilib.Serializers.Core;

namespace Serilib.Json.Validation.Impl
{
	public class JsonValidator : BaseValidator, IJsonValidator
	{
		private CharParser _charParser = new .() ~ delete _;
		private Char8Serializer _charSerializer = new .() ~ delete _;
		private IStringValidator _stringValidator = new StringValidator() ~ delete _;
		private INumberValidator _numberValidator = new NumberValidator() ~ delete _;
		private ITrueLiteralValidator _trueValidator = new TrueLiteralValidator() ~ delete _;
		private IFalseLiteralValidator _falseValidator = new FalseLiteralValidator() ~ delete _;
		private INullLiteralValidator _nullValidator = new NullLiteralValidator() ~ delete _;
		private IJsonValidator[] _validators = new IJsonValidator[] (
				_nullValidator,
				_trueValidator,
				_falseValidator,
				_numberValidator,
				_stringValidator
			) ~ delete _;

		public bool Validate(Stream stream, bool resetPos = true)
		{
			SkipWhitespace(stream);

			let pos = stream.Position;

			if (ValidateOtherTypes(stream))
				return resetPos ? Success(stream, pos) : true;
			stream.Position = pos;

			if (ValidateObject(stream))
				return resetPos ? Success(stream, pos) : true;
			stream.Position = pos;

			if (ValidateArray(stream))
				return resetPos ? Success(stream, pos) : true;

			return false;
		}

		private bool ValidateObject(Stream stream)
		{
			char8 ch;
			if (_charParser.Parse(stream, '{', out ch) case .Err)
				return false;

			while (true)
			{
				SkipWhitespace(stream);

				// Check for end of object
				if (_charParser.Parse(stream, '}', out ch) case .Ok)
					return true;

				// Check for a key
				if (!_stringValidator.Validate(stream, false))
					return false;

				SkipWhitespace(stream);

				// Check for the key separator
				if (_charParser.Parse(stream, ':', out ch) case .Err)
					return false;

				// Check for the value
				if (!Validate(stream, false))
					return false;

				SkipWhitespace(stream);

				if (_charSerializer.Deserialize(stream, out ch) case .Err)
					return false;

				// Check for end of object or for item separator
				switch (ch)
				{
				case '}':
					return true;
				case ',':
					continue;
				default:
					return false;
				}
			}
		}

		private bool ValidateArray(Stream stream)
		{
			char8 ch;

			if (_charParser.Parse(stream, '[', out ch) case .Err)
				return false;

			while (true)
			{
				SkipWhitespace(stream);

				// Check for end of array
				if (_charParser.Parse(stream, ']', out ch) case .Ok)
					return true;

				// Check for a value
				if (!Validate(stream, false))
					return false;

				SkipWhitespace(stream);

				if (_charSerializer.Deserialize(stream, out ch) case .Err)
					return false;

				// Check for end of object or for item separator
				switch (ch)
				{
				case ']':
					return true;
				case ',':
					continue;
				default:
					return false;
				}
			}
		}

		private bool ValidateOtherTypes(Stream stream)
		{
			var isValid = false;

			for (let validator in _validators)
			{
				let p = stream.Position;

				isValid = validator.Validate(stream, false);

				if (isValid)
					break;
				else
					stream.Position = p;
			}

			return isValid;
		}

		private void SkipWhitespace(Stream stream)
		{
			char8 ch;
			while (
				(_charParser.Parse(stream, ' ', out ch) case .Ok) ||
				(_charParser.Parse(stream, '\t', out ch) case .Ok) ||
				(_charParser.Parse(stream, '\r', out ch) case .Ok) ||
				(_charParser.Parse(stream, '\n', out ch) case .Ok))
				continue;
		}
	}
}
