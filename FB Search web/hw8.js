$(function(){
    $('#tabs a:first').tab('show');
});
window.fbAsyncInit = function() {
    FB.init({
        appId      : '391581891203805',
        xfbml      : true,
        version    : 'v2.8'
    });
    FB.AppEvents.logPageView();
};
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

var app = angular.module('myApp', ['ngAnimate'])

.directive('progress', function () {
    return {
        restrict: 'E',
        replace:true,
        template: ' <div class="progress"  ><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:50%"></div> </div>',
        link: function (scope, element, attr) {
            scope.$watch('progress', function (val) {
                if (val)
                    $(element).show();
                else
                    $(element).hide();
            });
        }
    }
})

app.controller('myCtrl', function($scope,$http) {
    $scope.showtable =  false;
    $scope.showturn = false;
    $scope.showdetails = false;
    $scope.showcontainer = true;
    $scope.favorite = false;
    $scope.progress=false;
    $scope.Your_Access_Token = "EAAFkJEOGkt0BAPFQ3X2BFdM6aXcID1pNKatEZCQ3snsLlFkBRX1YBp2nSyUEwudZBYdx6TY0oZApBF2txZC8PQb9PuwEa7kSPz1uIoZBJk3HXmZAqTZCaWoXGp3Y3s4KztPdxQCvLbmgL4ZC5KZC9vWXvhU3vT53GuSEZD";
    $scope.crd ="";
    var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
    };
    function error(err) {
        console.warn(err.message);
    };

    function success(pos) {
        $scope.crd = pos.coords;

    };

    navigator.geolocation.getCurrentPosition(success,error,options);


    $scope.Search = function () {
        // alert($('#tabs li.active a').attr('id'));
        $('#searchbar').tooltip('destroy');

        if($('#searchbar').val()!=''){
            $scope.showcontainer = true;
            $scope.showdetails = false;
            $scope.showtable = false;
            $scope.showturn = false;
            $scope.progress = true;
            if($('#tabs li.active a').attr('id')!="favorite")
                $scope.type = $('#tabs li.active a').attr('id');
            $scope.pre = {'user': [],'page':[],'event': [],'place':[],'group':[]};

            $http({
                method: "GET",
                url: "http://sample-env.mwgvzivzak.us-west-2.elasticbeanstalk.com/test.php",//?keyword="+$('#searchbar').val()+"&type="+$('#tabs li.active a').attr('id'),
                params: {
                    keyword: $('#searchbar').val(),
                    type: $scope.type,
                    lat: $scope.crd.latitude,
                    lon: $scope.crd.longitude,
                },
            }).then(function successCallback(response) {
                $scope.progress = false;
                $scope.showcontainer = true;
                $scope.showtable = true;


                $scope.text = response.data;
                $scope.paging = response.data.paging;

                $scope.pre[$scope.type] = {data: $scope.text,paging: $scope.paging};
                if($('#tabs li.active a').attr('id')=="favorite"){
                    $scope.favorite = true;
                    $scope.showturn = false;
                }
                else{
                    $scope.showturn = true;
                }

                console.log($scope.pre);
            });

            }

        else{
            $('#searchbar').tooltip('show');
        }

    }

    $scope.Switch =function ($event) {
        $scope.type = $event.currentTarget.id;
        //console.log($event.currentTarget.id);

    if($('#searchbar').val()!='') {
        $scope.progress = false;
        $scope.showdetails = false;
        $scope.showcontainer = true;
        $scope.showtable = true;
        $scope.showturn = true;
        $scope.favorite = false;

        if ($scope.pre[$scope.type].length != 0) {

            $scope.text = $scope.pre[$scope.type].data;
            $scope.paging = $scope.pre[$scope.type].paging;


        }
        else {

            $http({
                method: "GET",
                url: "http://sample-env.mwgvzivzak.us-west-2.elasticbeanstalk.com/test.php",//?keyword="+$('#searchbar').val()+"&type="+$('#tabs li.active a').attr('id'),
                params: {
                    keyword: $('#searchbar').val(),
                    type: $scope.type,
                    lat: $scope.crd.latitude,
                    lon: $scope.crd.longitude,
                },
            }).then(function successCallback(response) {
                //console.log(response);

                $scope.text = response.data;
                $scope.paging = response.data.paging;
                //console.log($scope.paging);
                $scope.pre[$scope.type] = {data: $scope.text,paging: $scope.paging};
                console.log($scope.pre);

            });
        }
    }

    }


    $scope.clear = function () {
        $scope.showcontainer=false;
        $scope.showtable=false;
        $scope.favorite=false;
        $scope.showturn =false;
        $scope.showdetails = false;
        $scope.pre = {'user': [],'page':[],'event': [],'place':[],'group':[]};
        $('#searchbar').val("");
        $('#tabs a:first').tab('show');
    }

    $scope.favdata =[];


    for( var i in localStorage){
        if(localStorage.getItem(i)!=null)
            $scope.favdata.push(JSON.parse(localStorage.getItem(i)));
        console.log( $scope.favdata);
    }


    $scope.delete =function (indexid) {
        console.log(indexid);
        localStorage.removeItem(indexid);
        $scope.favdata.length = 0;
        for( var i in localStorage){
            if(localStorage.getItem(i)!=null)
                $scope.favdata.push(JSON.parse(localStorage.getItem(i)));
            //console.log(JSON.parse(localStorage.getItem(i)));
        }
    }


    $scope.Favorite = function () {

        $scope.showcontainer=true;
        $scope.showtable = true;
        $scope.favorite = true;
        $scope.showdetails = false;
        $scope.showturn=false;

    }


    $scope.star =function (id,name,pic,type) {
        var indexid = id+type;
        console.log("star indexid:"+indexid);
        if(indexid in localStorage){
            $scope.delete(indexid);
        }
        else{
            var favjson = {id:id,name:name,pic:pic,type:type};
            //console.log(fav);
            localStorage.setItem(indexid, JSON.stringify(favjson));

            $scope.favdata.push(JSON.parse(localStorage.getItem(indexid)));
            console.log($scope.favdata);

        }

    }

    $scope.check = function (id,type) {
       console.log("$scope.type in check"+type);
        var indexid = id+type;
        //console.log(indexid);
        if(localStorage[indexid]!=null){
            return "glyphicon glyphicon-star";
        }
        else{
            return "glyphicon glyphicon-star-empty";
        }
    }

    $scope.checkfirst= function (index) {
        if(index==0){
            return "in";
        }
        else return "";
    }

    $scope.previous = function(){
        $http.get($scope.paging.previous).then(function successCallback(response) {
            //$("#test").text(response);
            //console.log(response);
            $scope.text = response.data;
            $scope.paging = response.data.paging;
            $scope.pre[$scope.type]={'data':$scope.text,'paging':$scope.paging} ;
            console.log($scope.pre);
        });
    }

    $scope.next = function(){
        //console.log($scope.paging.next);
        $http.get($scope.paging.next).then(function successCallback(response) {
            //$("#test").text(response);
            //console.log(response);
            $scope.text = response.data;
            $scope.paging = response.data.paging;
            $scope.pre[$scope.type]={'data':$scope.text,'paging':$scope.paging} ;
            console.log($scope.pre);
        });
    }

    $scope.details = function (id,picture,name,type) {

        $scope.showtable = false;
        $scope.favorite=false;
        $scope.showcontainer = false;
        $scope.showturn = false;
        $scope.showalbum = false;
        $scope.showpost = false;

        $scope.showdetails = true;
        $scope.showbarI = true;
        $scope.currentid = id;
        $scope.picture = picture;
        $scope.name = name;
        $scope.type = type;
        //console.log(name);
        setTimeout(function()
        {
            $scope.$apply(function()
            {
                $scope.showbarI = false;
                $scope.showalbum = true;
                $scope.showpost = true;
            });
        }, 1000);

        $http({
            method: "GET",
            url: "test.php",//?keyword=+$('#searchbar').val()+"&type="+$('#tabs li.active a').attr('id'),
            params: {
                id:id,
            },
        }).then(function successCallback(response) {
            //$("#test").text(response);

            $scope.detaildata = response.data;
            //console.log(response);

        });
    }



    $scope.back = function () {
        $scope.showalbum = false;
        $scope.showpost = false;
        $scope.showdetails = false;
        $scope.showcontainer = true;
        $scope.showtable = true;

        if($('#tabs li.active a').attr('id')=='favorite'){
            $scope.favorite = true;
        }
        else{
            $scope.showturn = true;
        }
    }

    $scope.post = function () {
        FB.ui({
            app_id:'391581891203805',
            method: 'feed',
            href: 'http://cs-server.usc.edu:21828/hw8/hw8.html',
            picture: $scope.picture,
            name:$scope.name,
            caption: "FB SEARCH FROM USC CSCI571",
        }, function(response){
            if (response && !response.error_message)
                alert("Posted Successfully");
            else{
                alert("Not Posted");
            }
        });
    }

});

