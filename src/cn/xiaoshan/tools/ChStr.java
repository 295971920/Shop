package cn.xiaoshan.tools;

	/**
	 * 
	 * @author www.xiaoshan2016.cn
	 * @date 2017年10月16日
	 */
public class ChStr {
	
	/**
	 * 功能：解决中文乱码问题
	 * @param str
	 * @return
	 */
	public String chStr(String str){
		//当变量str为null时
		if(str == null){
			str = "";//将变量赋值为空
		}else{
			try {
				//将字符串转换为UTF-8编码
				str = (new String(str.getBytes("iso-8859-1"),"UTF-8")).trim();
			} catch (Exception e) {
				// 输出异常
				e.printStackTrace();
			}
		}
		return str;//返回转换后的变量str
	}
}
