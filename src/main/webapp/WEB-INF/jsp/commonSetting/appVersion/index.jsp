
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!-- basic styles -->
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
<!-- page specific plugin styles -->
<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<!-- inline styles related to this page -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/ztree/demo.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/form.table.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			基础信息管理
			<small>
				<i class="icon-double-angle-right"></i>
				APP版本管理
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">类型：</label>
		   <select id="fom_type" class="form-box" >
		   <option value="">请选择类型</option>
		   <option value="0">苹果</option>
		   <option value="1">安卓</option>
		   	</select>
		   	<label class="title">版本：</label>
		  <input id="fom_version" class="form-box" type="text" placeholder="请填写版本"/>
		    <label class="title">状态：</label>
		   <select id="fom_status" class="form-box" >
		   <option value="">请选择状态</option>
		   <option value="0">新建</option>
		   <option value="1">已提交</option>
		   	</select>
			<a class="itemBtn" onclick="searchInfo()">查询</a>
			<a class="itemBtn" onclick="doadd()">新增</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
                    <th>版本</th>
                    <th>备注</th>
                    <th>创建时间</th>
                    <th>创建人</th>
                    <th>更新时间</th>
                    <th>更新人</th> 
                    <th>状态</th>                  
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div class="modal fade" id="modal-info" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">新增/编辑APP版本信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>类型：</label>
							    <select id="type" class="form-control" >
							    <option value="0">苹果</option>
		                        <option value="1">安卓</option>	
		                        </select>
							     <input class="form-control" id="id-hidden" type="hidden"/>
							  </div>
							  <hr class="tree"></hr>
							 <div class="add-item extra-itemSec">
							     <label class="title"><span class="red">*</span>版本：</label>
							     <input id="version" class="form-control" type="text" placeholder="请填写版本"/>
							 </div>
							 <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">备注 ：</label>
							     <textarea class="form-control" rows="3" id="mark" name="mark" placeholder="请填写备注  " ></textarea> 
							  </div>
							  <div id="appFile">
							   <hr class="tree"></hr>
							  <div class="add-item extra-itemSec">
							     <label class="title">附件：</label>
							     <p id="appFilePath" class="form-control no-border"></p>
							  </div>	
							  </div>							  					  
							    <hr class="tree"></hr>
							    <div class="add-item-btn" id="addBtn">
								    <a class="add-itemBtn btnOk" onclick="save();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="refresh();">关闭</a>
								 </div>
								 <div class="add-item-btn" id="editBtn">
								    <a class="add-itemBtn btnOk" onclick="update()" style="margin-left: 130px;">更新</a>
								    <a class="add-itemBtn btnOk" onclick="refresh()">关闭</a>
								  </div> 
								  <div class="add-item-btn" id="viewBtn">
								    <a class="add-itemBtn btnOk" onclick="refresh()" style="margin-left: 130px;">关闭</a>
								  </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		    <div class="modal fade" id="modal-upload" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal">×</button>
					<h3 id="myModalLabel">附件上传</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
														  
							 <div class="add-item col-xs-12" style="margin-bottom: 10px;margin-top: 20px;">
							    <label class="title col-xs-2" >附件 ：</label>	
							    <div class="col-xs-10"> <input type="file" id="inputfile" /> <label class="title" id="filename"></label>
							    <input type="hidden" name="filename_hidden" id="filename_hidden"/>
							    <input type="hidden" name="filepath_hidden" id="filepath_hidden"/>
							    <input class="form-control" id="detilid-hidden" type="hidden"/>
							    </div>							    
							   </div>	
							  						  
							    <hr class="tree" style="margin-top: 120px;"></hr>
							    <div class="add-item-btn" id="uploadBtn">
								    <a class="add-itemBtn btnOk" onclick="uploadsave();" style="margin-left: 130px;">保存</a>
								    <a class="add-itemBtn btnOk" onclick="uploadrefresh();">关闭</a>
								 </div>
								
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
		</div>
	</div>
</div>





<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
<script src="${ctx}/staticPublic/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript" src="${ctx}/staticPublic/js/bootbox.min.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
<script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
function init(){
	//initiate dataTables plugin
	var myTable = $('#detailtable').DataTable({
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/appVersion/getListData" , //获取数据的ajax方法的URL							 
		 ordering: false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
		 columns: [{ data: "rownum" ,"width":"4%"},
		    {data: "type","width":"9%"},
		    {data: "version","width":"9%"},
		    {data: "mark","width":"10%"},
		    {data: "insertTime","width":"10%"},
		    {data: "insertUser","width":"8%"},
		    {data: "updateTime","width":"10%"},
		    {data: "updateUser","width":"8%"},		
		    {data: "status","width":"8%"},		   
		    {data: null,"width":"14%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '苹果';
					}else if(data=='1'){
						return '安卓';
					}else{
						return '';
					}
			       }	       
			},{
				 //入职时间
				 targets: 8,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '新建';
					}else if(data=='1'){
						return '已提交';
					}else{
						return '';
					}
			       }	       
			},{
				 //入职时间
				 targets: 4,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonDateFormat(data);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
					 //入职时间
					 targets: 6,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},
		      	{
			    	 //操作栏
			    	 targets: 9,
			    	 render: function (data, type, row, meta) {
			    		 if(row.status=='0'){
			    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
			    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
					           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
					           +'<a class="table-upload" onclick="doupload(\''+ row.id +'\',\''+ row.appFilePath +'\',\''+ row.type +'\')">附件上传</a>';	 
			    		 }else{
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	  
			    		 }
		                    
		                }	       
		    	} 
		      ],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
function reload(){
	//reload dataTables plugin
	var myTable = $('#detailtable').DataTable({
		"destroy": true,//如果需要重新加载需销毁
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/commonSetting/appVersion/getListData", //获取数据的ajax方法的URL	
		 ordering: false,	
			"oLanguage": {
				"sLengthMenu": "每页显示 _MENU_ 条记录",
				"sZeroRecords": "抱歉， 没有找到",
				"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
				"sInfoEmpty": "没有数据",
				"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
				"oPaginate": {
				"sFirst": "首页",
				"sPrevious": "上一页",
				"sNext": "下一页",
				"sLast": "尾页"
				},
				"sZeroRecords": "没有检索到数据"
				},		
				columns: [{ data: "rownum" ,"width":"4%"},
						    {data: "type","width":"9%"},
						    {data: "version","width":"9%"},
						    {data: "mark","width":"10%"},
						    {data: "insertTime","width":"10%"},
						    {data: "insertUser","width":"8%"},
						    {data: "updateTime","width":"10%"},
						    {data: "updateUser","width":"8%"},		
						    {data: "status","width":"8%"},		   
						    {data: null,"width":"14%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 1,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '苹果';
									}else if(data=='1'){
										return '安卓';
									}else{
										return '';
									}
							       }	       
							},{
								 //入职时间
								 targets: 8,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '新建';
									}else if(data=='1'){
										return '已提交';
									}else{
										return '';
									}
							       }	       
							},{
								 //入职时间
								 targets: 4,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
									 //入职时间
									 targets: 6,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},
						      	{
							    	 //操作栏
							    	 targets: 9,
							    	 render: function (data, type, row, meta) {
							    		 if(row.status=='0'){
							    			 return '<a class="table-edit" onclick="dosubmit('+ row.id +')">提交</a>'
							    			   +'<a class="table-edit" onclick="doedit('+ row.id +')">编辑</a>'
									           +'<a class="table-delete" onclick="dodelete('+ row.id +')">删除</a>'
									           +'<a class="table-upload" onclick="doupload(\''+ row.id +'\',\''+ row.appFilePath +'\',\''+ row.type +'\')">附件上传</a>';	 
							    		 }else{
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	  
							    		 }
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}
$(function(){
	init();
	//BindSup();//绑定供应商
	//BindOutSour();//绑定供应商
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var type=$("#fom_type").val(); 
	   var version=$("#fom_version").val(); 
	   var status=$("#fom_status").val(); 
	  // var carType=$("#carType").val(); 
	   $('#secho').val(secho);
	   var obj = {};
		 $.ajax({
			type : 'POST',
			url : sSource,
			data : JSON.stringify({
				sEcho : $.trim(secho),				
				pageStartIndex : $.trim(pageStartIndex),
				pageSize : $.trim(pageSize),
				type :$.trim(type),
				version :$.trim(version),
				status :$.trim(status)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {
					//console.info(JSON.stringify(data.data));									
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
						}
					}else{
						obj.aaData=[];
					}
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	   
	}
/* 查询 */
function searchInfo(){
	reload();
}

	
/* 删除APP版本信息 */
function dodelete(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要删除APP版本信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/commonSetting/appVersion/delete/"+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "删除成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
										  }else{
											reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										 reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
};

/*新增信息输入  */
function doadd(){
	clear();
	$('#addBtn').show();
	$('#editBtn').hide();
	$('#viewBtn').hide();
	$('#appFile').hide();
	$("#type").attr("disabled",false);
	$("#version").attr("disabled",false);
	$("#mark").attr("disabled",false);
	$('#myModalLabel').html('新增结算价格信息');	
	$('#modal-info').modal('show');
}
/* 关闭窗体 */
function refresh(){
	clear();
	$('#modal-info').modal('hide');
	
}
/* 数据重置 */
function clear(){
	$('#id-hidden').val('');
	$('#type').val('0');
	$('#version').val('');	
	$('#mark').val('');
}
/* 保存新增人员信息 */
function save(){
	var flag="false";
	var type=$('#type').val();
	var version=$('#version').val();	
	var mark=$('#mark').val();
	if(type==''|| type==null){
		bootbox.alert('类型不能为空！');
		return;
	}
	if(version==''|| version==null){
		bootbox.alert('版本不能为空！');
		return;
	}
	if(version!=''){
		var reg = /^[0-9]+.?[0-9]*$/;//用来验证数字，包括小数的正则
		if(!reg.test(version)){
			bootbox.alert('请输入正确的数字格式小数点后只能有一位小数！如：10.1');
			return;
			}else if (version.split('.').length > 1 && version.split('.')[1].length !=1){
				bootbox.alert('请输入正确的数字格式小数点后只能有一位小数！如：10.1');
				return;
			}
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该新增APP版本信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/appVersion/save',
						data : JSON.stringify({
							type : type,				
							version : version,
							mark : mark
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								bootbox.alert(data.msg);
							}
							
						}
						
					});
			  }
		  }
		})
}
function doedit(id){	
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/commonSetting/appVersion/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('编辑APP版本信息');
				$('#type').val(data.data.type);
				$('#version').val(data.data.version);
				$('#mark').val(data.data.mark);	
				$("#type").attr("disabled",false);
				$("#version").attr("disabled",false);
				$("#mark").attr("disabled",false);
				$('#addBtn').hide();
				$('#editBtn').show();
				$('#viewBtn').hide();
				$('#appFile').hide();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
/* 更新 */
function update(){
	var flag="false";
	var id=$('#id-hidden').val();
	var type=$('#type').val();
	var version=$('#version').val();	
	var mark=$('#mark').val();
	if(type==''|| type==null){
		bootbox.alert('类型不能为空！');
		return;
	}
	if(version==''|| version==null){
		bootbox.alert('版本不能为空！');
		return;
	}	
	if(version!=''){
		var reg = /^[0-9]+.?[0-9]*$/;//用来验证数字，包括小数的正则
		if(!reg.test(version)){
			bootbox.alert('请输入正确的数字格式小数点后只能有一位小数！如：10.1');
			return;
			}else if (version.split('.').length > 1 && version.split('.')[1].length !=1){
				bootbox.alert('请输入正确的数字格式小数点后只能有一位小数！如：10.1');
				return;
			}
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要更新该APP版本信息?", 
		  callback: function(result){
			  if(result){
					$.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/appVersion/save',
						data : JSON.stringify({
							id : id,
							type : type,				
							version : version,
							mark : mark
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								bootbox.alert(data.msg);
							}
							
						}
						
					});
			  }
		  }
		})
}


/* 提交APP版本信息 */
function dosubmit(id){
	var flag="false";
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要提交APP版本信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'GET',
						url : "${ctx}/commonSetting/appVersion/submit/"+id,
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "提交成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  reload();
										  }else{
											reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								bootbox.alert(data.msg);
							}
						}
						
					}); 
			  }
		  }
	})
}
function doview(id){
	clear();
	$.ajax({
		type : 'GET',
		url : "${ctx}/commonSetting/appVersion/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				$('#id-hidden').val(id);
				$('#myModalLabel').html('APP版本信息');			
				$('#type').val(data.data.type);
				$('#version').val(data.data.version);
				$('#mark').val(data.data.mark);	
				var filePaths="${ctx}"+data.data.appFilePath;
				var htmls='<a  href='+filePaths+' target="_blank">'+data.data.appFilePath+'</a>';
				$('#appFilePath').html(htmls);		
				$('#addBtn').hide();
				$('#editBtn').show();
				$("#type").attr("disabled",true);
				$("#version").attr("disabled",true);
				$("#mark").attr("disabled",true);
				$('#addBtn').hide();
				$('#editBtn').hide();
				$('#viewBtn').show();
				$('#appFile').show();
				$('#modal-info').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
function clearupload(){
	$('#detilid-hidden').val('');
	$('#filepath_hidden').val('');
	$('#filename').html('');
}
/**附件上传**/
function doupload(id,filePath,type){
	clearupload();
    var typename='';
	$('#uploadBtn').show();
	$('#detilid-hidden').val(id);
	$('#filepath_hidden').val(filePath);	
	var filePaths="${ctx}"+filePath;
	var htmls='<a  href='+filePaths+' target="_blank">'+filePath+'</a>';
	if(filePath!=''&&filePath!='null'&&filePath!='undefined'){
		$('#filename').html(htmls);
		}
	if(type=='0'){
		typename='ios';
	}else{
		typename='android';
	}
	$('#modal-upload').modal('show');
	$("#inputfile").uploadify({
		//按钮额外自己添加点的样式类.upload
        'buttonClass':'upload',
        //限制文件上传大小
        'fileSizeLimit':'200MB',
        //文件选择框显示
        'fileTypeDesc':'选择',
        //文件类型过滤
       /*  'fileTypeExts':'*.zip;*.rar', */
        //按钮高度
        'height':'30',
        //按钮宽度
        'width':'100',
        //请求类型
        'method':'post',
        //是否支持多文件上传
        'multi':false,
        /* //需要重写的事件
        'overrideEvents'    :    ['onUploadError'], */
        /* //队列ID，用来显示文件上传队列与进度
        'queueID'            :    'photo_queue', */
        //队列一次最多允许的文件数，也就是一次最多进入上传队列的文件数
        'queueSizeLimit': 1,
        //上传动画，插件文件下的swf文件
        'swf':'${ctx}/staticPublic/js/uploadify/uploadify.swf',
        //处理上传文件的服务类
        'uploader':'${ctx}/upload/saveFile?type='+typename,
        /* //上传文件个数限制
        'uploadLimit': 1, */
        //上传按钮内容显示文本
        'buttonText':'上传',
         //自定义重写的方法，文件上传错误触发
        /*'onUploadError'        :   function(file,errorCode,erorMsg,errorString){
        	alert(erorMsg);
        },
        //文件选择错误触发
        'onSelectError'        :    uploadify_onSelectError, */
        /* //文件队列上传完毕触发
        'onQueueComplete'    :    heightReset,
        //队列开始上传触发
        'onUploadStart'        :   heightFit, */
        //单个文件上传成功触发
        'onUploadSuccess':function(file, data, response){        	
        	//刷新目录
        	var orginFileName = JSON.parse(data).orginFileName;        		
        	var attachFilePath = JSON.parse(data).attachFilePath;
        	var attachFilePaths="${ctx}"+attachFilePath;
        	//attachFilePath="${ctx}"+attachFilePath;
        	//console.info(attachFilePath);
        	var html='<a  href='+attachFilePaths+' target="_blank">'+orginFileName+'</a>';
        	$('#filename').html(html);
        	$('#filename_hidden').val(orginFileName);
        	$('#filepath_hidden').val(attachFilePath);
        }
    });
}
function uploadsave(){
	var flag="false";
	var id=$('#detilid-hidden').val();
	var filepath=$('#filepath_hidden').val();
	if(filepath==''){
		bootbox.alert('请上传附件！');	
		return;
	}else{
		//console.info(filepath);
		bootbox.confirm({ 
		  size: "small",
		  message: "确定要保存该附件信息?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : '${ctx}/commonSetting/appVersion/updateFilePath',
						data : JSON.stringify({
							id : id,
							appFilePath : filepath
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "保存成功！", 
									  callback: function(result){
										  if(result){
											  flag="true";
											  location.reload();
										  }else{
											 location.reload();  
										  }
									  }
								 });
								setTimeout(function(){
									if(flag=="false"){
										location.reload();
										 $('.bootbox').modal('hide');
									}
								},3000);
							} else {
								bootbox.alert(data.msg);
							}
							
						}
						
					});
			  }
		  }
		})
		
	}
}
function uploadrefresh(){
	$('#modal-upload').modal('hide');	
	
}
</script>



</body>
</html>






