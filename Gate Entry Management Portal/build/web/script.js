function validate()
{
    var name = document.getElementById("name").value;
    var address = document.getElementById("address").value;
    var phone = document.getElementById("phone").value;
    var purpose = document.getElementById("purpose").value;
    var govid = document.getElementById("govid").value;

    if(name.trim()==="")
    {
        alert("Name is required.");
        return false;
    }

    if(address.trim()==="")
    {
        alert("Address is required");
        return false;
    }
    var phoneRegX = /^\d{10}$/;
    if(!phoneRegX.test(phone))
    {
        alert("Please Enter Valid Phone Number");
        return false;
    }
    var idProofSelect = document.getElementById("idProof");
    var idProofInput = document.getElementById("govid");
    if (idProofSelect.value === "Adhar Card") 
    {
        // Validate Adhar Card format (Example validation)
        var adharCardRegex = /^\d{4}\s\d{4}\s\d{4}$/; // Example Adhar Card format
        if (!adharCardRegex.test(idProofInput.value)) 
        {
            alert("Please enter a valid Adhar Card number");
            return false;
        }
    } 
    else if (idProofSelect.value === "Pan Card") {
        // Validate Pan Card format (Example validation)
        var panCardRegex = /^[A-Z]{5}[0-9]{4}[A-Z]$/; // Example Pan Card format
        if (!panCardRegex.test(idProofInput.value)) 
        {
            alert("Please enter a valid Pan Card number");
            return false;
        }
    }
    else
    {
        alert("Please provide any ID Proof");
        return false;
    }
    if(purpose.trim()==="")
    {
        alert("Please Provide Purpose of Visiting");
        return false;
    }
    

    return true;
}