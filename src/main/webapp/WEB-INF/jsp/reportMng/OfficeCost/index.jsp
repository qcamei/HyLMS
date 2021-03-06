<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承运商往来款查询</title>
<!-- basic styles -->
<link href="${ctx}/staticPublic/css/bootstrap.min.css" rel="stylesheet" />
<!-- page specific plugin styles -->
<!-- ace styles -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/ace.min.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.min.css" />
<!-- inline styles related to this page -->
<link rel="stylesheet" href="${ctx}/staticPublic/css/main.min.css" />
<%-- <link rel="stylesheet" href="${ctx}/staticPublic/css/bootstrap-datetimepicker.css" /> --%>
<link rel="stylesheet" href="${ctx}/staticPublic/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/datetimepicker.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/print.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/js/uploadify/uploadify.css" />
<link rel="stylesheet" href="${ctx}/staticPublic/css/font-awesome.css" />
<!-- ace settings handler -->
<script type="text/javascript" src="${ctx}/staticPublic/js/ace-extra.min.js"></script><!--要预先加载ace的js-->
<style type="text/css">
#modal-view{
    width: 600px;
    height: 600px;
    margin: auto;
    background: rgb(255, 255, 255);
    overflow: auto;
    }  
    .boldadd{
    font-weight:bold;
    }
</style>
</head>
<body class="white-bg">
<div id="loading" style="display:none;position:absolute;z-index:9999;height:30px;width:200px;top:30%;left:50%;margin-left:-150px;text-align:center;border: solid 2px #86a5ad">
		<i class="fa fa-spinner fa-spin"></i>数据加载中......
		</div>
<div class="page-content">
	<div class="page-header">
		<h1>
			报表查询
			<small>
				<i class="icon-double-angle-right"></i>
				办公费用查询
			</small>
		</h1>
	</div>
	<div class="page-content">
		<div class="searchbox col-xs-12">
		    <label class="title" style="float: left;height: 34px;line-height: 34px;width: 75px;">月份：</label>
		    <div class="input-group input-group-sm" style="float: left;width: 180px;height:34px;margin-right:30px; margin-left: 5px;">
				<input class="form-control" id="applyDate" type="text" placeholder="请输入时间" style="height: 34px;font-size: 14px;"/>
					<span class="input-group-addon">
						<i class="icon-calendar"></i>
					</span>
			</div>		   
			<a class="itemBtn"  onclick="searchInfo()">查询</a>			
			<a class="itemBtn"  onclick="printInfo()">打印</a>
			<a class="itemBtn"  onclick="exportInfo()">导出</a>	
		</div>		
		<div class="detailInfo">
		<table id="detailtable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>														
					<th>序号</th>
					<th>归集项目</th>
                    <th>归属部门</th>
                    <th>本月金额</th>
                    <th>累计金额</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			</table>						
		</div>
	</div>
</div>
<!-- 打印 -->
<div class="printTable" id="printTable">
     <div id="print-content" class="printcenter">
			<div id="headerInfo">
				<h2>办公费用归集汇总表</h2>
				<p id="localTime" style="text-align: right;"></p>
			</div>
		  <table id="myDataTable" class="table myDataTable">
		    <thead>
		      <tr>														
					<th>序号</th>
					<th>归集项目</th>
                    <th>归属部门</th>
                    <th>本月金额</th>
                    <th>累计金额</th>                                              
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
<script src="${ctx}/staticPublic/js/date-time/bootstrap-datetimepicker.js"></script>
<script src="${ctx}/staticPublic/js/jquery.printTable.js"></script>
<script src="${ctx}/staticPublic/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
//对浏览器进行判别,判断是否使用的是ie内核
var isIe = (document.all) ? true : false;


//创建渐变的背景层
function showBackDIV() {
	var bWidth =$(document).width();//parseInt(document.body.scrollWidth);
	var bHeight =$(document).height();//parseInt(document.body.scrollHeight);

	var back = document.createElement("div");
	back.id = "back";
	var styleStr = "top:0px;left:0px;position:absolute;z-index:9998;background:gray;width:" + bWidth + "px;height:" + bHeight + "px;";
	styleStr += (isIe) ? "filter:alpha(opacity=0);" : "opacity:0;";
	back.style.cssText = styleStr;
	document.body.appendChild(back);
	showBackground(back, 20);
}

//让背景渐渐变暗
function showBackground(obj, endInt) {
	if (isIe) {
		obj.filters.alpha.opacity += 1;
		if (obj.filters.alpha.opacity < endInt) {
			setTimeout( function() {
				showBackground(obj, endInt)
			}, 1);	//1秒
		}
	} else {
		var al = parseFloat(obj.style.opacity);
		al += 0.01;
		obj.style.opacity = al;
		if (al < (endInt / 100)) {
			setTimeout( function() {
				showBackground(obj, endInt)
			}, 1);
		}
	}
}
function init(){
	showBackDIV();
	$("#loading").show();
	$.ajax({
		type : 'POST',
		url : "${ctx}/reportMng/officeCost/getReportData",
		dataType : 'JSON',
		contentType : "application/json;charset=UTF-8",
		data : JSON.stringify({
			applyDate : $.trim($('#applyDate').val())
		}),
		success : function(data) {
			$("#loading").hide();
			$("#back").remove();
			if (data&& data.code == 200) {
				//console.log(JSON.stringify(data.data));
				if (data.data.length > 0) {
					var amount=0;
					var sumAmount=0;
					for (var i = 0; i < data.data.length; i++) {
						data.data[i]["rownum"] = i + 1;
						data.data[i]["typeNames"]=data.data[i]["typeName"];
					if(i>0){
						if(data.data[i]["typeName"]==data.data[i-1]["typeName"]){
							data.data[i]["typeNames"]="";
						}
					}
						amount+=data.data[i]["amount"];
						sumAmount+=data.data[i]["sumAmount"];
					}
				
					var objItem={};
					objItem.typeName='';
					objItem.typeNames='合计';
					objItem.rownum=data.data.length+1;
					objItem.amount=amount;
					objItem.sumAmount=sumAmount;
					objItem.departmentName="";
					data.data.push(objItem);
					$('#detailtable').dataTable({
										"destroy" : true,//如果需要重新加载需销毁
										dom : 'Bfrtip',
										"bLengthChange" : false,//屏蔽tables的一页展示多少条记录的下拉列表
										"bFilter" : false, //不使用过滤功能  
										"bProcessing" : true, //加载数据时显示正在加载信息	
										"bPaginate" : false,
										"bInfo" : false,
										ordering : false,
										"oLanguage" : {
											"sZeroRecords" : "抱歉， 没有找到",
											"sInfoEmpty" : "没有数据",
											"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
											"sZeroRecords" : "没有检索到数据"
										},
										data : data.data,
										//使用对象数组，一定要配置columns，告诉 DataTables 每列对应的属性
										//data 这里是固定不变的，name，position，salary，office 为你数据里对应的属性
										columns: [{ data: "rownum","width":"6%"},
						                          {data: "typeNames","width":"14%","class":"boldadd"},
						                          {data: "departmentName","width":"14%"},
						                          {data: "amount","width":"14%"},
						                          {data: "sumAmount","width":"14%"}]
									});
				}
			} else {
				bootbox.alert(data.msg);
			}
		}

	});


}

function searchInfo(){
	init();
}
$(function(){
	$("#applyDate").datetimepicker({
		language: 'cn',
        format: 'yyyy-mm',
        weekStart: 1,  
        autoclose: true,  
        startView: 3,  
        minView: 3,  
        forceParse: false
    });
	  var date = new Date();
      var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
      /* var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
      var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
      var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
      var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds(); */
      var localTime= date.getFullYear() + "-" + month /* + "-" + day+" "+hours+":"+minutes */;
	  $('#applyDate').val(localTime);
	init();
	
});

/* 打印功能 */
function printInfo(){
	   var date = new Date();
       var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    /*    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
       var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
       var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
       var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds(); */
       var localTime= date.getFullYear() + "-" + month /* + "-" + day+ " " + hours + ":" + minutes + ":" + seconds */;
       var applyDate=$('#applyDate').val();
	   var html="";
	   $.ajax({
		    type : 'POST',
			url : "${ctx}/reportMng/officeCost/getReportData",
			data : JSON.stringify({
				applyDate : $.trim($('#applyDate').val())
			}),
			contentType : "application/json;charset=UTF-8",
			dataType : 'JSON',
			success : function(data) {
				if (data && data.code == 200) {					
					if(data.data.length>0){
						var amount=0;
						var sumAmount=0;
						var count=0;
						var newArray = [];
						for(var i=0;i<data.data.length;i++){
							data.data[i]["rownum"]=i+1;
							if(data.data[i]["typeName"]==null || data.data[i]["typeName"]==''){
								data.data[i]["typeName"]=''; 
							 }
							if(data.data[i]["departmentName"]==null || data.data[i]["departmentName"]==''){
								data.data[i]["departmentName"]=''; 
							 }
							data.data[i]["typeNames"]=data.data[i]["typeName"];
                             if(i>0){
                            	 if(data.data[i]["typeName"]==data.data[i-1]["typeName"]){
                            		 count=count+1;
                            		 data.data[i]["typeNames"]="";
                            	 }else{
                            		 newArray.push(count);
                            		 count=0;
                            	 }
                             }
							amount+=data.data[i]["amount"];
							sumAmount+=data.data[i]["sumAmount"];
							
								html+='<tr><td>'+data.data[i]["rownum"]+'</td>'
							    +'<td>'+data.data[i]["typeNames"]+'</td>'
							    +'<td>'+data.data[i]["departmentName"]+'</td>'
							    +'<td>'+data.data[i]["amount"]+'</td>'
							    +'<td>'+data.data[i]["sumAmount"]+'</td></tr>';							   
						      
						}
						//console.info(JSON.stringify(newArray));
						var length=parseInt(data.data.length)+1;
						html+='<tr><td>'+length+'</td>'
					    +'<td>合计</td>'
					    +'<td></td>'
					    +'<td>'+amount+'</td>'
					    +'<td>'+sumAmount+'</td></tr>';		
						$('#localTime').html(applyDate);
						$('#myDataTable tbody').html(html);
					    //  doprintForm();
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
		 pageSize: 15
	});
		javasricpt:window.print();
		$('#breadcrumbs').show();
		$('.page-content').show();
		$('#printTable').hide();
		$("#printTable").html(html);
	 }

/* 导出 */
function exportInfo()
{
	   var applyDate=$('#applyDate').val();
	   var form = $('<form action="${ctx}/reportMng/officeCost/export" method="POST"></form>');
	   var applyDateInput = $('<input id="applyDate" name="applyDate" value="'+applyDate+'" type="hidden" />');   
	   form.append(applyDateInput);
	   $('body').append(form);
	   form.submit();
}
</script>

</body>
</html>