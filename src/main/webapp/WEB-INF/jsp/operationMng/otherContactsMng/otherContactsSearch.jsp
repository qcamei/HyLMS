
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
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
</head>
<body class="white-bg">
<div class="page-content">
	<div class="page-header">
		<h1>
			查询管理
			<small>
				<i class="icon-double-angle-right"></i>
				其它往来查询
			</small>
		</h1>
	</div><!-- /.page-header -->
	<div class="page-content">
		<div class="searchbox col-xs-12">
		   <label class="title">类型：</label>
		    <select id="fom_type" class="form-box" style="width: 140px;">
			   <option value="">请选择类型</option>
			   <option value="0">收入</option>
			   <option value="1">支出</option>
		   	</select>
		   	<label class="title" style="float:left;">借款/收款时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:30px; margin-left: 5px;height:35px;line-height:35px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;margin-right: 5px;width:39px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 175px;margin-right:30px;margin-left: 5px;height:35px;line-height:35px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入时间" style="height:35px;line-height:35px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		</div>
		<div class="searchbox col-xs-12">
		   <label class="title">借款人/收款人：</label>
		    <input id="fom_operateUser" class="form-box" type="text" placeholder="请填写借款人/收款人"/>
		   	<label class="title">事由：</label>
		    <input id="fom_name" class="form-box" type="text" placeholder="请填写事由"/>
			<a class="itemBtn m-lr5" onclick="searchInfo()">查询</a>
			<a class="itemBtn m-lr5" onclick="doprint()">打印</a>
			<a class="itemBtn m-lr5" onclick="doexport()">导出</a>
		</div>
		<div class="detailInfo">		
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
                    <th>借款/收款人</th>
                    <th>借款/收款时间</th>
                    <th>金额</th>
                    <th>事由</th>                   
                    <th>提醒时间</th>
                    <th>备注</th>
                    <th>状态</th> 
                    <th>创建人</th>
                    <th>创建时间</th>                                                         
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
			<div id="sumCount" class="sumCount">
			   <p class="sumInfo">当页总计(元)：<span id="localSum"></span></p>
			   <p class="sumInfo">费用总计(元)：<span id="allSum" ></span></p>
			</div>
			<!-- 查看  modal begin-->
			<div class="modal fade" id="modal-einfo" tabindex="-1" role="dialog" data-backdrop="static">
				<div class="modal-header" style="padding:3px 10px;">
					<button class="close" type="button" data-dismiss="modal" onclick="viewrefresh()" style="margin-top:10px;">×</button>
					<h3 id="myModalLabel">查看其它往来信息</h3>
				</div>
				<div class="modal-body">
				   <div>
					  <div class="widget-box dia-widget-box">
							<div class="widget-body">
								<div class="widget-main">
							<div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>类型：</label>
							     <div class="col-xs-8">
							      <p class="form-control no-border" id="stype"></p>
							     </div>
							  </div>
							  <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>借款/收款人：</label>
							     <div class="col-xs-8">
							       <p class="form-control no-border" id="soperateUser"></p>
							     </div>
							 </div>
							   <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>借款/收款时间：</label>
							     <div class="col-xs-8">
							       <p class="form-control no-border" id="soperateTime"></p>
							     </div>						    
							  </div>
							   <hr class="tree"></hr>
							   <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>金额：</label>
							     <div class="col-xs-8">
							       <p class="form-control no-border" id="samount"></p>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
							     <label class="title col-xs-4"><span class="red">*</span>事由：</label>
							     <div class="col-xs-8" style="margin-bottom: 10px;">
							       <p class="form-control no-border" id="sname"></p>
							     </div>
							 </div>
							 <hr class="tree"></hr>
							 
							 
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4">到期提醒时间 ：</label>
							     <div class="col-xs-8">
							       <p class="form-control no-border" id="snoticeTime"></p>
							     </div>								    
							  </div>
							 <hr class="tree"></hr>
							 <div class="add-item col-xs-12">
								      <label class="title col-xs-4">附件上传：</label>
								      <div class="col-xs-8" style="border:0;height:auto;">
                                         <label id="sfilename"></label>
								      </div>
								      <div class="clear"></div>
                             </div>
                              <hr class="tree"></hr>
							  <div class="add-item col-xs-12">
							     <label class="title col-xs-4" >备注 ：</label>
							      <div class="col-xs-8">
							        <p class="form-control no-border" id="smark"></p>
							     </div>
							  </div>													  					  
							    <hr class="tree"></hr>
								  <div class="add-item-btn" id="viewBtn" style="display:block;">
								    <a class="add-itemBtn btnOk" onclick="viewrefresh()" style="margin-left: 130px;">关闭</a>
								  </div>
								</div>
						  </div>
					</div>
				</div>
				</div>
			
			</div>
			<!-- 查看  modal  end -->
		</div>
	</div>
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>其他往来信息记录表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>类型</th>
                    <th>借款/收款人</th>
                    <th>借款/收款时间</th>
                    <th>金额</th>
                    <th>事由</th>                   
                    <th>提醒时间</th>
                    <th>备注</th>
                    <th>状态</th> 
                    <th>创建人</th>
                    <th>创建时间</th>                                                          
				</tr>
		    </thead>
		    <tbody>
		    </tbody>
		  </table>
		  <div id="footerInfo"><h3>盐城辉宇物流有限公司  制</h3></div>
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
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
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
		 "sAjaxSource": "${ctx}/operationMng/otherContactsMng/getListData" , //获取数据的ajax方法的URL							 
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
		    {data: "operateUser","width":"6%"},
		    {data: "operateTime","width":"8%"},	
		    {data: "amount","width":"5%"},
		    {data: "name","width":"9%"},
		    {data: "noticeTime","width":"8%"},
		    {data: "mark","width":"10%"},
		    {data: "status","width":"8%"},
		    {data: "insertUserName","width":"5%"},
		    {data: "insertTime","width":"10%"},		   		       
		    {data: null,"width":"14%"}],
		    columnDefs: [{
				 //入职时间
				 targets: 1,
				 render: function (data, type, row, meta) {
					if(data=='0'){
						return '收入';
					}else if(data=='1'){
						return '支出';
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
					}else if(data=='2'){
						return '已完成';
					}else{
						return '';
					}
			       }	       
			},{
				 //入职时间
				 targets: 3,
				 render: function (data, type, row, meta) {
					 if(data!=''&&data!=null){
						 return jsonForDateFormat(data);
					 }else{
						 return '';
					 }
					
			       }	       
			},{
					 //入职时间
					 targets: 6,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonForDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},{
					 //入职时间
					 targets: 10,
					 render: function (data, type, row, meta) {
						 if(data!=''&&data!=null){
							 return jsonDateFormat(data);
						 }else{
							 return '';
						 }
						
				       }	       
				},{
			    	 //操作栏
			    	 targets: 11,
			    	 render: function (data, type, row, meta) {
			    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	 
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
		 "sAjaxSource": "${ctx}/operationMng/otherContactsMng/getListData", //获取数据的ajax方法的URL	
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
						    {data: "operateUser","width":"6%"},
						    {data: "operateTime","width":"8%"},	
						    {data: "amount","width":"5%"},
						    {data: "name","width":"9%"},
						    {data: "noticeTime","width":"8%"},
						    {data: "mark","width":"10%"},
						    {data: "status","width":"8%"},
						    {data: "insertUserName","width":"5%"},
						    {data: "insertTime","width":"10%"},		   		       
						    {data: null,"width":"14%"}],
						    columnDefs: [{
								 //入职时间
								 targets: 1,
								 render: function (data, type, row, meta) {
									if(data=='0'){
										return '收入';
									}else if(data=='1'){
										return '支出';
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
									}else if(data=='2'){
										return '已完成';
									}else{
										return '';
									}
							       }	       
							},{
								 //入职时间
								 targets: 3,
								 render: function (data, type, row, meta) {
									 if(data!=''&&data!=null){
										 return jsonForDateFormat(data);
									 }else{
										 return '';
									 }
									
							       }	       
							},{
									 //入职时间
									 targets: 6,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonForDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},{
									 //入职时间
									 targets: 10,
									 render: function (data, type, row, meta) {
										 if(data!=''&&data!=null){
											 return jsonDateFormat(data);
										 }else{
											 return '';
										 }
										
								       }	       
								},{
							    	 //操作栏
							    	 targets: 11,
							    	 render: function (data, type, row, meta) {
							    			 return '<a class="table-edit" onclick="doview('+ row.id +')">查看</a>';	
						                    
						                }	       
						    	} 
						      ],
					        "fnServerData":retrieveData //与后台交互获取数据的处理函数
    });
}

$(function(){
	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	init();
})
/* 数据交互 */
function retrieveData( sSource, aoData, fnCallback ) {
	   var secho=aoData[0]["value"];   
	   var pageStartIndex=aoData[3]["value"];
	   var pageSize=aoData[4]["value"];
	   var type=$("#fom_type").val(); 
	   var name=$("#fom_name").val(); 
	   var operateUser=$("#fom_operateUser").val(); 
	   var startTime=$("#startTime").val(); 
	   var endTime=$("#endTime").val(); 
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
				name :$.trim(name),
				operateUser :$.trim(operateUser),
				startTime :$.trim(startTime),
				endTime :$.trim(endTime)
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {								
					obj.iTotalDisplayRecords=data.data.totalCounts;
					obj.iTotalRecords=data.data.totalCounts;
					obj.aaData=data.data.records;		
					obj.sEcho=data.data.frontParams;
					var sum=0;
					var allsum=0;
					var income=0;
					var outcome=0;
					var allincome=data.inCount;
					var alloutcome=data.outCount;
					if(obj.aaData.length>0){
						for(var i=0;i<obj.aaData.length;i++){
							obj.aaData[i]["rownum"]=i+1;
							if(obj.aaData[i]["type"]=='0'){
								income+=parseFloat(obj.aaData[i]["amount"]);
							}else{
								outcome+=parseFloat(obj.aaData[i]["amount"]);
							}
						}
					}else{
						obj.aaData=[];
					}
					allsum=parseFloat(parseFloat(allincome).toFixed(2)-parseFloat(alloutcome).toFixed(2)).toFixed(2);
					sum=parseFloat(income.toFixed(2)-outcome.toFixed(2)).toFixed(2);
					fnCallback(obj); //服务器端返回的对象的returnObject部分是要求的格式  	
					$('#localSum').html('收入'+income.toFixed(2)+'-支出'+outcome.toFixed(2)+' ='+sum);
					$('#allSum').html('收入'+parseFloat(allincome).toFixed(2)+'-支出'+parseFloat(alloutcome).toFixed(2)+' ='+allsum);
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

function doview(id){
	var pathHtml="";
	$.ajax({
		type : 'GET',
		url : "${ctx}/operationMng/otherContactsMng/getById/"+id,
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {	
				var type=data.data.type;
				if(type=='0'){
					type="收入";
				}else if(type=='1'){
					type="支出";
				}
				$('#stype').html(type);
				$('#sname').html(data.data.name);
				$('#smark').html(data.data.mark);	
				$('#soperateUser').html(data.data.operateUser);	
				if(data.data.operateTime!=''&&data.data.operateTime!=null){
					$('#soperateTime').html(jsonForDateFormat(data.data.operateTime));	
				}else{
					$('#soperateTime').html('');	
				}
				if(data.data.noticeTime!=''&&data.data.noticeTime!=null){
					$('#snoticeTime').html(jsonForDateFormat(data.data.noticeTime));	
				}else{
					$('#snoticeTime').html('');	
				}
				if(data.data.attachFilePath!=null && data.data.attachFilePath!=''){
					 path=data.data.attachFilePath
					 arr = path.split(';');
					 if(arr!=null && arr!="" && arr.length>0){
						 for(var k=0;k<arr.length;k++){
							 var attachFilePaths="${ctx}"+arr[k];
							 pathHtml+='<p><a href='+attachFilePaths+' target="_blank">凭证'+(k+1)+'</a></p>';
						 }
						 
					 }
					 $('#sfilename').html(pathHtml);
				}else{
					$('#efilename').html('');
				}
				$('#samount').html(data.data.amount);
				$('#modal-einfo').modal('show');
				
			} else {
				bootbox.alert(data.msg);				
			}
		}
		
	}); 
}
function viewrefresh(){
	$('#modal-einfo').modal('hide');	
}

function clearupload(){
	$('#detilid-hidden').val('');
	$('#finishmark').val('');
}
function dofinish(id){
	clearupload();
	$('#uploadBtn').show();
	$('#detilid-hidden').val(id);
	$('#modal-upload').modal('show');
}
function finishsave(){
	var flag="false";
	var id=$('#detilid-hidden').val();
	var mark=$('#finishmark').val();
	if(mark==''){
		bootbox.alert('备注不能为空！');	
		return;
	}
	bootbox.confirm({ 
		  size: "small",
		  message: "确定要确认吗?", 
		  callback: function(result){
			  if(result){
				  $.ajax({
						type : 'POST',
						url : '${ctx}/operationMng/otherContactsMng/finish',
						data : JSON.stringify({
							id : id,
							mark : mark
						}),
						contentType : "application/json;charset=UTF-8",
						dataType : 'JSON',
						success : function(data) {
							if (data && data.code == 200) {
								bootbox.confirm_alert({ 
									  size: "small",
									  message: "确认成功！", 
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
function finishrefresh(){
	$('#modal-upload').modal('hide');	
}

/* 导出 */
function doexport()
{
	   var type=$('#fom_type').val();
	   var name=$('#fom_name').val();
	   var operateUser=$('#fom_operateUser').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var status='';
	   if(type=='' || type==null || type=='-1'){
		   type='';
	   }
	   var form = $('<form action="${ctx}/operationMng/otherContactsMng/export" method="post"></form>');
	   var typeInput = $('<input id="type" name="type" value="'+type+'" type="hidden" />');
	   var nameInput = $('<input id="name" name="name" value="'+name+'" type="hidden" />');	   
	   var operateUserInput = $('<input id="operateUser" name="operateUser" value="'+operateUser+'" type="hidden" />');
	   var startTimeInput = $('<input id="startTime" name="startTime" value="'+startTime+'" type="hidden" />');
	   var endTimeInput = $('<input id="endTime" name="endTime" value="'+endTime+'" type="hidden" />');
	   var statusInput = $('<input id="status" name="status" value="'+status+'" type="hidden" />');
	   form.append(typeInput);
	   form.append(nameInput);
	   form.append(operateUserInput);
	   form.append(startTimeInput);
	   form.append(endTimeInput);
	   form.append(statusInput);
	   $('body').append(form);
	   form.submit();
}
/* 打印功能 */
function doprint(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
       var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
       var localTime= date.getFullYear() + "-" + month + "-" + day+ " " + hours + ":" + minutes + ":" + seconds;
	   var html="";
	   var type=$('#fom_type').val();
	   var name=$('#fom_name').val();
	   var operateUser=$('#fom_operateUser').val();
	   var startTime=$('#startTime').val();
	   var endTime=$('#endTime').val();
	   var status='';
	   if(type=='' || type==null || type=='-1'){
		   type='';
	   }
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/operationMng/otherContactsMng/print",
			data : JSON.stringify({
				type : type,
				name : name,
				operateUser :operateUser,
				startTime :startTime,
				endTime :endTime
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["type"]=='0'){
								data.data[i]["type"]='收入';
							}else{
								data.data[i]["type"]='支出';
							}
							
							if(data.data[i]["status"]=='0'){
								data.data[i]["status"]='新建';
							}else if(data.data[i]["status"]=='1'){
								data.data[i]["status"]='已提交';
							}else{
								data.data[i]["status"]='已完成';
							}
							if(data.data[i]["operateTime"]==null || data.data[i]["operateTime"]=='' || parseInt(data.data[i]["operateTime"])<0){
								data.data[i]["operateTime"]=''; 
							 }else{
								 data.data[i]["operateTime"]=jsonForDateFormat(data.data[i]["operateTime"]);
							 }
							if(data.data[i]["noticeTime"]==null || data.data[i]["noticeTime"]=='' || parseInt(data.data[i]["noticeTime"])<0){
								data.data[i]["noticeTime"]=''; 
							 }else{
								 data.data[i]["noticeTime"]=jsonForDateFormat(data.data[i]["noticeTime"]);
							 }
							if(data.data[i]["insertTime"]==null || data.data[i]["insertTime"]=='' || parseInt(data.data[i]["insertTime"])<0){
								data.data[i]["insertTime"]=''; 
							 }else{
								 data.data[i]["insertTime"]=jsonDateFormat(data.data[i]["insertTime"]);
							 }
							if(data.data[i]["insertUserName"]=='' || data.data[i]["insertUserName"]==null){
								data.data[i]["insertUserName"]='';
							}
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["type"]+'</td>'
							    +'<td>'+data.data[i]["operateUser"]+'</td>'
							    +'<td>'+data.data[i]["operateTime"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["name"]+'</td>'
							    +'<td>'+data.data[i]["noticeTime"]+'</td>'
							    +'<td>'+data.data[i]["mark"]+'</td>'							    							    
							    +'<td>'+data.data[i]["status"]+'</td>'
							    +'<td>'+data.data[i]["insertUserName"]+'</td>'
							    +'<td>'+data.data[i]["insertTime"]+'</td></tr>';	
						      
						}
						$('#localTime').html(localTime);
						$('#myDataTable tbody').html(html);
					      doprintForm();
					}else{
						bootbox.alert('暂无可打印的数据！');
						return;
					}
					 
				} else {
					 bootbox.alert(data.msg);
				}
				
			}
		}); 
	  
	   
}

function doprintForm(){
		var html=$("#printTable").html();
		$('#breadcrumbs').hide();
		$('.page-content').hide();
		$('#printTable').show();
		$("#myDataTable").printTable({
		 header: "#headerInfo",
         footer: "#footerInfo",
		 mode: "rowNumber",
		 pageSize: 23
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }
</script>



</body>
</html>






