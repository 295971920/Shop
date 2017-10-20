package cn.xiaoshan.dao;


import java.util.List;
import cn.xiaoshan.model.Member;

public interface MemberDao {

	public int insert(Member m);//保存会员信息
	public List select();//查询会员信息
}
