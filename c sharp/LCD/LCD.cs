using System;
using System.Collections.Generic;
using System.Linq;

class LCD
{
	private static int[] TABLE = { 119, 36, 93, 109, 46, 107, 123, 37, 127, 111 };
	private static string H_SYM = "-";
	private static string V_SYM = "|";
	private static string S_SYM = " ";

	List<int> numbers;
	int segments;

	public LCD (string input, int segments)
	{
		this.numbers = new List<int> ();
		this.segments = segments;
		foreach (char c in input) {
			numbers.Add (Int32.Parse (c.ToString()));
		}
	}

	bool test (int number, int position)
	{
		return (TABLE[number] & Convert.ToInt32(Math.Pow(2, position))) > 0;
	}

	void draw ()
	{
		int offset = 0;
		for (int row = 0; row < 5; row++) {
			if (row % 2 == 0) {
				foreach (int number in numbers) {
					string symbol = test (number, row + offset) ? H_SYM : S_SYM;
					string symbols = String.Concat (Enumerable.Repeat (symbol, segments));
					Console.Write (S_SYM + symbols + S_SYM + S_SYM);
				}
				Console.Write ("\n");
			} else {
				for (int i = 0; i < segments; i++) {
					foreach (int number in numbers) {
						for (int column = 0; column < 2; column++) {
							string symbol = test (number, row + column + offset) ? V_SYM : S_SYM;
							string spaces = String.Concat (Enumerable.Repeat (S_SYM, column == 0 ? segments : 1));
							Console.Write (symbol + spaces);
						}
					}
					Console.Write ("\n");
				}
				offset++;
			}
		}
	}

	public static void Main (string[] args)
	{
		if (args.Length > 0) {
			string input;
			int segments = 2;
			if (args [0] == "-s") {
				input = args [2];
				segments = Int32.Parse (args [1]);
			} else {
				input = args [0];
			}
			LCD lcd = new LCD (input, segments);
			lcd.draw ();
		} else {
			Console.WriteLine ("Usage: LCD.exe [-s SEGMENTS] NUMBER");
		}
	}
}
