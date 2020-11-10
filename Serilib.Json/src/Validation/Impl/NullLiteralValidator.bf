using System;
using System.IO;

namespace Serilib.Json.Validation.Impl
{
	public class NullLiteralValidator : BaseValidator
	{
		private String _value = "null";

		public override bool Validate(Stream stream)
		{
			return base.Validate(stream, _value);
		}

		public override bool Validate(Stream stream, String value)
		{
			if (value.Equals(_value))
				return Validate(stream);

			return false;
		}
	}
}
