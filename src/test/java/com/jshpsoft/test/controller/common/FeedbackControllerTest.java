package com.jshpsoft.test.controller.common;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.codec.CharEncoding;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

/**
 * 意见反馈测试
 * @author army.liu 
 * @date 2016年11月4日 上午9:24:36
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class FeedbackControllerTest {
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	private MockHttpServletRequest request = null;
	
	@Before
	public void setUp(){
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		request.addHeader("token", "8dd3ec71a39a1c1ff60e3e19ca567474");
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}
	
	/**
	 * 
	 * @Description: 新增测试
	 * @author army.liu 
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	@Test
	public void testsave() throws Exception{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("suggest", "不好用");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/feedbackMng/save";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	/**
	 * @Description: 获取详细测试
	 * @author army.liu 
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	@Test
	public void testgetDetailData() throws Exception{
		//请求参数：json格式
		String url = "/basicSetting/feedbackMng/getDetailData/11";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	/**
	 * 
	 * @Description: 获取列表数据测试
	 * @author army.liu 
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	@Test
	public void testgetListData() throws Exception{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("suggest", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/feedbackMng/getListData";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
}
