<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BrandStroy</title>
<link href="/Animalls/css/common.css" rel="stylesheet" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
#brand_wrap img {
	width: 100%;
}
</style>

</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="brandstory" name="current"/>
	</jsp:include>
	
	<div id="container">
		<div id="contents">
			<div id="brand_wrap">
				<div class="section1"><img src="/Animalls/assets/brand/brand_story_img1.jpg"></div>
				<div class="section2"><img src="/Animalls/assets/brand/brand_story_img2.jpg"></div>
				<div class="section3"><img src="/Animalls/assets/brand/brand_story_img3.jpg"></div>
				<div class="section4"><img src="/Animalls/assets/brand/brand_story_img4.png"></div>
			</div>
		</div>
		<hr class="layout">
	</div>
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="brandstory" name="current"/>
	</jsp:include>
</body>
</html>