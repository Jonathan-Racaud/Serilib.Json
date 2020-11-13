using System;
using System.IO;
using Serilib.Core.Parsers;

namespace Serilib.Json.Parser
{
	public interface IJsonTrueParser
	{
		Result<void, ParseErrors> Parse(Stream stream);
	}
}
