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
				width: 25%;
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
				font-size : 50px;
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
				height:50%;
				width:100%;
				display: flex;
			}
			.v-div-container > div{
				width : 20%;
				border-radius: 10px;
			}
			.a-v-div-container > div {
				background-color : #3A3A3A;
			}
			.b-v-div-container > div {
				background-color : #C04F15;
			}
			.v-div-container-title {
				color : white;
				font-size : 20px;
				height : 20%;
				text-align:center;
			}
			.v-div-container-value {
				background-color : white;
				font-size : 80px;
				height : 80%;
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
		</style>
		<script type="text/javascript" src="/BT-EMS/scripts/easyui_1.5.4/jquery.min.js"></script>
		<script type="text/javascript" src="/BT-EMS/scripts/easyui_1.5.4/jquery.easyui.min.sup.js"></script>
		<script type="text/javascript" src="<c:url value="/scripts/i18n/swat.i18n.ko.js"/>?v=${rand}"></script>
		
		<script type="text/javascript" src="/BT-EMS/scripts/amcharts5/index.js"></script>
		<script type="text/javascript" src="/BT-EMS/scripts/amcharts5/xy.js"></script>
		<script type="text/javascript" src="/BT-EMS/scripts/amcharts5/themes/Animated.js"></script>
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
			
			const charts = {};
			am5.ready(function (){
				const createChart = (divId, data) => {
					var root = am5.Root.new(divId);
				
					root.setThemes([am5themes_Animated.new(root)]);
				
					var chart = root.container.children.push(
						am5xy.XYChart.new(root, {
							panX: true
							,panY: true
							,wheelX: "panX"
							,wheelY: "zoomX"
							,layout: root.verticalLayout
						})
					);
					
					var xAxis = chart.xAxes.push(
							am5xy.CategoryAxis.new(root, {
								maxDeviation: 0.3
								,categoryField: 'category'
								,renderer: am5xy.AxisRendererX.new(root, {})
								,tooltip: am5.Tooltip.new(root, {})
							})
					);
					
					xAxis.get('renderer').labels.template.setAll({
						fill: am5.color(0xFFFFFF)
					});
					
					var yAxis = chart.yAxes.push(
							am5xy.ValueAxis.new(root, {
								renderer: am5xy.AxisRendererY.new(root, {})
							})
					);
					
					yAxis.get('renderer').labels.template.setAll({
						fill: am5.color(0xFFFFFF)
					});
					
					var series = chart.series.push(
							am5xy.ColumnSeries.new(root, {
								name: "Series 1"
								,xAxis: xAxis
								,yAxis: yAxis
								,valueYField: "value"
								,categoryXField: "category"
								,tooltip: am5.Tooltip.new(root, {
									labelText: "{categoryX}: {valueY}"
								})
							})
					);
					
					xAxis.data.setAll(data);
					series.data.setAll(data);
					
					series.appear(1000);
					chart.appear(1000, 100);
					
					charts[divId] = {root, chart, xAxis, yAxis, series};
				};
				
				var data1 = [
					{category: "개인", value: 0}
					,{category: "법인", value: 0}
					,{category: "분회", value: 0}
				];
				
				var data2 = [
					{category: "보험금청구", value: 0}
					,{category: "보험금수납", value: 0}
					,{category: "보험일반", value: 0}
				];
				
				createChart('chart1', data1);
				createChart('chart2', data2);
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
				.add("USR40S6010-IPRON", {"callback": setIpronMonitoringData, "interval": 5000})
				.add("USR40S6010-3RDPTY", {"callback": set3rdPtyMonitoringData, "interval": 60000})
				.start()
				.enableAutoRecovery();
			}
			
			function setIpronMonitoringData ($def) {
				var sUrl = "<c:url value='/usr/board/USR40S6010/ipronData.do'/>"
				Swat.process(sUrl, monitoringInitData, { "callback":function(result) {
					ipronMonitoringData = JSON.parse(result.rows);
					console.log('ipron monitoring data');
					console.table(ipronMonitoringData);
					
					//회원 업무별 인입 현황
					rePaintBarChart('1');
					//보험 업무별 인입 현황
					rePaintBarChart('2');
					//IVR 메뉴 인입 순위
					setTextIvrMenuRankGrid();
					//회원 컨택센터 현황 (음성)
					setTextVoicePersonalCenter();
					//보험 컨택센터 현황 (음성)
					setTextVoiceInsuranceCenter();
					//회원 컨택센터 현황 (채팅)
					setTextChatPersonalCenter();
					//보험 컨택센터 현황 (채팅)
					setTextChatInsuranceCenter();
					
					$def.resolve();
				}});
			}
			
			function set3rdPtyMonitoringData ($def) {
				var sUrl = "<c:url value='/usr/board/USR40S6010/get3rdPtyData.do'/>"
				Swat.process(sUrl, null, { "callback":function(result) {
					trdPtyMonitoringData = JSON.parse(result.rows);
					console.log('3rd party monitoring data');
					console.table(trdPtyMonitoringData);
					
					//키워드 요소에 세팅
					setTextTaKeyWordRank();
					
					//TODO::차상담 및 재인입 / 업무이관 / FCR 요소에 세팅
					
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
			
			function rePaintBarChart(index) {
				if (index === '1') {
					var personalCtiQList = ipronMonitoringData.personalVoiceCtiQList;
					var personalVoiceCtiQRedisData = personalCtiQList.personalVoiceCtiQRedisData;
					var companyVoiceCtiQRedisData = personalCtiQList.companyVoiceCtiQRedisData;
					var moneyVoiceCtiQRedisData = personalCtiQList.moneyVoiceCtiQRedisData;
					
					var strSql = "SELECT '개인' category, SUM(A.SUM_CONN_CNT) sum_conn_cnt FROM ? A "
					var personalAlaSqlResults = alasql(strSql, [personalVoiceCtiQRedisData])[0];
					strSql = "SELECT '법인' category, SUM(B.SUM_CONN_CNT) sum_conn_cnt FROM ? B "
					var companyAlaSqlResults = alasql(strSql, [companyVoiceCtiQRedisData])[0];
					strSql = "SELECT '분회' category, SUM(C.SUM_CONN_CNT) sum_conn_cnt FROM ? C";	
					var moneyAlaSqlResults = alasql(strSql, [moneyVoiceCtiQRedisData])[0];
					
					var chartData = [
						{category: personalAlaSqlResults.category, value: personalAlaSqlResults.sum_conn_cnt}
						,{category: companyAlaSqlResults.category, value: companyAlaSqlResults.sum_conn_cnt}
						,{category: moneyAlaSqlResults.category, value: moneyAlaSqlResults.sum_conn_cnt}
					]
					
					console.table(chartData);
					charts['chart1'].xAxis.data.setAll(chartData);
					charts['chart1'].series.data.setAll(chartData);
				} else if (index === '2') {
					var insuranceCtiQList = ipronMonitoringData.insuranceVoiceCtiQList;
					var chungooVoiceCtiQRedisData = insuranceCtiQList.chungooVoiceCtiQRedisData;
					var soonapVoiceCtiQRedisData = insuranceCtiQList.soonapVoiceCtiQRedisData;
					var commonVoiceCtiQRedisData = insuranceCtiQList.commonVoiceCtiQRedisData;
					
					var strSql = "SELECT '보험금청구' category, SUM(A.SUM_CONN_CNT) sum_conn_cnt FROM ? A "
					var chungooAlaSqlResults = alasql(strSql, [chungooVoiceCtiQRedisData])[0];
					strSql = "SELECT '보험금수납' category, SUM(B.SUM_CONN_CNT) sum_conn_cnt FROM ? B "
					var soonapAlaSqlResults = alasql(strSql, [soonapVoiceCtiQRedisData])[0];
					strSql = "SELECT '보험일반' category, SUM(C.SUM_CONN_CNT) sum_conn_cnt FROM ? C";	
					var commonAlaSqlResults = alasql(strSql, [commonVoiceCtiQRedisData])[0];
					
					var chartData = [
						{category: chungooAlaSqlResults.category, value: chungooAlaSqlResults.sum_conn_cnt}
						,{category: soonapAlaSqlResults.category, value: soonapAlaSqlResults.sum_conn_cnt}
						,{category: commonAlaSqlResults.category, value: commonAlaSqlResults.sum_conn_cnt}
					]
					
					console.table(chartData);
					charts['chart2'].xAxis.data.setAll(chartData);
					charts['chart2'].series.data.setAll(chartData);
				}
			}
			
			function setTextIvrMenuRankGrid() {
				var personalIvrServiceList = ipronMonitoringData.personalIvrServiceList;
				var insuranceIvrServiceList = ipronMonitoringData.insuranceIvrServiceList;
				var personalServiceMenuStatDbData = personalIvrServiceList.personalServiceMenuStatDbData;
				var insuranceServiceMenuStatDbData = insuranceIvrServiceList.insuranceServiceMenuStatDbData;
				
				var mergedObj = [...personalServiceMenuStatDbData, ...insuranceServiceMenuStatDbData];
				
				var strSql = " \
		   				SELECT \
							A.menuName,\
							A.connCnt\
   						FROM ? A \
   						ORDER BY connCnt DESC LIMIT 3 \
    				";
				
				var personalIverServiceMenuStatAlaResult = alasql(strSql,[mergedObj]);
				console.table(personalIverServiceMenuStatAlaResult);
				
				$('#ivrMenuRank1').text(personalIverServiceMenuStatAlaResult[0] === undefined ? '-' : personalIverServiceMenuStatAlaResult[0].menuName);
				$('#ivrMenuRank2').text(personalIverServiceMenuStatAlaResult[1] === undefined ? '-' : personalIverServiceMenuStatAlaResult[1].menuName);
				$('#ivrMenuRank3').text(personalIverServiceMenuStatAlaResult[2] === undefined ? '-' : personalIverServiceMenuStatAlaResult[2].menuName);
			}
			
			function setTextVoicePersonalCenter() {
				var personalVoiceCtiQList = ipronMonitoringData.personalVoiceCtiQList;
				var allPersonalCtiQRedisData = personalVoiceCtiQList.allPersonalCtiQRedisData;
				var personalVoiceAgentGroupList = ipronMonitoringData.personalVoiceAgentGroupList;
				var allPersonalVoiceAgentGroupRedisData = personalVoiceAgentGroupList.allPersonalVoiceAgentGroupRedisData;
				
				var strSql = " \
	   				SELECT \
						SUM(A.RTS_LOGIN) RTS_LOGIN,\
						SUM(A.RTS_READY) RTS_READY,\
						SUM(A.RTS_IB_BUSY + A.RTS_OB_BUSY + RTS_OB_DIALING + RTS_IB_RINGING) RTS_BUSY,\
						SUM(A.RTS_NOTREADY) RTS_NOTREADY,\
						SUM(A.RTS_ACW) RTS_ACW\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE,\
						ROUND((SUM_SLANSW_CNT/IFNULL(SUM_ANSWER_CNT,1)) * 100) SL_RATE\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT,\
							SUM(A.SUM_SLANSW_CNT) SUM_SLANSW_CNT\
						FROM ? A \
					) \
				";
				
				var allPersonalVoiceAgentGroupAlaResult = alasql(strSql,[allPersonalVoiceAgentGroupRedisData]);
				var allPersonalVoiceCtiQAlaResult = alasql(strSql2,[allPersonalCtiQRedisData]);
				console.table(allPersonalVoiceAgentGroupAlaResult);
				console.table(allPersonalVoiceCtiQAlaResult);
				
				$('#personalAgentGroupVoiceReady').text(allPersonalVoiceAgentGroupAlaResult[0].RTS_READY);
				$('#personalAgentGroupVoiceBusy').text(allPersonalVoiceAgentGroupAlaResult[0].RTS_BUSY);
				$('#personalAgentGroupVoiceNotReady').text(allPersonalVoiceAgentGroupAlaResult[0].RTS_NOTREADY);
				$('#personalAgentGroupVoiceAcw').text(allPersonalVoiceAgentGroupAlaResult[0].RTS_ACW);
				$('#personalAgentGroupVoiceLogin').text(allPersonalVoiceAgentGroupAlaResult[0].RTS_LOGIN);
				
				$('#personalCtiQVoiceSumConnCnt').text(allPersonalVoiceCtiQAlaResult[0].SUM_CONN_CNT);
				$('#personalCtiQVoiceSumAnswerCnt').text(allPersonalVoiceCtiQAlaResult[0].SUM_ANSWER_CNT);
				$('#personalCtiQVoiceRtsWaitCnt').text(allPersonalVoiceCtiQAlaResult[0].RTS_WAIT_CNT);
				$('#personalCtiQVoiceSumAnswerRate').text(allPersonalVoiceCtiQAlaResult[0].ANSWER_RATE);
				$('#personalCtiQVoiceSumServiceLevelAnswerRate').text(allPersonalVoiceCtiQAlaResult[0].SL_RATE);
			}
			
			function setTextVoiceInsuranceCenter() {
				var insuranceVoiceCtiQList = ipronMonitoringData.insuranceVoiceCtiQList;
				var allInsuranceCtiQRedisData = insuranceVoiceCtiQList.allInsuranceCtiQRedisData;
				var insuranceVoiceAgentGroupList = ipronMonitoringData.insuranceVoiceAgentGroupList;
				var allInsuranceVoiceAgentGroupRedisData = insuranceVoiceAgentGroupList.allInsuranceVoiceAgentGroupRedisData;
				
				var strSql = " \
	   				SELECT \
						SUM(A.RTS_LOGIN) RTS_LOGIN,\
						SUM(A.RTS_READY) RTS_READY,\
						SUM(A.RTS_IB_BUSY + A.RTS_OB_BUSY + RTS_OB_DIALING + RTS_IB_RINGING) RTS_BUSY,\
						SUM(A.RTS_NOTREADY) RTS_NOTREADY,\
						SUM(A.RTS_ACW) RTS_ACW\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE,\
						ROUND((SUM_SLANSW_CNT/IFNULL(SUM_ANSWER_CNT,1)) * 100) SL_RATE\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT,\
							SUM(A.SUM_SLANSW_CNT) SUM_SLANSW_CNT\
						FROM ? A \
					) \
				";
				
				var allInsuranceVoiceAgentGroupAlaResult = alasql(strSql,[allInsuranceVoiceAgentGroupRedisData]);
				var allInsuranceVoiceCtiQAlaResult = alasql(strSql2,[allInsuranceCtiQRedisData]);
				console.table(allInsuranceVoiceAgentGroupAlaResult);
				console.table(allInsuranceVoiceCtiQAlaResult);
				
				$('#insuranceAgentGroupVoiceReady').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_READY);
				$('#insuranceAgentGroupVoiceBusy').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_BUSY);
				$('#insuranceAgentGroupVoiceNotReady').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_NOTREADY);
				$('#insuranceAgentGroupVoiceAcw').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_ACW);
				$('#insuranceAgentGroupVoiceLogin').text(allInsuranceVoiceAgentGroupAlaResult[0].RTS_LOGIN);
				
				$('#insuranceCtiQVoiceSumConnCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_CONN_CNT);
				$('#insuranceCtiQVoiceSumAnswerCnt').text(allInsuranceVoiceCtiQAlaResult[0].SUM_ANSWER_CNT);
				$('#insuranceCtiQVoiceSumRtsWaitCnt').text(allInsuranceVoiceCtiQAlaResult[0].RTS_WAIT_CNT);
				$('#insuranceCtiQVoiceSumAnswerRate').text(allInsuranceVoiceCtiQAlaResult[0].ANSWER_RATE);
				$('#insuranceCtiQVoiceSumServiceLevelAnswerRate').text(allInsuranceVoiceCtiQAlaResult[0].SL_RATE);
			}
			
			function setTextChatPersonalCenter() {
				var personalChatCtiQList = ipronMonitoringData.personalChatCtiQList;
				var allPersonalCtiQRedisData = personalChatCtiQList.allPersonalChatCtiQRedisData;
				var personalChatAgentGroupList = ipronMonitoringData.personalChatAgentGroupList;
				var allPersonalChatAgentGroupRedisData = personalChatAgentGroupList.allPersonalChatAgentGroupRedisData;
				
				var strSql = " \
	   				SELECT \
						SUM(A.RTS_LOGIN) RTS_LOGIN,\
						SUM(A.RTS_READY) RTS_READY,\
						SUM(A.RTS_IB_BUSY + A.RTS_OB_BUSY + RTS_OB_DIALING + RTS_IB_RINGING) RTS_BUSY,\
						SUM(A.RTS_NOTREADY) RTS_NOTREADY,\
						SUM(A.RTS_ACW) RTS_ACW\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE,\
						ROUND((SUM_SLANSW_CNT/IFNULL(SUM_ANSWER_CNT,1)) * 100) SL_RATE\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT,\
							SUM(A.SUM_SLANSW_CNT) SUM_SLANSW_CNT\
						FROM ? A \
					) \
				";
				
				var allPersonalChatAgentGroupAlaResult = alasql(strSql,[allPersonalChatAgentGroupRedisData]);
				var allPersonalChatCtiQAlaResult = alasql(strSql2,[allPersonalCtiQRedisData]);
				console.table(allPersonalChatAgentGroupAlaResult);
				console.table(allPersonalChatCtiQAlaResult);
				
				$('#personalAgentGroupChatReady').text(allPersonalChatAgentGroupAlaResult[0].RTS_READY);
				
				$('#personalCtiQChatSumConnCnt').text(allPersonalChatCtiQAlaResult[0].SUM_CONN_CNT);
				$('#personalCtiQChatSumAnswerCnt').text(allPersonalChatCtiQAlaResult[0].SUM_ANSWER_CNT);
				$('#personalCtiQChatSumRtsWaitCnt').text(allPersonalChatCtiQAlaResult[0].RTS_WAIT_CNT);
			}
			
			function setTextChatInsuranceCenter() {
				var insuranceChatCtiQList = ipronMonitoringData.insuranceChatCtiQList;
				var allInsuranceCtiQRedisData = insuranceChatCtiQList.allInsuranceChatCtiQRedisData;
				var insuranceChatAgentGroupList = ipronMonitoringData.insuranceChatAgentGroupList;
				var allInsuranceChatAgentGroupRedisData = insuranceChatAgentGroupList.allInsuranceChatAgentGroupRedisData;
				
				var strSql = " \
	   				SELECT \
						SUM(A.RTS_LOGIN) RTS_LOGIN,\
						SUM(A.RTS_READY) RTS_READY,\
						SUM(A.RTS_IB_BUSY + A.RTS_OB_BUSY + RTS_OB_DIALING + RTS_IB_RINGING) RTS_BUSY,\
						SUM(A.RTS_NOTREADY) RTS_NOTREADY,\
						SUM(A.RTS_ACW) RTS_ACW\
					FROM ? A \
				";
				
				var strSql2 = " \
					SELECT\
						SUM_CONN_CNT,\
						SUM_ANSWER_CNT,\
						RTS_WAIT_CNT,\
						ROUND((SUM_ANSWER_CNT/IFNULL(SUM_CONN_CNT,1)) * 100) ANSWER_RATE,\
						ROUND((SUM_SLANSW_CNT/IFNULL(SUM_ANSWER_CNT,1)) * 100) SL_RATE\
					FROM ( \
	   					SELECT \
							SUM(A.SUM_CONN_CNT) SUM_CONN_CNT,\
							SUM(A.SUM_ANSWER_CNT) SUM_ANSWER_CNT,\
							SUM(A.RTS_WAIT_CNT) RTS_WAIT_CNT,\
							SUM(A.SUM_SLANSW_CNT) SUM_SLANSW_CNT\
						FROM ? A \
					) \
				";
				
				var allInsuranceChatAgentGroupAlaResult = alasql(strSql,[allInsuranceChatAgentGroupRedisData]);
				var allInsuranceChatCtiQAlaResult = alasql(strSql2,[allInsuranceCtiQRedisData]);
				console.table(allInsuranceChatAgentGroupAlaResult);
				console.table(allInsuranceChatCtiQAlaResult);
				
				$('#insuranceAgentGroupChatReady').text(allInsuranceChatAgentGroupAlaResult[0].RTS_READY);
				
				$('#insuranceCtiQChatSumConnCnt').text(allInsuranceChatCtiQAlaResult[0].SUM_CONN_CNT);
				$('#insuranceCtiQChatSumAnswerCnt').text(allInsuranceChatCtiQAlaResult[0].SUM_ANSWER_CNT);
				$('#insuranceCtiQChatSumRtsWaitCnt').text(allInsuranceChatCtiQAlaResult[0].RTS_WAIT_CNT);
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
		<div id="time-div" class="row-div" style="height: 5%;">
			<div id="time-div-div"></div>
		</div>
		<div id="top-div" class="row-div" style="height: 25%;">
			<div>
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-img">
							<img alt="" src="/BT-EMS/dist/image/common/icon_navi_stat.png">
						</div>
						<div class="common-div-top-left-text">
							회원 업무별 인입 현황
						</div>
					</div>
					<div class="common-div-top-right">
						<div class="common-div-top-right-img">
						</div>
						<div class="common-div-top-right-text">
							인입호
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div id="chart1"></div>
				</div>
			</div>
			<div>
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-img">
							<img alt="" src="/BT-EMS/dist/image/common/icon_navi_stat.png">
						</div>
						<div class="common-div-top-left-text">
							보험 업무별 인입 현황
						</div>
					</div>
					<div class="common-div-top-right">
						<div class="common-div-top-right-img">
						</div>
						<div class="common-div-top-right-text">
							인입호
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div id="chart2"></div>
				</div>
			</div>
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
					<div class="h-div-container" style="height:33%; background-color:#156082; color:white;">
						<div class="h-div-container-title" style="width:20%;"><div>1</div></div>
						<div class="h-div-container-vale" style="width:80%; background-color:#156082;"><div id="ivrMenuRank1"></div></div>
					</div>
					<div class="h-div-container" style="height:33%; background-color:#156082;">
						<div class="h-div-container-title" style="width:20%; color:white;"><div>2</div></div>
						<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank2"></div></div>
					</div>
					<div class="h-div-container" style="height:33%; background-color:#156082;">
						<div class="h-div-container-title" style="width:20%;  color:white;"><div>3</div></div>
						<div class="h-div-container-vale" style="width:80%; "><div id="ivrMenuRank3"></div></div>
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
					<div class="h-div-container" style="height:33%; background-color:#3B7D23; color:white;">
						<div class="h-div-container-title" style="width:20%;"><div>1</div></div>
						<div class="h-div-container-vale" style="width:80%; background-color:#3B7D23;"><div id="taKeyWordRank1">-</div></div>
					</div>
					<div class="h-div-container" style="height:33%; background-color:#3B7D23;">
						<div class="h-div-container-title" style="width:20%; color:white;"><div>2</div></div>
						<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank2">-</div></div>
					</div>
					<div class="h-div-container" style="height:33%; background-color:#3B7D23;">
						<div class="h-div-container-title" style="width:20%;  color:white;"><div>3</div></div>
						<div class="h-div-container-vale" style="width:80%; "><div id="taKeyWordRank3">-</div></div>
					</div>
				</div>
			</div>
		</div>
		<div id="middle-div" class="row-div" style="height: 35%;">
			<div style="width:60%">
				<div class="common-div-top">
					<div class="common-div-top-left-text">
						회원 컨택센터 현황 (음성)
					</div>
				</div>
				<div class="common-div-bottom">
					<div class="v-div-container a-v-div-container">
						<div>
							<div class="v-div-container-title">고객대기</div>
							<div class="v-div-container-value"><div id="personalCtiQVoiceRtsWaitCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">인입콜</div>
							<div class="v-div-container-value"><div id="personalCtiQVoiceSumConnCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">응대콜</div>
							<div class="v-div-container-value"><div id="personalCtiQVoiceSumAnswerCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">응대율</div>
							<div class="v-div-container-value" style="display: flex; justify-content:center;"><div id="personalCtiQVoiceSumAnswerRate">0</div><div>%</div></div>
						</div>
						<div>
							<div class="v-div-container-title">서비스 레벨</div>
							<div class="v-div-container-value" style="display: flex; justify-content:center;"><div id="personalCtiQVoiceSumServiceLevelAnswerRate">0</div><div>%</div></div>
						</div>
					</div>
					<div class="v-div-container a-v-div-container">
						<div>
							<div class="v-div-container-title">상담대기</div>
							<div class="v-div-container-value"><div id="personalAgentGroupVoiceReady">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">상담중</div>
							<div class="v-div-container-value"><div id="personalAgentGroupVoiceBusy">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">이석</div>
							<div class="v-div-container-value"><div id="personalAgentGroupVoiceNotReady">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">후처리</div>
							<div class="v-div-container-value"><div id="personalAgentGroupVoiceAcw">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">로그인</div>
							<div class="v-div-container-value"><div id="personalAgentGroupVoiceLogin">0</div></div>
						</div>
					</div>
				</div>
			</div>
			<div style="width:20%">
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-text">
							회원 컨택센터 현황 (채팅)
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div class="h-div-container" style="height:25%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>대기회원</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="personalCtiQChatSumRtsWaitCnt">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>대기중</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="personalAgentGroupChatReady">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>인입호</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="personalCtiQChatSumConnCnt">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>응대호</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="personalCtiQChatSumAnswerCnt">0</div></div>
					</div>
				</div>
			</div>
			<div style="width:20%">
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-text">
							회원 최초통화 해결율
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div class="h-div-container" style="height:20%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>인입(IVR)</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>연결시도</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>1차 상담 인입/재인입</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>업무이관</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#3A3A3A;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>FCR</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
				</div>
			</div>
		</div>
		<div id="bottom-div" class="row-div" style="height: 35%;">
			<div style="width:60%">
				<div class="common-div-top">
					<div class="common-div-top-left-text">
						보험 컨택센터 현황 (음성)
					</div>	
				</div>
				<div class="common-div-bottom">
					<div class="v-div-container b-v-div-container">
						<div>
							<div class="v-div-container-title">고객대기</div>
							<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumRtsWaitCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">인입콜</div>
							<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumConnCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">응대콜</div>
							<div class="v-div-container-value"><div id="insuranceCtiQVoiceSumAnswerCnt">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">응대율</div>
							<div class="v-div-container-value" style="display: flex; justify-content:center;"><div id="insuranceCtiQVoiceSumAnswerRate">0</div><div>%</div></div>
						</div>
						<div>
							<div class="v-div-container-title">서비스 레벨</div>
							<div class="v-div-container-value" style="display: flex; justify-content:center;"><div id="insuranceCtiQVoiceSumServiceLevelAnswerRate">0</div><div>%</div></div>
						</div>
					</div>
					<div class="v-div-container b-v-div-container">
						<div>
							<div class="v-div-container-title">상담대기</div>
							<div class="v-div-container-value"><div id="insuranceAgentGroupVoiceReady">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">상담중</div>
							<div class="v-div-container-value"><div id="insuranceAgentGroupVoiceBusy">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">이석</div>
							<div class="v-div-container-value"><div id="insuranceAgentGroupVoiceNotReady">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">후처리</div>
							<div class="v-div-container-value"><div id="insuranceAgentGroupVoiceAcw">0</div></div>
						</div>
						<div>
							<div class="v-div-container-title">로그인</div>
							<div class="v-div-container-value"><div id="insuranceAgentGroupVoiceLogin">0</div></div>
						</div>
					</div>
				</div>
			</div>
			<div style="width:20%">
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-text">
							보험 컨택센터 현황 (채팅)
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div class="h-div-container" style="height:25%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>대기회원</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceCtiQChatSumRtsWaitCnt">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>대기중</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceAgentGroupChatReady">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>인입호</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceCtiQChatSumConnCnt">0</div></div>
					</div>
					<div class="h-div-container" style="height:25%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>응대호</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div id="insuranceCtiQChatSumAnswerCnt">0</div></div>
					</div>
				</div>
			</div>
			<div style="width:20%">
				<div class="common-div-top">
					<div class="common-div-top-left">
						<div class="common-div-top-left-text">
							보험 최초통화 해결율
						</div>
					</div>
				</div>
				<div class="common-div-bottom">
					<div class="h-div-container" style="height:20%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>인입(IVR)</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%; font-size:20px; color:white;"><div>연결시도</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>1차 상담 인입/재인입</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>업무이관</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
					<div class="h-div-container" style="height:20%; background-color:#C04F15;">
						<div class="h-div-container-title" style="width:35%;  font-size:20px; color:white;"><div>FCR</div></div>
						<div class="h-div-container-vale" style="width:65%; text-align: center;"><div>⚠ 작업중</div></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>