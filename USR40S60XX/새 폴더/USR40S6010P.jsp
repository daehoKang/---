<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/registTaglib.jsp"%>
<%
	String pageParameter = request.getParameter("page");
%>
<jsp:include page="/WEB-INF/jsp/include/header_new.jsp" flush="true" />
<title><c:out value="${sessionVO.programName}" /></title><!-- 시나리오 환경변수 적용 -->
<style>
	[lang=en] .search-input .col0{ width:120px !important;}	
</style>

<script type="text/javascript">
	window.onload = function () {
		const strPageParamter = "<%= pageParameter%>" ;
		const popupUrl = "<c:url value='/usr/board/"+ strPageParamter +".do'/>";
		
		const popup = window.open(
			"<c:url value='/usr/board/"+ strPageParamter +".do'/>"
			,strPageParamter
			,"width=1920, height=1080, scrollbars=no"
		);
		
		if (popup === null || typeof popup === "undefined") {
			alert("⚠ 팝업이 차단되었습니다. 팝업 허용 설정을 확인해 주세요.");
		}
	}
</script>

<body>
	<!-- 레이아웃.헤더 -->
	<div class="swat-header">
		<jsp:include page="/WEB-INF/jsp/include/mainMenubar_.jsp" flush="true" />
	</div>
	<!-- 레이아웃.바디 -->
	<div class="swat-content h121">
		<div class="main-content" style="background-color: #F8F8F8;">
			<span class="main-icon"></span>
		</div>
	</div>
	<!-- 레이아웃.푸터 -->
	<div class="swat-footer">
		<jsp:include page="/WEB-INF/jsp/include/footer.jsp" flush="true" />
	</div>
	<!-- 레이아웃.푸터 -->
</body>