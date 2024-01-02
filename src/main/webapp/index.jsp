<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>애니모올즈</title>
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<link rel="stylesheet" href="/Animalls/css/common.css" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>


<style>
	.fade-transition {
    transition: all 0.8s ease;
    overflow: hidden;
    visibility: visible;
    opacity: 1;
    position: absolute;
	}
	.fade-enter, .fade-leave {
	    opacity: 0;
	    visibility: hidden;
	}
</style>
<link href="/Animalls/css/carousel.css" rel="stylesheet" type="text/css">
<link href="/Animalls/css/slider.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="index" name="current"/>
	</jsp:include>
	
	<main>
	  <div id="myCarousel" class="carousel slide mb-6 mt-4" data-bs-ride="carousel">
	    <div class="carousel-indicators">
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
	      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
	    </div>
	    <div class="carousel-inner">
	      <div class="carousel-item active">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
	        	<image href="/Animalls/assets/main/img01.png"  width="100%" height="100%"></image>
	        </svg>
	      </div>
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
	        	<image href="/Animalls/assets/main/img02.png"  width="100%" height="100%"></image>
	        </svg>
	      </div>
	      <div class="carousel-item">
	        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
	        <image href="/Animalls/assets/main/img03.png"  width="100%" height="100%"></image>
	        </svg>
	      </div>
	    </div>
	    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
	      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	      <span class="visually-hidden">Previous</span>
	    </button>
	    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
	      <span class="carousel-control-next-icon" aria-hidden="true"></span>
	      <span class="visually-hidden">Next</span>
	    </button>
	  </div>
		
	  
	  <div class="container mb-5">
	  <h2>고객 Pick</h2>
	    <div class="row">
	    
	      <div class="col-lg-3 mb-auto">
		    <a class="text-center" href="#">
		     <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
			     <title>Placeholder</title>
			     <rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect>
		     </svg>
		    </a>
	        <h5 class="fw-normal mt-2 text-left">피부모질 닥터독 사료2kg</h5>
	        <p class="h3 text-left d-inline-block font-weight-bold mb-auto">32,500원</p>
	        <p class="d-block mb-3">리뷰 : 3,751 | ★ 4.7</p>
	      </div>
	      
	      <div class="col-lg-3 mb-auto">
		    <a class="text-center" href="#">
		     <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
			     <title>Placeholder</title>
			     <rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect>
		     </svg>
		    </a>
	        <h5 class="fw-normal mt-2 text-left">피부모질 닥터독 사료2kg</h5>
	        <p class="h3 text-left d-inline-block font-weight-bold mb-auto">32,500원</p>
	        <p class="d-block mb-3">리뷰 : 3,751 | ★ 4.7</p>
	      </div>
	      
	      <div class="col-lg-3 mb-auto">
		    <a class="text-center" href="#">
		     <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
			     <title>Placeholder</title>
			     <rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect>
		     </svg>
		    </a>
	        <h5 class="fw-normal mt-2 text-left">피부모질 닥터독 사료2kg</h5>
	        <p class="h3 text-left d-inline-block font-weight-bold mb-auto">32,500원</p>
	        <p class="d-block mb-3">리뷰 : 3,751 | ★ 4.7</p>
	      </div>
	      
	      <div class="col-lg-3 mb-auto">
		    <a class="text-center" href="#">
		     <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
			     <title>Placeholder</title>
			     <rect width="100%" height="100%" fill="var(--bs-secondary-color)"></rect>
		     </svg>
		    </a>
	        <h5 class="fw-normal mt-2 text-left">피부모질 닥터독 사료2kg</h5>
	        <p class="h3 text-left d-inline-block font-weight-bold mb-auto">32,500원</p>
	        <p class="d-block mb-3">리뷰 : 3,751 | ★ 4.7</p>
	      </div>
	      
	    </div>
	  </div>
	  
	<div id="slider">  
	  <div class="wrapper">
            <div class="poligon">
                 
            </div>
        </div>
        <div class="navg">
            <button id="leftBtn" class="btn btn-outline-light">&larr;</button>
            <button id="rightBtn" class="btn btn-outline-light">&rarr;</button>
        </div>
	</div>
		
	</main>
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="index" name="current"/>
	</jsp:include>
	
	<script>
        //n 각형의 폭을 함수에 전달하면 div 를 배치할때 rotateY 값과 translateZ 가 Object 로 리턴되는 함수 
        function getAngleNtz(n, width) {
            var angle = Math.round(360 / n);
            var tz = Math.round((width / 2) / Math.tan((angle * Math.PI) / (2 * 180)));
            var obj = {
                angle: angle,
                tz: tz
            };
            return obj;
        }

        //n각형
        const n=12;
        //div 의 width
        const width=400;
        // 6 각형 폭은 400px 인 경우 
        const obj=getAngleNtz(n, width);
        //배치하면서 회전시킬 각도
        const angle=obj.angle;
        //배치하면서 z 축 방향으로 평행이동 해야 하는 값
        const tz=obj.tz;


        // 만들어야 할 div 가 n 개 이기 때문에 반복문 n번 돌기
        for(let i=0; i<n; i++){
            //div 를 만들어서 
            const div=document.createElement("div");
            //innerText 를 출력하고 
            div.innerHTML="<img src='/Animalls/assets/slider/slider"+(i+1)+".png'></img>";
            //.poligon 에 추가하기
            document.querySelector(".poligon").append(div);
        }
		
        document.querySelector(".poligon").style.transform="translateZ(-"+tz+"px)";

        // .poligon 안에 있는 모든 div 의 참조값을 배열로 얻어내기
        const divs=document.querySelectorAll(".poligon div");

        //반복문 돌면서 모든 div 에 transform 적용하기
        for(let i=0; i<divs.length; i++){
            let rotate = i*angle;
            divs[i].style.transform="rotateY("+rotate+"deg) translateZ("+tz+"px)";
        }

        // y 축 기준 회전하는 값을 저장할 변수 선언하고 초기값 0 대입
        let rY=0;

        document.querySelector("#leftBtn").addEventListener("click", ()=>{
            rY -= angle;
            document.querySelector(".poligon")
                .style.transform="translateZ(-"+tz+"px) rotateY("+rY+"deg)";
        });

        document.querySelector("#rightBtn").addEventListener("click", ()=>{
            rY += angle;
            document.querySelector(".poligon")
            	.style.transform="translateZ(-"+tz+"px) rotateY("+rY+"deg)";
        });
    </script>    
</body>
</html>