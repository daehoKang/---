<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/registTaglib.jsp"%>
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
				/* border : 0.1px solid black; */
				margin : 5px;
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
			
			.bottom-div-title {
				background-color: #0B3041;
				color: white;
				height:15%;
				align-content: center; 
				text-align: center;
				font-size: 50px;
			}
			.bottom-div-content {
				background-color: white;
				height:85%;
				font-size: 100px;
				align-content: center; 
				text-align: center;
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
				const formattedTime = String(now.getFullYear()).padStart(2, '0') + '. '
									+ String(now.getMonth() + 1).padStart(2, '0') + '. '
									+ String(now.getDate()).padStart(2, '0');
				
				$('#top-div-date').text(formattedTime);
			}
			function startGetData() {
				MonitoringSchedulerV3
				.add("USR40S6011-IPRON", {"callback": setIpronMonitoringData, "interval": 5000})
				.start()
				.enableAutoRecovery();
			}
			
			function setIpronMonitoringData ($def) {
				var sUrl = "<c:url value='/usr/board/USR40S6010/ipronData.do'/>"
				Swat.process(sUrl, monitoringInitData, { "callback":function(result) {
					ipronMonitoringData = JSON.parse(result.rows);
					console.log('ipron monitoring data');
					console.table(ipronMonitoringData);
					
					setTextVoiceAgentGroup();
					
					$def.resolve();
				}});
			}
			
			function setInitData() {
				var sUrl = "<c:url value='/usr/board/USR40S6010/initData.do'/>"
				Swat.process(sUrl, null, { "callback":function(result) {
					monitoringInitData = JSON.parse(result.rows);
					console.log('monitoring init data');
					console.table(monitoringInitData);
				}});
			}
			
			function setTextVoiceAgentGroup() {
				var insuranceVoiceAgentGroupList = ipronMonitoringData.insuranceVoiceAgentGroupList;
				var allInsuranceVoiceAgentGroupRedisData = insuranceVoiceAgentGroupList.allInsuranceVoiceAgentGroupRedisData;
				var insuranceChatAgentGroupList = ipronMonitoringData.insuranceChatAgentGroupList;
				var allInsuranceChatAgentGroupRedisData = insuranceChatAgentGroupList.allInsuranceChatAgentGroupRedisData;
				
				var strSql = " \
	   				SELECT \
						SUM(A.RTS_LOGIN) RTS_LOGIN,\
						SUM(A.RTS_READY) RTS_READY,\
						SUM(A.RTS_IB_BUSY + A.RTS_OB_BUSY + RTS_OB_DIALING + RTS_IB_RINGING) RTS_BUSY,\
						SUM(A.RTS_ACW) RTS_ACW\
					FROM ? A \
				";
				
				var insuranceVoiceAgentGroupRedisData = alasql(strSql,[allInsuranceVoiceAgentGroupRedisData]);
				console.table(insuranceVoiceAgentGroupRedisData);
				var insuranceChatAgentGroupRedisData = alasql(strSql,[allInsuranceChatAgentGroupRedisData]);
				console.table(insuranceChatAgentGroupRedisData);
				
				$('#insuranceAgentGroupVoiceLogin').text(insuranceVoiceAgentGroupRedisData[0].RTS_LOGIN);
				$('#insuranceAgentGroupVoiceReady').text(insuranceVoiceAgentGroupRedisData[0].RTS_READY);
				$('#insuranceAgentGroupVoiceBusy').text(insuranceVoiceAgentGroupRedisData[0].RTS_BUSY);
				$('#insuranceAgentGroupVoiceAcw').text(insuranceVoiceAgentGroupRedisData[0].RTS_ACW);
				
				$('#insuranceAgentGroupChatLogin').text(insuranceChatAgentGroupRedisData[0].RTS_LOGIN);
				$('#insuranceAgentGroupChatReady').text(insuranceChatAgentGroupRedisData[0].RTS_READY);
				$('#insuranceAgentGroupChatBusy').text(insuranceChatAgentGroupRedisData[0].RTS_BUSY);
				$('#insuranceAgentGroupChatAcw').text(insuranceChatAgentGroupRedisData[0].RTS_ACW);
			}
		</script>
	</head>
	
	<body>
		<!-- <button id="fullscreenBtn">전체 화면</button> -->
		<div class="top-div" style="display:flex; width:100%; height:15%;">
			<div id="top-div-title" style="width:80%;height:100%; align-content: center; text-align: center; background-color:white; font-size: 65px; border-radius:10px; ">한국교직원공제회 컨택센터 상담사 현황(보험 센터)</div>
			<div id="top-div-date" style="width:20%;height:100%; align-content: center; text-align: center; background-color:white; font-size: 60px; border-radius:10px;"></div>
		</div>
		<div class="bottom-div" style="display:flex; width:100%; height:80%;">
			<div class="bottom-div-1" style="width:20%;">
				<div style="height:100%;">
					<div class="bottom-div-title">상담원 (로그인)</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupVoiceLogin">0</span>명
					</div>
				</div>
			</div>
			<div class="bottom-div-0" style="width:20%;">
				<div class="bottom-title" style="width:100%;height:50%;background-color:#0B3041;align-content: center; text-align: center;font-size:120px;color:white;">음성</div>
				<div class="bottom-title" style="width:100%;height:50%;background-color:#0B3041;align-content: center; text-align: center;font-size:120px;color:white;">채팅</div>
			</div>
			<div class="bottom-div-2" style="width:20%;">
				<div style="height:50%">
					<div class="bottom-div-title">상담원 대기</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupVoiceReady">0</span>명
					</div>
				</div>
				<div style="height:50%">
					<div class="bottom-div-title">상담원 대기</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupChatReady">0</span>명
					</div>
				</div>
			</div>
			<div class="bottom-div-3" style="width:20%;">
				<div style="height:50%">
					<div class="bottom-div-title">상담중</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupVoiceBusy">0</span>명
					</div>
				</div>
				<div style="height:50%">
					<div class="bottom-div-title">상담중</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupChatBusy">0</span>명
					</div>
				</div>
			</div>
			<div class="bottom-div-4" style="width:20%;">
				<div style="height:50%">
					<div class="bottom-div-title">후처리</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupVoiceAcw">0</span>명
					</div>
				</div>
				<div style="height:50%">
					<div class="bottom-div-title">후처리</div>
					<div class="bottom-div-content">
						<span id="insuranceAgentGroupChatAcw">0</span>명
					</div>
				</div>
			</div>
		</div>
	</body>
</html>