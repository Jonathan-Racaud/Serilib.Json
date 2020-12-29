using System;
using System.Collections;
using System.IO;
using Serilib.Core.Parsers;
using Serilib.Core.Parsers.Impl;
using Serilib.Json.Validation.Impl;

namespace Serilib.Json.Parser.Impl
{
	public class JsonStringParser : IJsonParser<String>
	{
		private StringValidator _stringValidator = new .() ~ delete _;
		private StringParser _stringParser = new .() ~ delete _;
		private CharParser _charParser = new .() ~ delete _;

		private Dictionary<char8, char8> escapedChar;

		public this()
		{
			escapedChar = new Dictionary<char8, char8>();
			escapedChar.Add('\\', '\\');
			escapedChar.Add('"', '"');
			escapedChar.Add('b', '\b');
			escapedChar.Add('f', '\f');
			escapedChar.Add('n', '\n');
			escapedChar.Add('r', '\r');
			escapedChar.Add('t', '\t');
			escapedChar.Add('/', '/');
		}

		public ~this()
		{
			 delete escapedChar;
		}

		public Result<void, ParseErrors> Parse(Stream stream, out String dest)
		{
			dest = default;

			char8 ch;
			if (_charParser.Parse(stream, '"', out ch) case .Err)
				return .Err(.InvalidValue);

			dest = new String();
			var isEscaped = false;
			while ((_charParser.Any(stream, out ch) case .Ok))
			{
				if (isEscaped)
				{
					if (!escapedChar.ContainsKey(ch))
						return .Err(.InvalidValue);

					dest.Append(escapedChar[ch]);
					isEscaped = false;
					continue;
				}

				if (ch == '\\')
				{
					isEscaped = true;
					continue;
				}

				if (ch == '"')
					break;

				dest.Append(ch);
				continue;
			}

			if (ch != '"')
			{
				delete dest;
				return .Err(.InvalidValue);
			}

			return .Ok;
		}
	}
}
