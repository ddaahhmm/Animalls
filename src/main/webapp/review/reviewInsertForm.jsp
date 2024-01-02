<%@page import="dto.ProductDto"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<% 
    String rawProductId = request.getParameter("productId"); 

    if (rawProductId == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "product id is null");   
    }
    int productId = Integer.parseInt(rawProductId); 
    ProductDto product =  ProductDao.getInstance().getData(productId); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리뷰 작성</title>
<link rel="stylesheet" href="/Animall/css/common.css" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<style>
	#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
	}
	#myform fieldset legend{
	    text-align: right;
	}
	#myform input[type=radio]{
	    display: none;
	}
	#myform .star{
	    font-size: 3em;
	    color: transparent;
	    text-shadow: 0 0 0 #f0f0f0;
	}
	#myform .star:hover{
	    text-shadow: 0 0 0 #ff753f;
	}
	#myform .star:hover ~ .star{
	    text-shadow: 0 0 0 #ff753f;
	}
	#myform input[type=radio]:checked ~ .star{
	    text-shadow: 0 0 0 #ff753f;
	}
	#reviewContents {
	    width: 100%;
	    height: 500px;
	    padding: 10px;
	    box-sizing: border-box;
	    border: solid 1.5px #D3D3D3;
	    border-radius: 5px;
	    font-size: 16px;
	    resize: none;
	}
	
</style>
</head>
<body class="d-flex flex-column">
    <jsp:include page="/include/navbar.jsp">
        <jsp:param value="review" name="current"/>
    </jsp:include>
    
	<div id="review-insert-container" class="container flex-grow-1 pb-2">
		<h1>리뷰 작성하기</h1>
        <hr />   
        
        <div id="product-overview" class="d-flex p-2 m-2">
            <div >
                <img src="<%= product.getThumbnail() %>" alt="" width=120 height=120/>
            </div>
            <div class="mx-2 px-2">
                <h3 class="py-2"><strong><%= product.getTitle() %></strong></h3>
                <div class="d-flex justify-content-around align-items-baseline">
                    <div style="font-size: 34px;">
                        <span class="text-secondary">★</span>{{ review_stat.avg_review }}                 
                    </div>
                    <p>
                        리뷰수: {{ review_stat.total_count }}
                    </p>
                </div>
                
            </div>
        </div>
        
        <hr />
		<form action="review_insert.jsp" class="mb-3" name="myform" id="myform" method="post">
            <input type="hidden" name="product_id" value="<%= productId %>"/>
			<fieldset>
				<span class="text-bold">별점을 선택해주세요</span>
				<input type="radio" name="review_star" value="5" id="rate5">
				<label class="star" for="rate5">★</label>
				<input type="radio" name="review_star" value="4" id="rate4">
				<label class="star" for="rate4">★</label>
				<input type="radio" name="review_star" value="3" id="rate3">
				<label class="star" for="rate3">★</label>			
				<input type="radio" name="review_star" value="2" id="rate2">
				<label class="star" for="rate2">★</label>
				<input type="radio" name="review_star" value="1" id="rate1">
				<label class="star" for="rate1">★</label>		
			</fieldset>
			<br />
			<textarea class="col-auto form-control mb-2" type="text" id="reviewContents" name="content"
					  placeholder="고객님의 소중한 리뷰를 작성해주세요" ></textarea>	
                      
            <div class="d-flex justify-content-between">
                <input type="file" name="myImage" accept="image/* " />             
                <button type="submit" class="btn btn-primary" >제출</button>
            </div>
			
		</form> 
		
		<img src="" alt="" id="sampleImg"/>
	</div>

    <jsp:include page="/include/footer.jsp">
        <jsp:param value="review" name="current"/>
    </jsp:include>
    
	<script>
	new Vue({
		el: '#review-insert-container', 
		data: {
			"review_stat": { "avg_review": "0", "total_count": 0, "count": [0,0,0,0,0] },
		},
		methods: {
			getReviewStats: async function() {
				const resp = await fetch(`/Animalls/api/review/stats?productId=<%= productId %>`);
				this.review_stat = await resp.json(); 
			},
		}, 
		created: function() {
			this.getReviewStats();
		}
	});
	
	let fileDataString;
	
	const fileInput = document.querySelector('input[type=file]') 
	const form = document.querySelector('#myform');
	
	function getBase64(file) {
		return new Promise((resolve, reject)=> {
			var reader = new FileReader();
			reader.readAsDataURL(file); // 인코딩 작업
			reader.onload = function () {
				resolve(reader.result);
			};	
			reader.onerror = function (error) {
			     reject(error);
			};
	   })
	}
		
	form.addEventListener('submit', async (e) => {
		e.preventDefault(); 
	
		const formdata = new FormData(form);	
		formdata.delete('myImage');
		
		if (fileInput.files.length > 0) {
			const image_data = await getBase64(fileInput.files[0]);	
			formdata.append('image_data', image_data);				
		}
		const resp = await fetch("/Animalls/api/review", {
			method: 'post',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			body: new URLSearchParams(formdata).toString(), 
			credentials: "include",
		})
		const data = await resp.json();
		
		if (data.success) {
			alert(data.message); 
			document.location.href = '/Animalls/product/productDetail.jsp?productId=<%= productId %>'
		} else {
			alert(data.message);
		}
	});
	</script>
</body>
</html>