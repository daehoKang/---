<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/registTaglib.jsp"%>
<jsp:include page="/WEB-INF/jsp/include/registChart.jsp" flush="true" />
<html>
	<head>
		<title><c:out value="${sessionVO.programName}" /></title>
		<link rel="stylesheet" href="/BT-EMS/dist/css/monitor.css" type="text/css" />
		<style>
			body {
				background-color: #4B4B4B;
				padding : 0;
				margin : 0; 
				overflow: hidden;
				font-family: fantasy;
			}
			div {
				/*border : 0.1px solid black;*/
				margin : 1px;
			}
			img {
				max-width: 100%;
				max-height: 100%;
			}
			.row-div {
				padding : 0;
				margin : 0;
				width:auto;
				display: flex;
				justify-content: center;
			}
			#time-div{
				font-size : 30px;
				align-items : center;
				color:white;
			}
			#time-div-div{
				align-self: center;
			}
			#top-div > div {
				width: 33%;
			}
			
			#middle-div .common-div-top {
				height: 7%;
			}
			
			
			.common-div-top{
				width: 100%;
				height: 10%;
				display: flex;
				justify-content: space-between;
			}
			.common-div-top > div{
				width : 30%;
				display : flex;
			}
			#middle-div .common-div-top {
				height: 7%;
			}
			#bottom-div .common-div-top {
				height: 7%;
			}
			.common-div-bottom{
				width: 100%;
				height: 90%;
			}
			.common-div-top-left-img {
				width:20%;
				align-self : center;
			}
			#middle-div .common-div-top-left-img {
				width:30%;
			}
			#bottom-div .common-div-top-left-img {
				width:30%;
			}
			#middle-div .common-div-top-left-text {
				width:50%;
			}
			#bottom-div .common-div-top-left-text {
				width:50%;
			}
			.common-div-top-left-text {
				width:80%;
				font-size: 0.7vw;
				white-space: nowrap;
				font-weight: bold;
				color: white;
				align-self: center;
			}
			.common-div-top-right-img {
				width:20%;
				background-color: #67B7DC;
			}
			.common-div-top-right-text {
				width:80%;
				font-size: 0.7vw;
				color:white;
			}
			.h-div-container {
				width: 100%;
				display:flex;
				border-radius: 10px;
			}
			.h-div-container-title {
				text-align: center;
				font-size : 25px;
				height:100%;
				display:grid;
			}
			.h-div-container-title div {
				align-self: center;
			}
			
			.h-div-container-vale {
				border-radius: 10px;
				background-color : white;
				font-size : 25px;
				height:100%;
				display:grid;
			}
			.h-div-container-vale div {
				align-self: center;
			}
			.v-div-container {
				width:100%;
				display: flex;
			}
			.v-div-container > div{
				width : 20%;
				border-radius: 10px;
			}
			.a-v-div-container {
				background-color: #3A3A3A;
				border-radius: 10px;
			}
			.a-v-div-container div {
				border-radius: 10px;
			}
			.a-v-div-container > div {
				background-color : #3A3A3A;
				width: 22%;
			}
			.a2-v-div-container {
				background-color: #C04F15;
				border-radius: 10px;
			}
			.a2-v-div-container div {
				border-radius: 10px;
			}
			.a2-v-div-container > div {
				background-color : #C04F15;
				width: 22%;
			}
			.b-v-div-container > div {
				background-color : #C04F15;
			}
			.v-div-container-title {
				color : white;
				font-size : 25px;
				height : 20%;
				text-align:center;
			}
			.v-div-container-value {
				background-color : white;
				font-size : 80px;
				height : 75%;
				display:grid;
			}
			.v-div-container-value div {
				text-align:center;
				align-self: center;
			}
			#middle-div .h-div-container-vale {
				font-size : 50px;
			}
			#bottom-div .h-div-container-vale {
				font-size : 50px;
			}
			#fullscreenBtn {
				position : fixed;
				bottom : 20px;
				right : 20px;
				padding : 10px 20px ;
				background-color: #007bff;
				color: white;
				border: none;
				border-radius : 8px;
				font-size: 16px;
				cursor: pointer;
				z-index: 9999;
				box-shadow: 0 4px 8px rgba(0,0,0,0.2);
				display: none;
			}
			#fullscreenBtn:hover {
				background-color: #0056b3;
			}
			#consult-rank-div .h-div-container-vale {
				font-size : 12px;
			}
			.board-title {
				background-color: #0B3041;
				border-radius: 10px;
			}
			.board-title > div {
				width: 100%;
				color : white;
			}
			#right-div .h-div-container-title {
				font-size:30px;
				color: white;
				width: 35%;
			}
			#right-div .h-div-container-vale {
				font-size:45px;
			}
		</style>
		<script type="text/javascript" src="/BT-EMS/scripts/easyui_1.5.4/jquery.min.js"></script>
		<script type="text/javascript" src="/BT-EMS/scripts/easyui_1.5.4/jquery.easyui.min.sup.js"></script>
		<script type="text/javascript" src="<c:url value="/scripts/i18n/swat.i18n.ko.js"/>?v=${rand}"></script>
		
		<script type="text/javascript" src="/BT-EMS/scripts/alasql.min.js"></script>
		
		<script type="text/javascript" src="<c:url value="/scripts/monitoringV4Custom.js"/>?v=${rand}"></script>
		<script type="text/javascript" src="<c:url value="/scripts/monitoringV4.js"/>?v=${rand}"></script>
		<script type="text/javascript" src="<c:url value="/scripts/tools.js"/>?v=${rand}"></script>
		<script type="text/javaScript" defer="defer">
			var monitoringInitData;
			var ipronMonitoringData;
			var trdPtyMonitoringData;
		
			$(document).ready(function () {
				updateTime();
				setInterval(updateTime, 1000);
				
				const $btn = $('#fullscreenBtn');
				
				$btn.fadeIn(1000);
				
				$btn.on('click', function () {
					const el = document.documentElement;
					
					if(el.requestFullscreen) {
						el.requestFullscreen();
					}
					
					$btn.fadeOut(300);
				});
				
				function onFullscreenChange() {
					const isFullscreen = document.fullscreenElement;
					
					if(!isFullscreen) {
						$btn.fadeIn(500);
					}
				}
				
				document.addEventListener('fullscreenchange', onFullscreenChange);
				
				setInitData();
				startGetData();
			});
			
			function updateTime() {
				const now = new Date();
				const formattedTime = String(now.getFullYear()).padStart(2, '0') + '-'
									+ String(now.getMonth() + 1).padStart(2, '0') + '-'
									+ String(now.getDate()).padStart(2, '0') + ' '
									+ String(now.getHours()).padStart(2, '0') + ':'
									+ String(now.getMinutes()).padStart(2, '0') + ':'
									+ String(now.getSeconds()).padStart(2, '0');
				
				$('#time-div-div').text(formattedTime);
			}
			
			function startGetData() {
				MonitoringSchedulerV3
				.add("USR40S6030-IPRON", {"callback": setIpronMonitoringData, "interval": 5000})
				.add("USR40S6030-3RDPTY", {"callback": set3rdPtyMonitoringData, "interval": 60000})
				.start()
				.enableAutoRecovery();
			}
			
			function setIpronMonitoringData ($def) {
				var sUrl = "<c:url value='/usr/board/USR40S6030/ipronData.do'/>"
				Swat.process(sUrl, monitoringInitData, { "callback":function(result) {
					ipronMonitoringData = JSON.parse(result.rows);
					console.log('ipron monitoring data');
					console.table(ipronMonitoringData);
					
					//IVR 메뉴 인입 순위
					setTextIvrMenuRankGrid();
					//음성 현황
					setTextVoiceCtiQ();
					//채팅 현황
					setTextChatCtiQ();
					//음성 상담사 현황
					setTextVoiceAgentGroup();
					//채팅 상담사 현황
					setTextChatAgentGroup();
					
					$def.resolve();
				}});
			}
			
			function set3rdPtyMonitoringData ($def) {
				var sUrl = "<c:url value='/usr/board/USR40S6030/get3rdPtyData.do'/>"
				Swat.process(sUrl, null, { "callback":function(result) {
					trdPtyMonitoringData = JSON.parse(result.rows);
					console.log('3rd party monitoring data');
					console.table(trdPtyMonitoringData);
					
					//TA 키워드 요소에 세팅
					setTextTaKeyWordRank();
					
					//TODO::회원 상담 유형 요소에 세팅
					
					$def.resolve();
				}});
			}
			
			function setInitData() {
				var sUrl = "<c:url value='/usr/board/USR40S6030/initData.do'/>"
				Swat.process(sUrl, null, { "callback":function(result) {
					monitoringInitData = JSON.parse(result.rows);
					console.log('monitoring init data');
					console.table(monitoringInitData);
				}});
			}
			
			function setTextIvrMenuRankGrid() {
				var insuranceIvrServiceList = ipronMonitoringData.insuranceIvrServiceList;
				var insuranceServiceMenuStatDbData = insuranceIvrServiceList.insuranceServiceMenuStatDbData;
				
				var strSql = " \
		   				SELECT \
							A.menuName,\
							A.connCnt\
   						FROM ? A \
   						ORDER BY connCnt DESC LIMIT 5 \
    				";
				
				var insuranceIverServiceMenuStatAlaResult = alasql(strSql,[insuranceServiceMenuStatDbData]);
				console.table(insuranceIverServiceMenuStatAlaResult);
				
				$('#ivrMenuRank1').text(insuranceIverServiceMenuStatAlaResult[0] === undefined ? '-' : insuranceIverServiceMenuStatAlaResult[0].menuName);
				$('#ivrMenuRank2').text(insuranceIverServiceMenuStatAlaResult[1] === undefined ? '-' : insuranceIverServiceMenuStatAlaResult[1].menuName);
				$('#ivrMenuRank3').text(insuranceIverServiceMenuStatAlaResult[2] === undefined ? '-' : insuranceIverServiceMenuStatAlaResult[2].menuName);
				$('#ivrMenuRank4').text(insuranceIverServiceMenuStatAlaResult[3] === undefined ? '-' : insuranceIverServiceMenuStatAlaResult[3].menuName);
				$('#ivrMenuRank5').text(insuranceIverServiceMenuStatAlaResult[4] === undefined ? '-' : insuranceIverServiceMenuStatAlaResult[4].menuName);
			}
			
			function setTextVoiceCtiQ() {
				var insuranceVoiceCtiQList = ipronMonitoringData.insuranceVoiceCtiQList;
				var allInsuranceCtiQRedisData = insuranceVoiceCtiQList.allInsuranceCtiQRedisData;
				
				var strSql = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE,\
						ROUND((SUM_SLANSW_CNT/IFNULL(SUM_ANSWER_CNT,1)) * 100) SL_RATE,\
						SUM_ABDN_CNT\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT,\
							SUM(A.SUM_SLANSW_CNT) SUM_SLANSW_CNT,\
							SUM(A.SUM_ABDN_CNT) SUM_ABDN_CNT\
						FROM ? A \
					) \
				";
				
				var allInsuranceVoiceCtiQAlaResult = alasql(strSql,[allInsuranceCtiQRedisData]);
				
				console.table(allInsuranceVoiceCtiQAlaResult);
				
				$('#insuranceCtiQVoiceSumRtsWaitCnt').text(allInsuranceVoiceCtiQAlaResult[0].RTS_WAIT_CNT);
				$('#insuranceCtiQVoiceSumConnCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_CONN_CNT);
				$('#insuranceCtiQVoiceSumAnswerCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_ANSWER_CNT);
				$('#insuranceCtiQVoiceSumAnswerRate').text(allInsuranceVoiceCtiQAlaResult[0].ANSWER_RATE);
				$('#insuranceCtiQVoiceSumServiceLevelAnswerRate').text(allInsuranceVoiceCtiQAlaResult[0].SL_RATE);
				$('#insuranceCtiQVoiceSumAbdnCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_AGDN_CNT);
			}
			
			function setTextChatCtiQ() {
				var insuranceChatCtiQList = ipronMonitoringData.insuranceChatCtiQList;
				var allInsuranceCtiQRedisData = insuranceChatCtiQList.allInsuranceChatCtiQRedisData;
				
				var strSql = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT\
						FROM ? A \
					) \
				";
				
				var insuranceAlaSqlResults = alasql(strSql, [allInsuranceCtiQRedisData])[0];
				
				console.table(insuranceAlaSqlResults);
				
				$('#insuranceCtiQChatSumRtsWaitCnt').text(insuranceAlaSqlResults.RTS_WAIT_CNT);
				$('#insuranceCtiQChatSumConnCnt').text(insuranceAlaSqlResults.SUM_CONN_CNT);
				$('#insuranceCtiQChatSumAnswerCnt').text(insuranceAlaSqlResults.SUM_ANSWER_CNT);
				$('#insuranceCtiQChatSumAnswerRate').text(insuranceAlaSqlResults.ANSWER_RATE);
				
			}
			
			function setTextVoiceAgentGroup () {
				var insuranceVoiceCtiQList = ipronMonitoringData.insuranceVoiceCtiQList;
				var allInsuranceVoiceRedisData = insuranceVoiceCtiQList.allInsuranceCtiQRedisData;
				var insuranceVoiceAgentGroupList = ipronMonitoringData.insuranceVoiceAgentGroupList;
				var allInsuranceVoiceAgentGroupRedisData = insuranceVoiceAgentGroupList.allInsuranceVoiceAgentGroupRedisData;
				
				var strSql = " \
					SELECT \
						SUM(A.RTS_READY) RTS_READY\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT \
						FROM ? A \
					) \
				";
				
				var allInsuranceVoiceAgentGroupAlaResult = alasql(strSql,[allInsuranceVoiceAgentGroupRedisData]);
				var allInsuranceVoiceCtiQAlaResult = alasql(strSql2,[allInsuranceVoiceRedisData]);
				console.table(allInsuranceVoiceAgentGroupAlaResult);
				console.table(allInsuranceVoiceCtiQAlaResult);
				
				$('#insuranceAgentGroupSumRtsWaitCnt').text(allInsuranceVoiceCtiQAlaResult[0].RTS_WAIT_CNT);
				$('#insuranceAgentGroupVoiceReady').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_READY);
				$('#insuranceAgentGroupSumConnCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_CONN_CNT);
				$('#insuranceAgentGroupSumAnswerCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_ANSWER_CNT);
			}
			
			function setTextChatAgentGroup () {
				var insuranceChatCtiQList = ipronMonitoringData.insuranceChatCtiQList;
				var allInsuranceCtiQRedisData = insuranceChatCtiQList.allInsuranceChatCtiQRedisData;
				var insuranceChatAgentGroupList = ipronMonitoringData.insuranceChatAgentGroupList;
				var allInsuranceChatAgentGroupRedisData = insuranceChatAgentGroupList.allInsuranceChatAgentGroupRedisData;
				
				var strSql = " \
					SELECT \
						SUM(A.RTS_READY) RTS_READY\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT \
						FROM ? A \
					) \
				";
				
				var allInsuranceChatAgentGroupAlaResult = alasql(strSql,[allInsuranceChatAgentGroupRedisData]);
				var allInsuranceChatCtiQAlaResult = alasql(strSql2,[allInsuranceCtiQRedisData]);
				console.table(allInsuranceChatAgentGroupAlaResult);
				console.table(allInsuranceChatCtiQAlaResult);
				
				$('#insuranceAgentGroupChatSumRtsWaitCnt').text(allInsuranceChatCtiQAlaResult[0].RTS_WAIT_CNT);
				$('#insuranceAgentGroupChatReady').text(allInsuranceChatAgentGroupAlaResult[0].RTS_READY);
				$('#insuranceAgentGroupChatSumConnCnt').text(allInsuranceChatCtiQAlaResult[0].SUM_CONN_CNT);
				$('#insuranceAgentGroupChatSumAnswerCnt').text(allInsuranceChatCtiQAlaResult[0].SUM_ANSWER_CNT);
			}
			function setTextTaKeyWordRank() {
				var taKeyWordRankData = trdPtyMonitoringData.taKeyWordRank.data;
				if(taKeyWordRankData.length <= 0) {console.log("TA 데이터 없음."); return;}
				
				var strSql ="\
					SELECT\
						A.RANK,\
						A.KWD\
					FROM ? A\
					ORDER BY RANK ASC\
				";
				
				taKeyWordRankAlaResult = alasql(strSql,[taKeyWordRankData]);
				console.table(taKeyWordRankAlaResult);
				
				for(var i = 0;i<taKeyWordRankData.length;i++ ) {
					$('#taKeyWordRank' + (i + 1)).text(taKeyWordRankAlaResult[0].KWD);
				}
			}
		</script>
	</head>
	
	<body>
		<!-- <button id="fullscreenBtn">전체 화면</button> -->
		<div style="height: 30%; display: flex;">
			<div style="height: 100%; width:70%;">
				<div id="top-div" class="row-div" style="height: 100%;">
					<div>
						<div class="common-div-top">
							<div class="common-div-top-left">
								<div class="common-div-top-left-img">
									<img alt="" src="/BT-EMS/dist/image/common/icon_navi_ivr.png">
								</div>
								<div class="common-div-top-left-text">
									IVR 메뉴 인입 순위
								</div>
							</div>
						</div>
						<div class="common-div-bottom">
							<div class="h-div-container" style="height:20%; background-color:#156082; color:white;">
								<div class="h-div-container-title" style="width:20%;"><div>1</div></div>
								<div class="h-div-container-vale" style="width:80%; background-color:#156082;"><div id="ivrMenuRank1">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#156082;">
								<div class="h-div-container-title" style="width:20%; color:white;"><div>2</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank2">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#156082;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>3</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank3">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#156082;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>4</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank4">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#156082;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>5</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank5">-</div></div>
							</div>
						</div>
					</div>
					<div>
						<div class="common-div-top">
							<div class="common-div-top-left">
								<div class="common-div-top-left-img">
									<img alt="" src="/BT-EMS/dist/image/common/icon_navi_new2.png">
								</div>
								<div class="common-div-top-left-text">
									보험 상담 유형 순위
								</div>
							</div>
						</div>
						<div id="consult-rank-div" class="common-div-bottom">
							<div class="h-div-container" style="height:20%; background-color:#215F9A; color:white;">
								<div class="h-div-container-title" style="width:20%;"><div>1</div></div>
								<div class="h-div-container-vale" style="width:80%; background-color:#215F9A;"><div>-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#215F9A;">
								<div class="h-div-container-title" style="width:20%; color:white;"><div>2</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div>-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#215F9A;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>3</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div>-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#215F9A;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>4</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div>-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#215F9A;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>5</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div>-</div></div>
							</div>
						</div>
					</div>
					<div>
						<div class="common-div-top">
							<div class="common-div-top-left">
								<div class="common-div-top-left-img">
									<img alt="" src="/BT-EMS/dist/image/common/icon_navi_service_s.png">
								</div>
								<div class="common-div-top-left-text">
									급상승 키워드
								</div>
							</div>
						</div>
						<div class="common-div-bottom">
							<div class="h-div-container" style="height:20%; background-color:#3B7D23; color:white;">
								<div class="h-div-container-title" style="width:20%;"><div>1</div></div>
								<div class="h-div-container-vale" style="width:80%; background-color:#3B7D23;"><div id="taKeyWordRank1">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#3B7D23;">
								<div class="h-div-container-title" style="width:20%; color:white;"><div>2</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank2">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#3B7D23;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>3</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank3">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#3B7D23;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>4</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank4">-</div></div>
							</div>
							<div class="h-div-container" style="height:20%; background-color:#3B7D23;">
								<div class="h-div-container-title" style="width:20%;  color:white;"><div>5</div></div>
								<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank5">-</div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="board-title" style="height: 100%; width:30%;">
				<div style="height:35%; display:grid;">
					<img src="/BT-EMS/images/usr/logo.png" style="width:70%; height:70%; align-self:center; justify-self:center;margin-left: 80px;">
				</div>
				<div style="height:35%; display:grid;">
					<div style="align-self:center; text-align:center; font-size:40px;">보험 컨텍센터 현황판</div>
				</div>
				<div style="height:30%;">
					<div id="time-div" class="row-div" style="height: 100%;">
						<div id="time-div-div"></div>
					</div>
				</div>
			</div>
		</div>
		<div style="display: flex; height:69%;">
			<div id="left-div" style="height: 100%; width:70%;">
				<div style="width:100%; height:70%">
					<div class="common-div-top">
						<div class="common-div-top-left-text">
							음성 현황
						</div>
					</div>
					<div class="common-div-bottom">
						<div style="border-radius:10px; background-color: #3A3A3A; display:flex; height:100%; font: bold;">
							<div style="width: 10%; display: grid; text-align:center;">
								<div style="align-self:center; color:white; font-size:50px;">음성</div>
							</div>
							<div style="width: 90%;">
								<div class="v-div-container a-v-div-container" style="height : 50%;">
									<div style="width:25%;">
										<div class="v-div-container-title">고객대기</div>
										<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumRtsWaitCnt">0</div></div>
									</div>
									<div style="width:25%;">
										<div class="v-div-container-title">인입콜</div>
										<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumConnCnt">0</div></div>
									</div>
									<div style="width:25%;">
										<div class="v-div-container-title">응대콜</div>
										<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumAnswerCnt">0</div></div>
									</div>
									<div style="width:25%;">
										<div class="v-div-container-title">포기콜</div>
										<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumAbdnCnt">0</div></div>
									</div>
								</div>
								<div class="v-div-container a-v-div-container" style="height : 50%;">
									<div style="width:50%;">
										<div class="v-div-container-title">응대율</div>
										<div class="v-div-container-value" style="font-size:100px; display: flex; justify-content:center;"><div id="insuranceCtiQVoiceSumAnswerRate">0</div><div>%</div></div>
									</div>
									<div style="width:50%;">
										<div class="v-div-container-title">서비스 레벨</div>
										<div class="v-div-container-value" style="font-size:100px; display: flex; justify-content:center;"><div id="insuranceCtiQVoiceSumServiceLevelAnswerRate">0</div><div>%</div></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="width:100%;  height:30%">
					<div class="common-div-top">
						<div class="common-div-top-left-text">
							채팅 현황
						</div>	
					</div>
					<div class="common-div-bottom">
						<div class="v-div-container a2-v-div-container" style="height: 100%">
							<div style="color: white; display:grid; text-align:center; width:12%;">
								<div style="align-self:center; font-size:50px;">채팅</div>
							</div>
							<div>
								<div class="v-div-container-title">고객대기</div>
								<div class="v-div-container-value"><div id="insuranceCtiQChatSumRtsWaitCnt">0</div></div>
							</div>
							<div>
								<div class="v-div-container-title">인입콜</div>
								<div class="v-div-container-value"><div id="insuranceCtiQChatSumConnCnt">0</div></div>
							</div>
							<div>
								<div class="v-div-container-title">응대콜</div>
								<div class="v-div-container-value"><div id="insuranceCtiQChatSumAnswerCnt">0</div></div>
							</div>
							<div>
								<div class="v-div-container-title">응대율</div>
								<div class="v-div-container-value" style="display: flex; justify-content:center;"><div id="insuranceCtiQChatSumAnswerRate">0</div><div>%</div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="right-div" style="height: 100%; width:30%;">
				<div style="width:100%; height:50%;">
					<div class="common-div-top">
						<div class="common-div-top-left">
							<div class="common-div-top-left-text">
								음성 상담사 현황
							</div>
						</div>
					</div>
					<div class="common-div-bottom">
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>대기회원</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupSumRtsWaitCnt">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>대기중</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupVoiceReady">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>인입호</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupSumConnCnt">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>응대호</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupSumAnswerCnt">0</div></div>
						</div>
					</div>
				</div>
				<div style="width:100%; height:50%;">
					<div class="common-div-top">
						<div class="common-div-top-left">
							<div class="common-div-top-left-text">
								채팅 상담사 현황
							</div>
						</div>
					</div>
					<div class="common-div-bottom">
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>대기회원</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupChatSumRtsWaitCnt">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>대기중</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupChatReady">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>인입호</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupChatSumConnCnt">0</div></div>
						</div>
						<div class="h-div-container" style="height:25%; background-color:#78206E;">
							<div class="h-div-container-title" ><div>응대호</div></div>
							<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupChatSumAnswerCnt">0</div></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>