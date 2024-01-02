<%@page import="util.SessionManager"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.ProductOptionDao"%>
<%@page import="dto.ProductOptionDto"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartItemDao"%>
<%@page import="dto.CartItemDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//String id = (String)session.getAttribute("id");
	String id = "dum1";
	MemberDto memberDto = SessionManager.getMember(request);
	List<CartItemDto> cartList =CartItemDao.getInstance().getList();
	if(id!=null){
		cartList = cartList.stream().filter(c->c.getBuyerId().equals(id)).collect(Collectors.toList());
	}
	int totalPrice = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cart/cart.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
	//모달창 css
	.modal--bg {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        .modal {
            background: white;
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 300px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            
            padding: 10px;
        }
        .header {
            padding-left: 10px;
            display: inline;
            
        }
        .header h3{
            display: inline;
        }
        .header .close-area{
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            
        }
        .modal .content{
            margin-top: 20px;
            padding: 0px 10px;
            color: black;
        }

        .hidden {
            background-color: white;
            display: none;
        }
        .visible {
            display: block;
        }
        
        table a {
        	text-decoration: none;
        }
</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container">
        <div class="textArea">
            <h2>장바구니</h2>
            <p><img src="https://img.echosting.cafe24.com/skin/base_ko_KR/order/img_order_step1.gif" alt="" /></p>
        </div>
        <div class="info">
        	<p><%=memberDto.getName() %> 님은, [<%=memberDto.getRank() %>] 회원이십니다</p>
        </div>
        <div class="basket">
            <table class="table-bordered">
                <colgroup>
                    <col style="width:27px">
                    <col style="width:92px">
                    <col style="width:auto">
                    <col style="width:88px">
                    <col style="width:110px">
                    <col style="width:98px"> 
                    <col style="width:110px">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">
                            <input type="checkbox" id="checkAll">
                        </th>
                        <th scope="col">이미지</th>
                        <th scope="col">상품정보</th>
                        <th scope="col">수량</th>
                        <th scope="col">상품구매금액</th>
                        <th scope="col">배송비</th>
                        <th scope="col">선택</th>
                    </tr>
                </thead>
                <tbody>
                    <%for(CartItemDto tmp:cartList){ 
                    	ProductDto productDto = ProductDao.getInstance().getData(tmp.getProductId());
                    	ProductOptionDto optionDto = ProductOptionDao.getInstance().getData(tmp.getOptionId());
                    	
                    	int price = productDto.getSalesState().equals("on_sale")? productDto.getSalePrice() : productDto.getOrgPrice();
                    	int itemPrice = (price+optionDto.getAdditionalPrice())*tmp.getAmount();
                    	totalPrice += itemPrice;
                    %>
                    
                    <tr>
                    	<td>
                        	<input type="checkbox" class="chk" onclick="check">
                        </td>
                        <td>
                        	<a href="${pageContext.request.contextPath}/product/productDetail?productId=<%=tmp.getProductId()%>"><img src="<%=productDto.getThumbnail()%>" width="100px" height="150px"></a>
                        </td>
                        <td>
                            <ul>
                                <li> <strong><a href="${pageContext.request.contextPath}/product/productDetail?productId=<%=tmp.getProductId()%>"><%=productDto.getTitle() %></a></strong></li>
                                <li>옵션 : <%=optionDto.getDescription() %></li>
                                <li><button id="optBtn">옵션변경</button></li>
                            </ul>
                        </td>
                        <td>
                            <span style="display: flex; align-items: center;">
                                <input type="text" value="<%=tmp.getAmount() %>" readonly>
                                <div style="display: flex; flex-direction: column; justify-content: center;">
	                                <a href="${pageContext.request.contextPath}/cart/cartUpdate.jsp?cartItemId=<%=tmp.getCartItemId()%>&amount=<%=tmp.getAmount()+1%>" style="font-size:0px;">
	                                    <img src="https://img.echosting.cafe24.com/design/skin/default/product/btn_count_up.gif"/>
	                                </a>
	                                <a href="${pageContext.request.contextPath}/cart/cartUpdate.jsp?cartItemId=<%=tmp.getCartItemId()%>&amount=<%=tmp.getAmount()-1%>" style="font-size:0px;">
	                                    <img src="https://img.echosting.cafe24.com/design/skin/default/product/btn_count_down.gif"/>
	                                </a>
                                </div>
                            </span>
                        </td>
                        <td>
                            <strong><%=itemPrice %></strong>
                        </td>
                        <td>
                            <strong><%=itemPrice>50000 ? "무료" : 2500 %></strong>
                        </td>
                        <td>
                            <a href="">주문하기</a>
                            <br />
                            <a href="${pageContext.request.contextPath}/cart/cartDelete.jsp?cartItemId=<%=tmp.getCartItemId()%>">삭제</a>
                        </td>
                    </tr>
                    <div class="modal--bg hidden">
				        <div class="modal" style="display:block">
				            <div class="header">
				                <h3>옵션변경</h3>
				                <div class="close-area">X</div>
				            </div>
				            <div class="content">
				                <ul class="prdInfo"><li ><%=productDto.getTitle() %></li>
				                    <li ></li>
				                </ul>
				                <div class="prdModify">
				                    <h4>상품옵션</h4>
				                    <ul><li style="display:none;"><span>{$option_name}</span> {$form.option_value}</li>
				                        <li class="ec-basketOptionModifyLayer-options"><span>같이구매하기</span>
				                            <span><select  option_title="같이구매하기"  name="option1" id="product_option_id1" class="ProductOption0" option_style="select" required="true">
				                                <option value="*" selected="" link_image="">- [필수] 같이구매하기 선택 -</option>
				                                
				                                
				                            </select></span>
				                        <li style="display:none;"><span>{$option_name}</span> {$form.option_value}</li>
				                    </ul>
				                </div>
				            </div>
				            <div class="button">
				                <a href="#none">추가</a>
				                <a href="#none">변경</a>
				            </div>
				        </div>
				    </div>
                    <%} %>
                </tbody>
            </table>
        </div>
        <div class="total">
        	<h2>총계</h2>
            <table class="table-bordered">
                <thead>
                    <tr>
                        <th>총상품금액</th>
                        <th>총배송비</th>
                        <th>결제예정금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%=totalPrice %> </td>
                        <td><%=totalPrice>50000 ? 0 : 2500%></td>
                        <td><%=totalPrice>50000 ? totalPrice : totalPrice+2500%></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="order">
            <a href="">전체상품주문</a>
            <a href="">선택상품주문</a>
        </div>
    </div>
    
	<script>
	//체크박스
	    document.querySelector('#checkAll').addEventListener('click', ()=>{
	        const isChecked = checkAll.checked;
	        if(isChecked){
	            const checkBoxes = document.querySelectorAll('.chk');
	            checkBoxes.forEach((checkBox)=>{
	                checkBox.checked = true;
	            })
	        }else{
	            const checkBoxes = document.querySelectorAll('.chk');
	            checkBoxes.forEach((checkBox)=>{
	                checkBox.checked = false;
	            })
	
	        }
	    })
       function check(checkBox){
       const isChecked = checkBox.checked;
       if(isChecked){
           checkBox.checked=false;
       }else{
           checkBox.checked=true;
       }
		}
	
	 //옵션변경 모달
        const modal = document.querySelector('.modal--bg');

        function showModal(){
            modal.classList.remove('hidden');
            modal.classList.add('visible');
        }
        function closeModal(){
            modal.classList.add('hidden');
            modal.classList.remove('visible');
        }
        document.querySelector('#optBtn').addEventListener("click", showModal );
        document.querySelector('.close-area').addEventListener("click", closeModal);
  
	    
	</script>
	<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>