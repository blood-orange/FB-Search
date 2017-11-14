<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Method:GET, POST');
header('Access-Control-Allow-Headers:x-requested-with,content-type');


//header('Content-type: application/json');
$Your_Access_Token = "EAAFkJEOGkt0BAPFQ3X2BFdM6aXcID1pNKatEZCQ3snsLlFkBRX1YBp2nSyUEwudZBYdx6TY0oZApBF2txZC8PQb9PuwEa7kSPz1uIoZBJk3HXmZAqTZCaWoXGp3Y3s4KztPdxQCvLbmgL4ZC5KZC9vWXvhU3vT53GuSEZD";
$YOUR_API_KEY = "AIzaSyCpRXmWUYioeLjmo8nAqRTZ3FuN-F6H5N8";


if(isset($_GET['keyword'])&&isset($_GET['type'])) {

    $keyword = urlencode($_GET['keyword']);
    $type = urlencode($_GET['type']);

    //echo $keyword;
    if($type != "place"){
        $userApi = "https://graph.facebook.com/v2.8/search?q=" . $keyword . "&type=" . $type . "&fields=id,name,picture.width(700).height(700)&limit=10&offset=0&access_token=" . $Your_Access_Token;
    }
    else{
        $lat = $_GET["lat"];
        $lon = $_GET["lon"];
        $userApi = "https://graph.facebook.com/v2.8/search?q=" . $keyword . "&type=" . $type . "&fields=id,name,picture.width(700).height(700)&limit=10&offset=0&center=".$lat.",".$lon."&access_token=" . $Your_Access_Token;
    }
    $userjson = file_get_contents($userApi);
    echo $userjson;
}

if(isset($_GET['id'])){
    $id= $_GET['id'];
    $albumApi = "https://graph.facebook.com/v2.8/".$id."?fields=albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5)&access_token=".$Your_Access_Token;
    //https://graph.facebook.com/v2.8/622280747961819?fields=albums.limit(5){name,photos.limit(2){name,picture}},posts.limit(5){created_time}&access_token=EAAFkJEOGkt0BAPFQ3X2BFdM6aXcID1pNKatEZCQ3snsLlFkBRX1YBp2nSyUEwudZBYdx6TY0oZApBF2txZC8PQb9PuwEa7kSPz1uIoZBJk3HXmZAqTZCaWoXGp3Y3s4KztPdxQCvLbmgL4ZC5KZC9vWXvhU3vT53GuSEZD
    $albumjson = file_get_contents($albumApi);
    echo $albumjson;
}



?>