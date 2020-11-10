using System.IO;
using System;
using Serilib.Parsers.Core;

namespace Serilib.Json.Validation.Impl
{
	public abstract class BaseValidator
	{
		protected bool Success(Stream stream, int oldPos)
		{
			stream.Position = oldPos;
			return true;
		}
	}
}
