function validate()
{
    var name = document.getElementById("name").value;
    var phone = document.getElementById("phone").value;
    var email = document.getElementById("email").value;
    var exphrs = document.getElementById("exphrs").value;

    if(name.trim()==="")
    {
        alert("Name is required.");
        return false;
    }
    var phoneRegX = /^\d{10}$/;
    if(!phoneRegX.test(phone))
    {
        alert("Please Enter Valid Phone Number");
        return false;
    }
    var emailRegx = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if(!emailRegx.test(email))
    {
        alert("Please Enter Valid Email");
        return false;
    }
    
    if(exphrs.trim()==="" || isNaN(exphrs))
    {
        alert("Please Provide Exprected Hours of Working");
        return false;
    }

    return true;
}