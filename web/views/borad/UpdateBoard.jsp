<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/views/common/header.jsp"%>
    <%@ page import="com.borad.model.vo.Board" %>
<%

	Board b=(Board)request.getAttribute("b");
 %>
 <script src="//cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>   
<style>
	ul, li{
		margin:0;
		padding:0;
		list-style-type:none;
	}
	#subject{
		width:100%;
	}
	.title_input{
		overflow: hidden;
		padding: 15px 3px 11px;
		border-bottom: 1px solid #e9eaeb;
		clear: both;
		margin: 0;
	}
	.title_input textarea{
		padding: 0;
		width: 80%;
		border: 0;
		font-size: 21px;
		line-height: 24px;
		resize: none;
		outline: none;
	}
	.btn{
		border-top: 1px solid #f5f5f5;
		margin: 0;
		padding: 0;
	}
	.btnbtn{
		display: inline-block;
		border: 0;
		padding: 0;
		text-align: right;
		line-height: 48px;
		background: transparent;
		font-size: 16px;
		color: #333;
		cursor: pointer;
		outline: 0;
		vertical-align: middle;
		margin: 0px;
		left: 1150px;
		position: relative;
	}
	.btnbtn2{
		display: inline-block;
		border: 0;
		padding: 0;
		text-align: right;
		line-height: 48px;
		background: transparent;
		font-size: 16px;
		color: #333;
		cursor: pointer;
		outline: 0;
		vertical-align: middle;
		margin: 0px;
		left: 1200px;
		position: relative;
	}
	.btbt{
		display: inline-block;
		border: 0;
		padding: 0;
		text-align: right;
		line-height: 48px;
		background: transparent;
		font-size: 16px;
		color: #333;
		cursor: pointer;
		outline: 0;
		vertical-align: middle;
		margin: 0px;
	}
	#content{
		resize: none;
	}
	.iscontainer{
	width: 70%;
	position: relative;
	padding: 100px 100px 100px 100px;
	left: 200px;
	}	
</style>
<script>
	$(function(){
		CKEDITOR.replace("content");
		$("#frm").submit(function(){
			if($("#subject").val()==""){
				alert("제목을 입력하세요...");
				return false;
			}
			if(CKEDITOR.instances.content.getData()==""){
				alert("내용을 입력하세요...");
				return false;
			}
			return true;
		})
	});
	const fn_cancel=()=>{
        const result=confirm("정말로 취소하시겠습니까?");
  		if(result){
  			location.assign('<%=request.getContextPath()%>/borad/mainBorad');		
  		}	

	};
</script>

<body>
	
	<div class="iscontainer">
		
		<form method="post" id="frm" action="<%=request.getContextPath() %>/board/updateEnd">
			<ul>
				<li class="title_input"><textarea name="title" id="subject" rows="1" type="text" placeholder="<%=b.getBoardTitle() %>" maxlength="76" style="height: 26px;"></textarea></li>
				<li class="title_input"><textarea type="text" name="writer" placeholder="<%=b.getMemberId()%>" readonly="readonly" style="height: 26px;"></textarea></li>
				<li><input class="btbt" type="file"></li>
				<li><textarea name="content" id="content" cols="100" rows="50" placeholder="<%=b.getBoardContents()%>"></textarea></li>
			</ul>
			<br>
			<hr>
			<input type="hidden" name="No" value="<%=b.getBoardNb()%>">
			<br>
			<div class="btn">
			<input class="btnbtn" type="submit" value="등록하기" width="20" height="20">
			<input class="btnbtn2" type="button" value="취소하기" width="20" height="20" onclick="fn_cancel();">
			</div>
		</form>
	</div>
</body>
</html>

	
<%@ include file="/views/common/footer.jsp"%>