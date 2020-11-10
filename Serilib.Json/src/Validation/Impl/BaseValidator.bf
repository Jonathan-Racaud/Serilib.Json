using System.IO;
using System;
using Serilib.Parsers.Core;

namespace Serilib.Json.Validation.Impl
{
	public abstract class BaseValidator : IJsonValidator
	{
		private StringParser _stringParser = new .() ~ delete _;

		public abstract bool Validate(Stream stream);

		public virtual bool Validate(Stream stream, String value)
		{
			String _;
			var isValid = _stringParser.Parse(stream, value, out _) == .Ok;
			delete _;

			stream.Back((uint32)stream.Position);

			return isValid;
		}
	}
}
