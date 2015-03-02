package bzu.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.commons.codec.binary.Base64;
import org.springframework.util.StringUtils;

public class UserAgentUtils {

	// Content-Disposition值可以有以下几种编码格式
	// 1. 直接urlencode：
	// Content-Disposition: attachment;
	// filename="struts2.0%E4%B8%AD%E6%96%87%E6%95%99%E7%A8%8B.chm"
	// 2. Base64编码：
	// Content-Disposition: attachment;
	// filename="=?UTF8?B?c3RydXRzMi4w5Lit5paH5pWZ56iLLmNobQ==?="
	// 3. RFC2231规定的标准：
	// Content-Disposition: attachment; filename*=UTF-8''%E5%9B%9E%E6%89%A7.msg
	// 4. 直接ISO编码的文件名：
	// Content-Disposition: attachment;filename="测试.txt"
	//
	// 然后，各浏览器支持的对应编码格式为：
	// 1. IE浏览器，采用URLEncoder编码
	// 2. Opera浏览器，采用filename*方式
	// 3. Safari浏览器，采用ISO编码的中文输出
	// 4. Chrome浏览器，采用Base64编码或ISO编码的中文输出
	// 5. FireFox浏览器，采用Base64或filename*或ISO编码的中文输出
	//
	/**
	 * 根据给定的文件名 filename 构造适用于不同浏览器的 Content-disposition。
	 * 例如：给定文件名"中文.xls"，自动根据浏览器类型转换为 "attachment; filename..."， 末尾省略部分与浏览器类型有关。
	 * 
	 * @param filename
	 * @param userAgent
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String makeAttachmentFilename(String filename, String agent)
			throws UnsupportedEncodingException {
		// attachment; filename
		StringBuilder attFilename = new StringBuilder("attachment; filename");
		if (null != agent) {
			agent = agent.toLowerCase();
			if (-1 != agent.indexOf("opera")) {
				// attachment; filename*=UTF-8''UTF-8 ENCODED FILENAME
				attFilename.append("*=UTF-8''");
				String utf8Encode = URLEncoder.encode(filename, "UTF-8");
				attFilename.append(utf8Encode);
			} else if (-1 != agent.indexOf("msie")) { // IE7,8,9,10
				// attachment; filename="URL ENCODED FILENAME"
				attFilename.append("=\"");
				String urlEncode = URLEncoder.encode(filename, "UTF-8");
				attFilename.append(StringUtils.replace(urlEncode, "+", "%20")); // 替换空格
				attFilename.append("\"");
			} else if (-1 != agent.indexOf("firefox")) { // Firefox
				// attachment; filename="BASE64 ENCODED FILENAME"
				attFilename.append("=\"=?UTF8?B?");
				String base64Encode = new String(Base64.encodeBase64(filename
						.getBytes("UTF-8")));
				attFilename.append(base64Encode);
				attFilename.append("?=\"");
			} else if (-1 != agent.indexOf("chrome")) { // Chrome
				// attachment; filename="ISO8859-1 ENCODED FILENAME"
				attFilename.append("=\"");
				String isoEncode = new String(filename.getBytes(), "ISO8859-1");
				attFilename.append(isoEncode);
				attFilename.append("\"");
			} else if (-1 != agent.indexOf("safari")) { // Safari
				// attachment; filename="FILENAME"
				attFilename.append("=\"");
				attFilename.append(filename);
				attFilename.append("\"");
			} else { // IE11, etc.
				// attachment; filename*=UTF-8''UTF-8 ENCODED FILENAME
				attFilename.append("*=UTF-8''");
				String utf8Encode = URLEncoder.encode(filename, "UTF-8");
				attFilename.append(utf8Encode);
			}
		} else { // no user-agent, may be ISO, we don't care.
			attFilename.append("=\"");
			attFilename.append(filename);
			attFilename.append("\"");
		}

		return attFilename.toString();
	}
	/*
	 * 后记：混乱的 User-Agent ---------------------- Mosaic NCSA_Mosaic/2.0（Windows
	 * 3.1） Netscape Mozilla/1.0(Win3.1) IE, IE like == MSIE && ! Opera
	 * Mozilla/1.22(compatible; MSIE 2.0; Windows 95) Mozilla/4.0 (compatible;
	 * MSIE 8.0; Windows NT 6.0) IE11 == Trident & Gecko Mozilla/5.0 (Windows NT
	 * 6.1; Trident/7.0; rv:11.0) like Gecko Gecko Mozilla/5.0(Windows; U;
	 * Windows NT 5.0; en-US; rv:1.1) Gecko/20020826 Mozilla/5.0 (Macintosh; U;
	 * PPC Mac OS X Mach-O; en-US; rv:1.7.2) Gecko/20040825 Camino/0.8.1
	 * Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.8) Gecko/20071008
	 * SeaMonkey/1.0 Firefox == Firefox && Opera Mozilla/5.0 (Windows; U;
	 * Windows NT 5.1; sv-SE; rv:1.7.5) Gecko/20041108 Firefox/1.0 KHTML
	 * Mozilla/5.0 (compatible; Konqueror/3.2; FreeBSD) (KHTML, like Gecko)
	 * Opera == Opera Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en)
	 * Opera 9.51 Mozilla/5.0 (Windows NT 6.0; U; en; rv:1.8.1) Gecko/20061208
	 * Firefox/2.0.0 Opera 9.51 Opera/9.51 (Windows NT 5.1; U; en) Safari ==
	 * Safari && ! Chrome Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de)
	 * AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.5 Chrome == Chrome
	 * Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13
	 * (KHTML, like Gecko) Chrome/0.2.149.27 Safari/525.13
	 */
}
