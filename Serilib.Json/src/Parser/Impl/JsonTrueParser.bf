using System;
using System.IO;
using Serilib.Core.Parsers;
using Serilib.Core.Parsers.Impl;

namespace Serilib.Json.Parser.Impl
{
	public class JsonTrueParser : BaseLiteralParser
	{
		public this()
		{
			_value = "true";
		}
	}
}