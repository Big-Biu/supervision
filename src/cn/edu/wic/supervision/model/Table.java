package cn.edu.wic.supervision.model;

public class Table
{
	private Integer page = 1;
	private Integer limit = 10;

	public Integer getPage()
	{
		return page;
	}

	public void setPage(Integer page)
	{
		this.page = page;
	}

	public Integer getLimit()
	{
		return limit;
	}

	public void setLimit(Integer limit)
	{
		this.limit = limit;
	}

}
