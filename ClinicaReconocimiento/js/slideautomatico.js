var myIndex = 0;
var slideIndex = 0;

carousel();
carousel2();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {
  		myIndex = 1;
  }    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 15000); 
}




function carousel2() {
  var i;
  var x = document.getElementsByClassName("slideFoto");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none"; 
  }
  slideIndex++;
  if (slideIndex > x.length) {
  	 slideIndex = 1;
  	}
  x[slideIndex-1].style.display = "block"; 
  setTimeout(carousel2, 15000); 
 }
