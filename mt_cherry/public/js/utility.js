// Helper functions
function containsObject(obj, list) 
{
    var i;
    for (i = 0; i < list.length; i++) {
        if (list[i] === obj) {
            return true;
        }
    }

    return false;
}

// Encode (pre-process) the source text for CGI
function EncodeCGI(text)
{
    text = text.replace(/\?/g, '__QUESTION_MARK__');
    text = text.replace(/;/g, '__SEMICOLON__');
    text = text.replace(/&/g, '__AMPERSAND__');
    text = text.replace(/#/g, '__NUMBER__');
    text = text.replace(/\.\n/g, '. \n');
    //text = text.replace(/\n/g, '__NEWLINE__');
    //alert(text);

    return text;
}

function GetXmlHttpObject()
{
    var xmlHttp;

    try
    {
        // Firefox,Opera 8.0+ safari
        xmlHttp = new XMLHttpRequest();
    }
    catch (e)
    {
        // Internet Explorer
        try
        {
            xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        }
        catch(e)
        {
            try
            {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e)
            {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }

   return xmlHttp;
}

function trim(value) 
{
    return value.replace(/^\s+|\s+$/g,"");
} 


function ClearSelect(selectbox)
{
    var i;
    for(i = selectbox.options.length - 1 ; i >= 0 ; i--)
    {
        selectbox.remove(i);
    }
}

