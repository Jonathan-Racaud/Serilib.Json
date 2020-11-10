using System;
using System.IO;
using Serilib.Parsers.Core;
using Serilib.Serializers.Core;

namespace Serilib.Json.Validation.Impl
{
	public class ObjectValidator: BaseValidator, IObjectValidator
	{
		private CharParser _charParser = new .() ~ delete _;
		private Char8Serializer _charSerializer = new .() ~ delete _;
		private IArrayValidator _arrayValidator;
		private IStringValidator _stringValidator;
		private INumberValidator _numberValidator;
		private ITrueLiteralValidator _trueValidator;
		private IFalseLiteralValidator _falseValidator;
		private INullLiteralValidator _nullValidator;
		private IJsonValidator[] _validators;

		public this(
			IArrayValidator arrayValidator,
			IStringValidator stringValidator,
			INumberValidator numberValidator,
			ITrueLiteralValidator trueValidator,
			IFalseLiteralValidator falseValidator,
			INullLiteralValidator nullValidator)
		{
			_arrayValidator = arrayValidator;
			_stringValidator = stringValidator;
			_numberValidator = numberValidator;
			_trueValidator = trueValidator;
			_falseValidator = falseValidator;
			_nullValidator = nullValidator;

			_validators = new IJsonValidator[] (
				_nullValidator,
				_trueValidator,
				_falseValidator,
				_stringValidator,
				_falseValidator,
				_numberValidator,
				this,
				_arrayValidator );
		}

		public bool Validate(Stream stream, bool resetPos = true)
		{
			let pos = stream.Position;

			char8 ch;
			if (_charParser.Parse(stream, '{', out ch) case .Err)
				return false;

			var cont = true;
			while (cont)
			{
				SkipWhitespace(stream);

				// Check for a key
				if (!_stringValidator.Validate(stream, false))
				{
					if (_charParser.Parse(stream, '}', out ch) case .Ok)
						return resetPos ? Success(stream, pos) : true;
					return false;
				}
					

				SkipWhitespace(stream);

				// Check for the key separator
				if (_charParser.Parse(stream, ':', out ch) case .Err)
					return false;

				SkipWhitespace(stream);

				// Check for the value
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

				if (!isValid)
					return false;

				SkipWhitespace(stream);

				if (_charSerializer.Deserialize(stream, out ch) case .Err)
					return false;

				if (ch == ',')
					continue;
				else if (ch == '}')
					cont = false;
				else
					return false;
			}

			return resetPos ? Success(stream, pos) : true;
		}

		public bool Validate(Stream stream, String value)
		{
			return Validate(stream);
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
