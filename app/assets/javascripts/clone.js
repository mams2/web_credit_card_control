var ct = 1;
function new_link()
{
	ct++;
	var div1 = document.createElement('div');
	div1.id = ct;
	div1.innerHTML = document.getElementById('clone_new_link_tpl').innerHTML;
	document.getElementById('clone_new_link').appendChild(div1);
}

function del(eleId)
{
	if(ct>1){
		d = document;
		var ele = d.getElementById(ct);
		var parentEle = d.getElementById('clone_new_link');
		parentEle.removeChild(ele);
		ct--;
	}
	else{
		alert("É necessário ter pelo menos 1 comprador");
	}	
}
