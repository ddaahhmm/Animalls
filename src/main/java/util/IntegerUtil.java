package util;

public class IntegerUtil {
	public static int parseIntWithDefaultValue(String s, int def) {
		int ret = def; 
		try {
			ret = Integer.parseInt(s);
		} catch(Exception e) {}
		return ret;
	}
}
