/*
This script is identical to the above JavaScript function.
*/

var ct = 1;
function new_link()
{
	ct++;
	var div1 = document.createElement('div');
	div1.id = ct;
	// link to delete extended form elements
	// var delLink = '<a href="javascript:delIt('+ ct +')">Del</a>';
	div1.innerHTML = document.getElementById('clone_new_link_tpl').innerHTML; // + delLink;
	document.getElementById('clone_new_link').appendChild(div1);
}
// function to delete the newly added set of elements
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
		alert("É necessário ter pelo menos 1 comprador")
	}
	
}
