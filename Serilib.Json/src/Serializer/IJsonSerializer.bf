using System;
using System.IO;
using Serilib.Core;
using Serilib.Core.Serializers;

namespace Serilib.Json.Serializer
{
	public interface IJsonSerializer
	{
		/// \Brief Serialize the target into the outStream.
		Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : class;
		Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : struct;
		Result<void, SerializationErrors> Serializer<T>(T target, Stream outStream) where T : ValueType;

		/// \Brief Deserialize the stream into the target object.
		Result<void, SerializationErrors> Deserialize<T>(Stream stream, T target) where T : class, new;

		/// \Brief Deserialize the stream into the target struct.
		Result<void, SerializationErrors> Deserialize<T>(Stream stream, T target) where T : struct;
	}
}
