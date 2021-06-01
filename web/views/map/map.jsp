<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.model.vo.Camp"%>
<%@page import="com.camp.model.dao.CampDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
      integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
      crossorigin="anonymous"
    />
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/mapStyle.css">       
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 
	 <%

	 	CampDao campDao = new CampDao();
	 List<Camp> list = campDao.selectAllMember();

	 %>

    <div class="map_wrap">
      <div
        id="map"
        style="width: 100%; height: 90%; position: relative;" 
      ></div>

      <div id="menu_wrap" class="bg_white">
        <div class="option">
          <div>
            <form onsubmit="searchPlaces(); return false;">
              키워드 :
              <input type="text" value="캠핑장" id="keyword" size="15" />
              <button type="submit">검색하기</button>
            </form>
          </div>
        </div>
        <hr />
        <ul id="placesList">

        <% 
        	for(int i=0; i<list.size(); i++){
        		Camp camp = list.get(i);
        	
        %><div>
        	<div class="camp_name" onclick="panTo(<%=list.get(i).getLatitude()%>, <%=list.get(i).getLongitude()%>)"><%= list.get(i).getName() %></div> <br/>
        	<div class="camp_location" onclick="panTo(<%=list.get(i).getLatitude()%>, <%=list.get(i).getLongitude()%>)">1박당 요금 : <%= list.get(i).getPrice() %></div> <br/>
        	<div class="camp_location" onclick="panTo(<%=list.get(i).getLatitude()%>, <%=list.get(i).getLongitude()%>)"><%= list.get(i).getLocation() %></div> <br/>
        	<button class="snip1535" onclick="location.href='campView.jsp?name=<%=camp.getName()%>'">상세정보</button> <br/><br/>
        	<div class="list_line"></div><br/></div>
        	<%} %> 
        	
        </ul>
        <div id="pagination"></div>
      </div>
    </div>
	<script type="text/javascript">    	
	$(".hover").mouseleave(function () {
    	$(this).removeClass("hover");
  	});
	</script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f9e43696a44b958e8d5154bc1b138b81&libraries=services"
    ></script>
    <script>

    
      const mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(36.64213353295997, 127.87458257769703), // 지도의 중심좌표
          level: 12, // 지도의 확대 레벨
        };

      // 지도를 생성합니다
      const map = new kakao.maps.Map(mapContainer, mapOption);

      // 마커가 표시될 위치입니다

      function markerTest(latitude, longitude){
    	  return new kakao.maps.LatLng(latitude, longitude);
      };

      // 마커 생성
      // 마커를 담을 배열
      const markers = [];
      <%for(int i=0; i<list.size(); i++){%>
    	  var mark = new kakao.maps.Marker({
    	        position: markerTest(<%=list.get(i).getLatitude()%>, <%=list.get(i).getLongitude()%>)
    	      });
    	  markers.push(mark);
    	  mark.setMap(map);
    	  
    	  var content = '<div class="marker_title"><%= list.get(i).getName() %> </div> ';
    	  
    	  var customOverlay = new kakao.maps.CustomOverlay({
    		    position : markerTest(<%=list.get(i).getLatitude()%>, <%=list.get(i).getLongitude()%>), 
    		    content : content,
    		    yAnchor: 2.2
    		});
    	  customOverlay.setMap(map);
     <%}%>;




     
      // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
      //const infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

      // 검색 결과 목록과 마커를 표출하는 함수입니다
      function displayPlaces(places) {
        const listEl = document.getElementById("placesList"),
          menuEl = document.getElementById("menu_wrap"),
          fragment = document.createDocumentFragment(),
          bounds = new kakao.maps.LatLngBounds(),
          listStr = "";

        /*         // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl); */

        for (let i = 0; i < places.length; i++) {
          // 마커를 생성하고 지도에 표시합니다
          let placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

          // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
          // LatLngBounds 객체에 좌표를 추가합니다
          bounds.extend(placePosition);

          // 마커와 검색결과 항목에 mouseover 했을때
          // 해당 장소에 인포윈도우에 장소명을 표시합니다
          // mouseout 했을 때는 인포윈도우를 닫습니다
          (function (marker, title) {
            kakao.maps.event.addListener(marker, "mouseover", function () {
              displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, "click", function () {
              infowindow.close();
            });

            itemEl.onmouseover = function () {
              displayInfowindow(marker, title);
            };

            itemEl.onmouseout = function () {
              infowindow.close();
            };
          })(marker, places[i].place_name);

          fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
      }

      // 검색결과 항목을 Element로 반환하는 함수입니다
      function getListItem(index, places) {
        let el = document.createElement("li"),
          itemStr =
            '<span class="markerbg marker_' +
            (index + 1) +
            '"></span>' +
            '<div class="info">' +
            "   <h5>" +
            places.place_name +
            "</h5>";

        if (places.road_address_name) {
          itemStr +=
            "    <span>" +
            places.road_address_name +
            "</span>" +
            '   <span class="jibun gray">' +
            places.address_name +
            "</span>";
        } else {
          itemStr += "    <span>" + places.address_name + "</span>";
        }

        itemStr += '  <span class="tel">' + places.phone + "</span>" + "</div>";

        el.innerHTML = itemStr;
        el.className = "item";

        return el;
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, idx, title) {
        const imageSrc =
            "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
          imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(
            imageSrc,
            imageSize,
            imgOptions
          ),
          marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
          });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
      }

      // 지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
        for (let i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
        }
        markers = [];
      }

      // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
      function displayPagination(pagination) {
        let paginationEl = document.getElementById("pagination"),
          fragment = document.createDocumentFragment(),
          i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
          paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
          const el = document.createElement("a");
          el.href = "#";
          el.innerHTML = i;

          if (i === pagination.current) {
            el.className = "on";
          } else {
            el.onclick = (function (i) {
              return function () {
                pagination.gotoPage(i);
              };
            })(i);
          }

          fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
      }

      // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
      // 인포윈도우에 장소명을 표시합니다
      function displayInfowindow(marker, title) {
        let content = '<div style="padding:5px;z-index:1;">' + title + "</div>";

        infowindow.setContent(content);
        infowindow.open(map, marker);
      }

      // 검색결과 목록의 자식 Element를 제거하는 함수입니다
      function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
          el.removeChild(el.lastChild);
        }
      }

      // ----------- 위도 경도 콘솔 메세지 기능

      const checkMarker = new kakao.maps.Marker({
        // 지도 중심좌표에 마커를 생성합니다
        position: map.getCenter(),
      });
      // 지도에 마커를 표시합니다
      checkMarker.setMap(map);

      // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
      kakao.maps.event.addListener(map, "click", function (mouseEvent) {
        // 클릭한 위도, 경도 정보를 가져옵니다
        const latlng = mouseEvent.latLng;

        // 마커 위치를 클릭한 위치로 옮깁니다
        checkMarker.setPosition(latlng);

        let message = "클릭한 위치의 위도는 " + latlng.getLat() + " 이고, ";
        message += "경도는 " + latlng.getLng() + " 입니다";

        const resultDiv = document.getElementById("clickLatlng");
        console.log(message);
      });
		
      const campName = document.querySelector('.camp_name');
      const campLocation = document.querySelector('.camp_location');
      
      function panTo(a,b){
        var moveLatLon = new kakao.maps.LatLng(a, b);
        map.panTo(moveLatLon); 
      }
      
      </script>
      

</body>
</html>