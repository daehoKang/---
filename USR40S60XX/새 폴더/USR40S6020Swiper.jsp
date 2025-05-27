<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/registTaglib.jsp"%>
<title><c:out value="${sessionVO.programName}" /></title>
<link rel="stylesheet" href="/BT-EMS/css/swiper.min.css" type="text/css" />
<style>
	.swiper-container-wrapper {
		position: relative;
		width: 100%;
		height: 500px;
	}
	.mySwiper {
		width: 100%;
		height: 100%;
	}
	#iframes {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
	
	#iframes iframe {
		position : absolute;
		width: 100%;
		height: 100%;
		border: none;
		opacity: 0;
		transition: opacity 0.3s ease;
		pointer-events: none;
	}
	
	#iframes iframe.active {
		opacity: 1;
		pointer-events: auto;
	}
</style>


<body>
	<div class="swiper-container-wrapper">
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide" data-slide="0"></div>
				<div class="swiper-slide" data-slide="1"></div>
			</div>
		</div>
	</div>
	
	<div id="iframes">
		<iframe id="iframe-0" data-iframe="0" src="/BT-EMS/usr/board/USR40S6020.do" class="active"></iframe>
		<iframe id="iframe-1" data-iframe="1" src="/BT-EMS/usr/board/USR40S6021.do"></iframe>
	</div>
	
	<script src="/BT-EMS/scripts/swiper.min.js"></script>
	<script type="text/javascript">
		const swiper = new Swiper('.mySwiper', {
			loop: true
			,autoplay: {
				delay: 5000
				,disableOnInteraction: false
			}
			,allowTouchMove: false
			,speed: 1500 
			,on: {
				slideChange: function() {
					const realIndex = swiper.realIndex;
					document.querySelectorAll("#iframes iframe").forEach((iframe) => {
						iframe.classList.toggle("active", iframe.dataset.iframe == realIndex);
					});
				}
			}
		});
	</script>
	
</body>


