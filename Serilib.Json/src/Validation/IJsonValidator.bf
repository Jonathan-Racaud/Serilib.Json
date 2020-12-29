using System;
using System.IO;

namespace Serilib.Json.Validation
{
	public interface IJsonValidator
	{
		/**
		* Brief Validates that the specified stream has the correct value.
		*
		* \param stream The stream to verify.
		* \return true if valid, false otherwise.
		*/
		bool Validate(Stream stream, bool resetPos = true);
	}
}
