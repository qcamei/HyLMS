<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>折损车库存管理</title>
	<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" /><!--字体icon-->
		<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
		<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
		<script src="${ctx}/staticPublic/js/ace-extra.min.js"></script>
</head>
<body class="white-bg">
		<div class="page-content">
		<div class="page-header">
			<h1>
				查询管理
				<small>
					<i class="icon-double-angle-right"></i>
					折损出入库查询
				</small>
			</h1>
		</div><!-- /.page-header -->
		<div class="page-content">
				<div class="searchbox col-xs-12">
			 <label class="title" style="float: left;height: 34px;line-height: 34px;">操作时间：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:15px; margin-left: 2px;height: 34px;line-height: 34px;">
				<input class="form-control" id="startTime" type="text" placeholder="请输入开始时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width:25px;margin-left: 20px;margin-right: 20px;">到</label>
		   <div class="input-group input-group-sm" style="float: left;width: 200px;margin-right:20px;height: 34px;line-height: 34px;">
				<input class="form-control" id="endTime" type="text" placeholder="请输入结束时间" style="height: 34px;line-height: 34px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>	
			<label class="title">类型：</label>
		    <select id="type" class="form-box" style="width:200px;">
		      <option value="0" selected>入库</option>
		      <option value="1">出库</option>
		    </select>		  
		   <input type="hidden" id="secho" name="secho">
		  
		   <a class="itemBtn" onclick="dosearch()">查询</a>		
		</div>
		<div class="detailInfo">
		<table id="dynamic-table" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>类型</th>
                    <th>出入库时间</th>
                    <th>操作人</th>
                    <th>状态</th>
                    <th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
		    <div class="modal fade" id="modal-add" tabindex="-1" role="dialog" aria-hidden="false" data-backdrop="static">
			   <div class="modal-dialog" style="padding-top:5%;">
				  <div class="modal-content">
					<div class="modal-header" style="padding:3px 10px;">
						<button class="close" type="button" data-dismiss="modal">×</button>
						<h3 id="myModalLabel">折损出入库明细查看</h3>
					</div>
					<div class="modal-body">
					   <div>
						  <div class="widget-box dia-widget-box">
								<div class="widget-body">
									<div class="widget-main">	
										<input type="hidden" id="idText">
									 	<table id="detailtable" class="table table-striped table-bordered table-hover">
					                      <thead>
						                   <tr>	
							               <th>序号</th>
							               <th>品牌</th>
							               <th>车架号</th>
							               <th>车型</th>
							               <th>颜色</th>
							               <th>发动机</th>
							               <th>位置</th>
		                                   <th>买断金额或卖出价格</th>
		                                   <th>备注</th>
						                    </tr>
					                      </thead>
					                      <tbody>
					                      </tbody>
					                      </table>							   			  
									    							 
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
</div>


<!--[if !IE]> -->
		<script src="${ctx}/staticPublic/js/jquery-2.0.3.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
		<script src="${ctx}/staticPublic/js/jquery-1.10.2.min.js"></script>
		<![endif]-->
		<script src="${ctx}/staticPublic/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="${ctx}/staticPublic/js/jquery.dataTables.js"></script>
		<script src="${ctx}/staticPublic/js/jquery.dataTables.bootstrap.js"></script>
		<!-- ace scripts -->
		<script src="${ctx}/staticPublic/js/ace-elements.min.js"></script>
		<script src="${ctx}/staticPublic/js/ace.min.js"></script>		
		<!-- inline scripts related to this page -->
		<script type="text/javascript" src="${ctx}/staticPublic/js/popbox/Confirm.js"></script>
        <script src="${ctx}/staticPublic/js/bootbox.min.js"></script>
        <script src="${ctx}/staticPublic/js/jsonDataFormat.js"></script>
        <script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
        <script src="${ctx}/staticPublic/js/date-time/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
	var myTable = loadTable();
/* 	$("#startTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	});
	$("#endTime").datepicker({
		language: 'cn',
        autoclose: true,//选中之后自动隐藏日期选择框
        format: "yyyy-mm-dd"//日期格式
	}); */
	
	 $("#startTime").datetimepicker({
			language: 'cn',
		      format: "yyyy-mm-dd hh:ii",
		      autoclose: true,//选中之后自动隐藏日期选择框
		      todayBtn: true
		});
	 
	 $("#endTime").datetimepicker({
			language: 'cn',
		      format: "yyyy-mm-dd hh:ii",
		      autoclose: true,//选中之后自动隐藏日期选择框
		      todayBtn: true
		});
});

function loadTable(){
	$('#dynamic-table').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageMng/getAdminInOutList" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "type"},
		    {data: "insertTime"},
		    {data: "userName"},
		    { data: "status"},
		    { data: null}],
		    columnDefs: [
			{
	 			//指定第1列
	 			targets: 1,
       			render: function(data, type, row, meta) 
       			{
       				if(data==0){return '入库'}else if(data==1){return '出库'};
       			}	       
			},
			{
	 			//指定第4列
	 			targets: 2,
       			render: function(data, type, row, meta) 
       			{
       				if(data != null){return format(data,'yyyy-MM-dd HH:mm:ss')} else {return ""};
       			}	       
			},
		    {
		    	 //指定第6列
		    	 targets: 4,
			        render: function(data, type, row, meta) {
			        	if(data==0){return '新建'}else if(data==1){return '待复核'}else if(data==2){return '已完成'};
			        }	       
		    },
		    {
		    	 //指定第7列
		    	 targets: 5,
			        render: function(data, type, row, meta) {
			        	if(row.status!=0){return '<a class="table-edit" style="width:70px" onclick="doview('+ row.id +')">查看明细</a>'};
			        }	       
		    }],
	        "fnServerData":retrieveData //与后台交互获取数据的处理函数
  } );
}

//datatables与后台交互获取数据的处理函数
function retrieveData( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info('aaa:'+$('#attName').val());
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : sSource,
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			startTime : $.trim($('#startTime').val()),
			endTime : $.trim($('#endTime').val()),
			/* businessId : $.trim($('#waybill').val()), */
			type : $.trim($('#type').val())
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));								
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
			//	console.log(JSON.stringify(obj));
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
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	}); 
}

//日期格式化
var format = function(time, format){
    var t = new Date(time);
    var tf = function(i){return (i < 10 ? '0' : '') + i};
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
        switch(a){
            case 'yyyy':
                return tf(t.getFullYear());
                break;
            case 'MM':
                return tf(t.getMonth() + 1);
                break;
            case 'mm':
                return tf(t.getMinutes());
                break;
            case 'dd':
                return tf(t.getDate());
                break;
            case 'HH':
                return tf(t.getHours());
                break;
            case 'ss':
                return tf(t.getSeconds());
                break;
        }
    })
}

function dosearch(){
	 loadTable();	
}

function loadDeatilTable(){
	$('#detailtable').DataTable( {
		"destroy": true,//如果需要重新加载的时候请加上这个
		 dom: 'Bfrtip',
		 "bLengthChange": false,//屏蔽tables的一页展示多少条记录的下拉列表
		 "bFilter": false,    //不使用过滤功能  
		 "bProcessing": true, //加载数据时显示正在加载信息
		 "bServerSide": true, //指定从服务器端获取数据
		 "sAjaxSource": "${ctx}/operationMng/carDamageMng/getDetailByParentId" , //获取数据的ajax方法的URL							 
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
		 columns: [{ data: "rownum" },
		    {data: "brand"},
		    {data: "vin"},
		    {data: "model"},
		    {data: "color"},
		    {data: "engineNo"},
		    {data: "position"},
		    {data: "amount"},
		    {data: "mark"}],
		    columnDefs: [
		     ],
	        "fnServerData":retrieveDataDetail //与后台交互获取数据的处理函数
  } );
}

//datatables与后台交互获取数据的处理函数
function retrieveDataDetail( sSource, aoData, fnCallback ) {   
   var secho=aoData[0]["value"];   
   var pageStartIndex=aoData[3]["value"];
   var pageSize=aoData[4]["value"];
   //console.info('aaa:'+$('#attName').val());
   $('#secho').val(secho);
   var obj = {};
	 $.ajax({
		type : 'POST',
		url : sSource,
		data : JSON.stringify({
			sEcho : $.trim(secho),				
			pageStartIndex : $.trim(pageStartIndex),
			pageSize : $.trim(pageSize),
			parentId : $.trim($('#idText').val())
		}),
		contentType : "application/json;charset=UTF-8",
		dataType : 'JSON',
		success : function(data) {
			if (data && data.code == 200) {
				//console.log(JSON.stringify(data.data));								
				obj.iTotalDisplayRecords=data.data.totalCounts;
				obj.iTotalRecords=data.data.totalCounts;
				obj.aaData=data.data.records;		
				obj.sEcho=data.data.frontParams;
			//	console.log(JSON.stringify(obj));
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
				//jQuery.messager.alert('提示:',data.msg,'info');selected="selected" 
			}
			
		}
	}); 
}

function doview(id)
{
	$('#idText').val(id);
	$('#modal-add').modal('show');
	loadDeatilTable();
}
</script>

</body>
</html>