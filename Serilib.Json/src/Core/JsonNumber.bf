using System;

namespace Serilib.Json.Core
{
	public class JsonNumber
	{
		private String _numberRepresentation = new .() ~ delete _;

		public int64 AsInteger => int64.Parse(_numberRepresentation);
		public float AsFloat => float.Parse(_numberRepresentation);
		public double AsDouble => double.Parse(_numberRepresentation);

		public this(int64 number)
		{
			number.ToString(_numberRepresentation);
		}

		public this(float number)
		{
			number.ToString(_numberRepresentation);
		}

		public this(double number)
		{
			number.ToString(_numberRepresentation);
		}
	}
}
