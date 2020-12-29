using System;
using System.IO;
using Serilib.Core.Serializers;
using Serilib.Core.Serializers.Impl;
using Serilib.Core.Parsers.Impl;

namespace Serilib.Json.Serializer.Impl
{
	public class JsonLiteralSerializer : IJsonLiteralSerializer
	{
		private readonly Char8Serializer _serializer;
		private readonly StringParser _parser;

		public Result<void, SerializationErrors> Deserialize(Stream stream, out bool? target)
		{
			target = default;

			var str = scope String();

			if (_parser.Parse(stream, "true", out str) case .Ok)
				target = true;
			else if (_parser.Parse(stream, "false", out str) case .Ok)
				target = false;
			else if (_parser.Parse(stream, "null", out str) case .Ok)
				target = null;
			else
				return .Err(.Unknown);

			return .Ok;
		}

		public Result<void, SerializationErrors> Serialize(Stream stream, bool? target)
		{
			if (!target.HasValue)
				stream.Write("null");
			else
				stream.Write(target.Value ? "true" : "false");
			return .Ok;
		}
	}
}
