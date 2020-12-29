using System;
using System.IO;
using Serilib.Core.Parsers;

namespace Serilib.Json.Parser
{
	public interface IJsonParser<T>
	{
		Result<void, ParseErrors> Parse(Stream stream, out T dest);
	}
}
