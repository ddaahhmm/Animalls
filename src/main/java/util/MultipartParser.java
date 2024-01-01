package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;


@Getter
@RequiredArgsConstructor
class MultipartHeaderLine {
	private final String key; 
	private final String value; 
	private final Map<String, String> attributes;
	
	public boolean hasAttribute(String key) {
		return attributes.containsKey(key);
	}
	
	public String getAttribute(String key) {
		return attributes.get(key);
	}
}

@Getter
@RequiredArgsConstructor
class Multipart {
	private final List<MultipartHeaderLine> header; 
	private final String data; 
	
	public String getContentDisposition() {
		return header.stream()
				.filter(hd -> "Content-Disposition".equals(hd.getKey()))
				.map(hd -> hd.getValue())
				.findFirst()
				.orElse(null);
	}
	
	public String getContentDispositionAttributeValue(String key) {
		var opt = header.stream()
				.filter(header -> "Content-Disposition".equals(header.getKey()))
				.findFirst();
				
		if (opt.isEmpty()) return null; 
		return opt.get().getAttribute(key);	
	}
}

//https://datatracker.ietf.org/doc/html/rfc2046
public class MultipartParser {
	BufferedReader reader; 
	List<Multipart> parts; 
	
	public MultipartParser(HttpServletRequest request) throws IOException {
		reader = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
		
		parts = new ArrayList<Multipart>();
		while (readBoundary() != null) {
			MultipartHeaderLine line = null ;
			List<MultipartHeaderLine> headers = new ArrayList<MultipartHeaderLine>(); 
			String data = null; 
			
			while ((line = readHeader()) != null) {
				headers.add(line);
			}
			data = readBody();
			parts.add(new Multipart(headers, data));
		}
	}
	
	String readBoundary() throws IOException {
		StringBuilder sb = new StringBuilder();  
		boolean inBoundary = false; 

		while (true) {
			if (!inBoundary) {
				while (reader.read() != '-');				
			}

			int i = reader.read(); 
			if (!inBoundary) {
				inBoundary = i == '-';
				continue;
			}
			// inboundary only 
			if (i == -1) {
				throw new IOException("unexpected end of stream");
			}
			if (i == '\r') {
				if (reader.read() == '\n') break;
				throw new IOException("unexpected carriage return");
			}
		
			sb.append(Character.toChars(i));

			if (i == '-') {
				if ((i = reader.read()) == '-') {
					sb.append(Character.toChars(i));
					if (i == -1) {
						return null;
					} else if (i == '\r') {
						if (reader.read() == '\n') {
							return null;
						}
						throw new IOException("unexpected carriage return");
					}
				}
			}
			
		}	
		String boundary = sb.toString();
		return boundary.endsWith("--") ? null : boundary;
	}
	
	MultipartHeaderLine readHeader() throws IOException {
		String key = null; 
		String value = null;
		Map<String, String> attributes = new HashMap<>();
		
		String attributeKey = null; 
		String attributeValue = null; 
		
		StringBuilder keyBuilder = new StringBuilder();
		StringBuilder valueBuilder = new StringBuilder();
		StringBuilder attributeKeyBuilder = new StringBuilder(); 
		StringBuilder attributeValueBuilder = new StringBuilder();
		
		int i = reader.read();
		while (i != '\r' ) {
			if (i == -1) {
				throw new IOException("unexpected end of stream");
			}
			if (key == null) { // read key
				if (i == ':') {
					key = keyBuilder.toString(); 
				} 
				else {
					keyBuilder.append(Character.toChars(i));		
				}
			} 
			else if (value == null) { // read value 
				if (Character.isWhitespace(i)) {
					i = reader.read();
					continue;
				}
				else if (i == ';') {
					value = valueBuilder.toString();
				}
				else {
					valueBuilder.append(Character.toChars(i));
				}
			} 
			else if (attributeKey == null){
				if (Character.isWhitespace(i)) {
					i = reader.read();
					continue;
				}
				else if (i == '=') {
					attributeKey = attributeKeyBuilder.toString();
				} else {
					attributeKeyBuilder.append(Character.toChars(i));
				}
			}
			else if (attributeValue == null) {
				if (i == ';') {
					attributeValue = attributeValueBuilder.toString();
					if (attributeValue.charAt(0) == '"' && attributeValue.charAt(attributeValue.length() - 1) == '"') {
						attributeValue = attributeValue.substring(1, attributeValue.length() - 1);
					}
					attributes.put(attributeKey, attributeValue);
					attributeKey = null; 
					attributeValue = null; 
					attributeKeyBuilder = new StringBuilder();
					attributeValueBuilder = new StringBuilder();
				} else {
					attributeValueBuilder.append(Character.toChars(i));
				}
			}
			i = reader.read();
		}	
		if (reader.read() != '\n') {
			throw new IOException("unexpected carriage return");
		}
		if (value == null) {
			value = valueBuilder.toString();
		}
		if (attributeKey != null && attributeValue == null) {
			attributeValue = attributeValueBuilder.toString();
			if (attributeValue.charAt(0) == '"' && attributeValue.charAt(attributeValue.length() - 1) == '"') {
				attributeValue = attributeValue.substring(1, attributeValue.length() - 1);
			}
			attributes.put(attributeKey, attributeValue);
		}	
		return (key == null) ? null : new MultipartHeaderLine(key, value, attributes);
	}
	
	String readBody() throws IOException {
		StringBuilder sb = new StringBuilder();
		int i = reader.read(); 
		while (i != '\r') {
			if (i == -1) {
				throw new IOException("unexpected end of stream");
			}
			sb.append(Character.toChars(i));
			i = reader.read();
		}
		i = reader.read();
		if (i != '\n') {
			throw new IOException("unexpected carriage return");
		}
		return sb.toString();
	}

	public String getFormDataValueByAttribute(@NonNull String attributeKey, @NonNull String attributeValue) {
		return parts.stream()
				.filter(mp -> "form-data".equals(mp.getContentDisposition()) && attributeValue.equals(mp.getContentDispositionAttributeValue(attributeKey)))
				.map(mp -> mp.getData())
				.findAny()
				.orElse(null);
	}
}
