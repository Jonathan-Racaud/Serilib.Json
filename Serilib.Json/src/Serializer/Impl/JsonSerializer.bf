using System;
using System.IO;
using Serilib.Core;
using Serilib.Core.Serializers;
using Serilib.Json.Core;
using System.Collections;

namespace Serilib.Json.Serializer.Impl
{
	public class JsonSerializer : IJsonSerializer
	{
		private readonly IJsonStringSerializer _stringSerializer;
		private readonly IJsonNumberSerializer _numberSerializer;
		private readonly IJsonLiteralSerializer _literalSerializer;
		private readonly IJsonObjectSerializer _objectSerializer;
		private readonly IJsonArraySerializer _arraySerializer;

		public Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : class
		{
			if ((target is bool) || (target == null))
				return _literalSerializer.Serialize(outStream, target as bool?);

			if (target is String)
				return _stringSerializer.Serialize(outStream, target as String);

			if (target is IList || target is Array)
				return _arraySerializer.Serialize(outStream, target);

			return _objectSerializer.Serialize(outStream, target);
		}

		public Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : struct
		{
			return _objectSerializer.Serialize(outStream, target);
		}

		public Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : ValueType
		{
			let type = typeof(T);

			if (type.IsIntegral || type.IsFloatingPoint)
			{
				let number = scope String();
				target.ToString(number);
				return _numberSerializer.Serialize(outStream, number);
			}

			return .Err(.Unknown);
		}

		public Result<void, SerializationErrors> Deserialize<T>(Stream stream, T target) where T : class where T : new
		{
			return default;
		}

		public Result<void, SerializationErrors> Deserialize<T>(Stream stream, T target) where T : struct
		{
			return default;
		}
	}
}
