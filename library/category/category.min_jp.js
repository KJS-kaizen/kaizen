$(function(){var d=$(".mode").data("limit")-1;d<0&&(d=3);var l="1-0x0";$('input[name="category[]"]').each(function(){var e=$(this).val().split("-"),t=l.split("-");parseInt(e[0])>=parseInt(t[0])&&parseInt(e[1])>parseInt(t[1])&&(l=$(this).val()),parseInt(e[0])>parseInt(t[0])&&(l=$(this).val())});var e=navigator.userAgent.toLowerCase(),o=0,c=0;function t(){$('input[name="category[]"]').each(function(e){$(this).attr("id",e),$(".label").eq(e).attr("for",e)}),$('input[name="folder"]').each(function(e){$(this).attr("id","m"+e),$(".angle").eq(e).attr("for","m"+e)})}function r(){$(".angle").css("display","none"),p(),$(".add1, .add2, .up1, .up2, .down1, .down2").css("display","inline-block"),n(),$(".label").attr("contenteditable",!0),$(".label").addClass("select"),window.matchMedia("(min-width:736px)").matches?$(".mark, .label").css("margin","3px 0px"):($(".mark, .label").css("margin","1px 0px"),$(".mark").css({"line-height":"36px",height:"36px"}),$(".label").css("font-size","16px")),$(".padding2").css("padding-left","0px")}function n(){$(".item1:first-of-type > .up1").text(" ").addClass("up1d").removeClass("up1"),$(".item2:first-of-type > .up2").text(" ").addClass("up2d").removeClass("up2"),$(".item1:last-of-type > .down1").text(" ").addClass("down1d").removeClass("down1"),$(".item2:last-of-type > .down2").text(" ").addClass("down2d").removeClass("down2")}function p(){$(".item1:first-of-type > .up1d").text("").addClass("up1").removeClass("up1d"),$(".item2:first-of-type > .up2d").text("").addClass("up2").removeClass("up2d"),$(".item1:last-of-type > .down1d").text("").addClass("down1").removeClass("down1d"),$(".item2:last-of-type > .down2d").text("").addClass("down2").removeClass("down2d")}0<e.indexOf("trident")&&(o=1),(0<e.indexOf("edge")||0<e.indexOf("firefox"))&&(c=1),o&&($(".label").css("padding","12px 3px 7px 4px"),$(".view1").css("padding","7px 3px 2px 4px")),c&&$(".true, .false").css("font-weight","normal"),$("ul.padding").each(function(){var e=0,t="",a=$(this).prevAll(".item2").children('input[name="save[]"]');if(a.val()){var n=a.val().split("{}");e=parseInt(n[0]),t=n[1]}e!=d&&$(this).append('<label class="mark add2" data-category="'+(e+1)+'" data-value="'+l+'" data-parent="'+t+'">&#xf0fe;</label>'),$(this).append('<label class="mark add1" data-category="'+(e+1)+'" data-value="'+l+'" data-parent="'+t+'">&#xf055;</label>'),$(this).children("div").contents().unwrap(),$(this).children(".item1, .add1").wrapAll('<div class="padding2">'),$(this).children("div").appendTo($(this))}),t(),$(document).on("change",'input[name="folder"]',function(){$(this).parent(".item2").next("ul").animate({height:"toggle"},"fast","swing"),$(this).prop("checked")?$(this).nextAll(".label").addClass("shadow"):$(this).nextAll(".label").removeClass("shadow")}),$(document).on("change",'input[name="category[]"]',function(){var e=$(this).prev('input[name="save[]"]').val().split("{}"),t=e[0]-1,a=$("input[data-category"+e[0]+"="+$(this).val()+"]"),n=$(this);if($(this).prop("checked")){if(t<=1?a.prop("checked",!0).change():a.prop("checked",!0),1<=t)for(i=t;0<i;i--)(n=$('input[value="'+n.data("category"+i)+'"][name="category[]"]')).prop("checked",!0)}else if(t<=1?a.prop("checked",!1).change():a.prop("checked",!1),1<=t)for(i=t;0<i;i--)$("input[data-category"+i+"="+n.data("category"+i)+"]:checked").length||(n=$('input[value="'+n.data("category"+i)+'"][name="category[]"]')).prop("checked",!1)}),$(document).on("change",'input[name="permission[]"]',function(){var e=$(this).prev('input[name="save[]"]').val().split("{}"),t=e[0]-1,a=$("input[data-pcategory"+e[0]+"="+$(this).val()+"]"),n=$(this);if($(this).prop("checked")){if(t<=1?a.prop("checked",!0).change():a.prop("checked",!0),1<=t)for(i=t;0<i;i--)(n=$('input[value="'+n.data("permission"+i)+'"][name="permission[]"]')).prop("checked",!0)}else t<=1?a.prop("checked",!1).change():a.prop("checked",!1)}),$("#toggle").on("change",function(){$("#toggle").prop("checked")?($("#text").html('<i class="fas fa-pencil-alt fa-fw"></i>編集モード').css("color","#b7472a"),$('input[name="category[]"]').each(function(e){$(this).removeAttr("id"),$(".label").eq(e).removeAttr("for")}),$('input[name="folder"]').prop("checked",!1),$("ul.padding").css("display",""),$(".item2").children(".label").removeClass("shadow"),r()):(2==$("#toggle").data("mode")?$("#text").html('<i class="fas fa-tablet-alt fa-fw"></i>閲覧モード').css("color",""):$("#text").html('<i class="far fa-hand-point-up fa-fw"></i>選択モード').css("color",""),t(),$(".angle").css("display",""),p(),$(".add1, .add2, .del1, .del2, .up1, .up2, .down1, .down2").css("display",""),$(".label").removeAttr("contenteditable"),$(".label").removeClass("select"),window.matchMedia("(min-width:736px)").matches?$(".mark, .label").css("margin",""):($(".mark, .label").css("margin",""),$(".mark").css({"line-height":"",height:""}),$(".label").css("font-size","")),$(".padding2").css("padding-left",""))}),$(document).on("focus",".label",function(){p(),$(this).prevAll(".up1").text("").addClass("del1").removeClass("up1"),$(this).prevAll(".up2").text("").addClass("del2").removeClass("up2"),n(),$(this).next(".down1").text(" ").addClass("down1d").removeClass("down1"),$(this).next(".down2").text(" ").addClass("down2d").removeClass("down2"),$(this).css({color:"#333","font-weight":"bold"})}).on("blur",".label",function(){if($(this).text($(this).text().replace(/\n/g,"").replace(/{/g,"").replace(/}/g,"")),!$(this).text()){var e=$(this).attr("class").replace(/ /g,"").replace(/label/g,"").replace("view2","").replace("select","");d<e?$(this).text("名称未設定"):$(this).text("第"+e+"カテゴリー")}var t=$(this).prevAll('input[name="save[]"]'),a=t.val().split("{}");t.val(a[0]+"{}"+a[1]+"{}"+a[2]+"{}"+$(this).text()+"{}"+a[4]),$(this).delay(150).queue(function(){$(this).prevAll(".del1").text("").addClass("up1").removeClass("del1"),$(this).prevAll(".del2").text("").addClass("up2").removeClass("del2"),n(),$(this).stop()}),$(this).next(".down1d").text("").addClass("down1").removeClass("down1d"),$(this).next(".down2d").text("").addClass("down2").removeClass("down2d"),n(),c?$(this).css({color:"","font-weight":"normal"}):$(this).css({color:"","font-weight":""})}),$(document).on("click",".add1, .add2",function(){var e=$(this).data("value").split("-");if("0x40000000"==e[1])var t=parseInt(e[0])+1+"-0x1";else if("0x0"==e[1])t=e[0]+"-0x1";else t=e[0]+"-0x"+(2*e[1]).toString(16);$(".add1, .add2").data("value",t);var a=$(this).data("category"),n="";1!=a&&(n=" data-category"+(a-1)+'="'+$(this).data("parent")+'"');var l=tag2=style="";if(2==$("#toggle").data("mode")&&(l=" disabled",tag2=" view2"),o&&(style="padding:12px 3px 7px 4px"),c&&(style="font-weight:normal"),style&&(style=' style="'+style+'"'),p(),$(this).hasClass("add1"))$(this).before('<span class="item1"><label class="mark up1">&#xf0d9;</label><input type="hidden" name="save[]" value="'+a+"{}"+t+"{}"+$(this).data("parent")+'{}名称未設定{}"><input type="checkbox" name="category[]" value="'+t+'"'+n+l+'><label class="label'+tag2+' label4"'+style+'>名称未設定</label><label class="mark down1">&#xf0da;</label></span>');else{var s="";a!=d&&(s='<label class="mark add2" data-category="'+(a+1)+'" data-value="'+t+'" data-parent="'+t+'">&#xf0fe;</label>'),$(this).before('<span class="item2"><input type="checkbox" name="folder"><label class="mark angle">&#xf078;</label><label class="mark up2">&#xf0d8;</label><input type="hidden" name="save[]" value="'+a+"{}"+t+"{}"+$(this).data("parent")+"{}第"+a+'カテゴリー{}"><input type="checkbox" name="category[]" value="'+t+'"'+n+l+'><label class="label'+tag2+" label"+a+'"'+style+">第"+a+'カテゴリー</label><label class="mark down2">&#xf0d7;</label></span>\n<ul class="padding">\n'+s+'<div class="padding2"><label class="mark add1" data-category="'+(a+1)+'" data-value="'+t+'" data-parent="'+t+'">&#xf055;</label></div></ul>\n')}r()}),$(document).on("click",".del1, .del2",function(){var e=$(this).nextAll(".label").text();$(this).hasClass("del1")?confirm("「"+e+"」を削除しますか？")&&$(this).parent(".item1").remove():confirm("「"+e+"」を削除しますか？ 階層下の項目も削除されます")&&($(this).parent(".item2").next("ul").remove(),$(this).parent(".item2").remove()),n();var t=$(this).next('input[name="save[]"]').val().split("{}")[0]-1,a=$(this).nextAll('input[name="category[]"]');if(1<=t)for(i=t;0<i;i--)$("input[data-category"+i+"="+a.data("category"+i)+"]:checked").length||(a=$('input[value="'+a.data("category"+i)+'"]')).prop("checked",!1)}),$(document).on("click",".up1, .up2",function(){p(),$(this).hasClass("up1")?$(this).parent(".item1").insertBefore($(this).parent(".item1").prev(".item1")):($(this).parent(".item2").next("ul").insertBefore($(this).parent(".item2").prev("ul").prev(".item2")),$(this).parent(".item2").insertBefore($(this).parent(".item2").prev("ul").prev(".item2").prev("ul"))),n()}),$(document).on("click",".down1, .down2",function(){p(),$(this).hasClass("down1")?$(this).parent(".item1").insertAfter($(this).parent(".item1").next(".item1")):($(this).parent(".item2").next("ul").insertAfter($(this).parent(".item2").next("ul").next(".item2").next("ul")),$(this).parent(".item2").insertAfter($(this).parent(".item2").next(".item2").next("ul"))),n()}),$("input[type=checkbox]").on("change",function(){$(window).on("beforeunload",function(){return"行った変更は保存されません。"})}),$(".alert").on("click",function(){$(window).off("beforeunload")}),$("form").on("submit",function(){$(window).off("beforeunload")}),window.history&&window.history.pushState&&(history.pushState("dummy",null,""),$(window).on("popstate",function(e){e.originalEvent.state||history.pushState("dummy",null,"")})),$("#copy").on("click",function(){var e=$('input[name="string"]').val();if(e)var t=function(e){var t=document.createElement("textarea");t.textContent=e;var a=document.getElementsByTagName("body")[0];a.appendChild(t),t.select();var n=document.execCommand("copy");return a.removeChild(t),n}(e);t?($("#alert").text(" クリップボードにコピーしました").addClass("true"),$('input[name="string"]').focus().select()):$("#alert").text(" グループ文字がありません").addClass("false"),c&&$("#alert").css("font-weight","normal"),$("#alert").delay(1500).queue(function(){$(this).text(" ").removeClass("true false").dequeue()})}),$('input[name="string"]').on("click",function(e){e.target.setSelectionRange(0,e.target.value.length)}),$(".border").data("calc")&&($(document).on("change",'input[name="category[]"]',function(){$(".border").data("noalert")&&$(window).off("beforeunload");var e=calc=[],a="";$('input[name="category[]"]:checked').each(function(){e=$(this).val().split("-"),calc[e[0]-1]?calc[e[0]-1]+=parseInt(e[1]):calc[e[0]-1]=parseInt(e[1])}),$.each(calc,function(e,t){a+=t?"-"+t.toString(16):"-0"}),a&&(a=a.slice(1)),$('input[name="string"]').val(a)}),$('input[name="string"]').on("keyup change",function(){!$(this).val().match(/^[a-f\d\-]+$/)&&$(this).val()||(calc=$(this).val().split("-"),$.each(calc,function(e,t){calc[e]=t?"0x"+t:0}),calc.unshift(0),$('input[name="category[]"]').each(function(){value=$(this).val().split("-"),calc[value[0]]||(calc[value[0]]=0),$(this).prop("checked",calc[value[0]]&value[1])}))}))});