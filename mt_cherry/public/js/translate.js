// Translate.js
// Javascript for sending a translation Request
// Global Variacbles
//var languageVariants = { "zh-cn": "zh" };

// Performance Metrics
var t0;
var t1;

$(document).ready(function()
{
	$("#sourceText").keypress(
        function ()
        {
            if ($(this).attr('data-direction') == 'ltr')
            {
                $(this).attr('data-direction', 'rtl');
			}
            else
            {
                $(this).attr('data-direction', 'ltr');
            }
        }
    );

	// Set Text to Right-to-Left
	SetTextDirection = function (lang_code, select_name, textbox)
	{
	    debugger;
        var dir;
        if (lang_code == "detect")
        {
            dir = "ltr";
        }
        else
        {
            //var select = document.getElementById(select_name);
            //var option = $("#" + select_name).find("option[value=" + lang_code.toUpperCase() + "]");
            dir = $("#" + select_name).find("option[value=" + lang_code.toUpperCase() + "]").attr("TextDirection");
            //dir = $("#" + select_name + " option[value='" + lang_code.toUpperCase() + "']").attr("TextDirection");
        }
	
        textbox.style.direction = dir;
	}

    LoadSourceLanguages = function()
	{
	    // Call-Back Function
        var xmlHttp = GetXmlHttpObject();
        xmlHttp.onreadystatechange = function()
        {
            if (xmlHttp.readyState == 4)
            {
                var languages = xmlHttp.responseText;

                if (languages == undefined)
                {
                    alert("Language List Error: Can't retrieve list of languages.");
                }
                else
                {
                    var sourceSelect = document.getElementById("sourceLanguage");
                    ClearSelect(sourceSelect);
                    sourceSelect.style.width = "230px";

                    var langsJson = $.parseJSON(languages);
                    if (Object.keys(langsJson).length > 1)
                    {
                        var optionLabel = document.createElement("option");
                        optionLabel.value = "detect";
                        optionLabel.text = "Auto Detect";
                        optionLabel.selected = true;
                        sourceSelect.appendChild(optionLabel);
                    }

                    $.each(langsJson, function(index, obj)
                    {
                        var option = document.createElement("option");
                        option.value = obj.Code.toUpperCase();
                        option.text = obj.Name;
                        option.setAttribute("TextDirection", obj.TextDirection)
                        //option.TextDirection = obj.TextDirection;
                        sourceSelect.appendChild(option);
                    });
                }
            }
        }

        var domain = window.location.href;
        var url = domain + "languages?source=all";
        xmlHttp.open("Get", url, true);
        xmlHttp.send(null);
	}

	SourceLanguageOnChange = function ()
	{
        document.myForm.targetText.value = "";

        var srcLang = document.myForm.sourceLanguage.value;
        var sourceText = document.myForm.sourceText;

        debugger;
        SetTextDirection(srcLang, "sourceLanguage", sourceText);

        if (srcLang == "detect")
        {
            var targetSelect = document.getElementById("targetLanguage");
            ClearSelect(targetSelect);
            targetSelect.style.width = "100px"
            document.myForm.DetectButton.style.display = "inline-block" ;
        }
        else
        {
            sourceText.value = "";
            document.myForm.DetectButton.style.display = "none" ;
            UpdateTargetLanguages();
        }
	}

	TargetLanguageOnChange = function ()
	{
	    debugger;
		var targetText = document.getElementById("targetText");
		targetText.value = "";

		var targetSelect = document.getElementById("targetLanguage").value;
		SetTextDirection(targetSelect, "targetLanguage", targetText);
	}

	UpdateTargetLanguages = function()
	{
        // Call-Back Function
        var xmlHttp = GetXmlHttpObject();
        xmlHttp.onreadystatechange = function()
        {
            if (xmlHttp.readyState == 4)
            {
                var languages = xmlHttp.responseText;

                if (languages == undefined)
                {
                    alert("Language List Error: Can't retrieve list of target languages.");
                }
                else
                {
                    var targetSelect = document.getElementById("targetLanguage");
                    ClearSelect(targetSelect);
                    targetSelect.style.width = "230px";

                    var langsJson = $.parseJSON(languages);
                    if (Object.keys(langsJson).length > 1)
                    {
                        var optionLabel = document.createElement("option");
                        optionLabel.text = "Choose a Language";
                        optionLabel.selected = true;
                        optionLabel.disabled = true;
                        optionLabel.hidden = true;
                        targetSelect.appendChild(optionLabel);
                    }

                    $.each(langsJson, function(index, obj)
                    {
                        var option = document.createElement("option");
                        option.value = obj.Code.toUpperCase();
                        option.text = obj.Name;
                        //option.TextDirection = obj.TextDirection;
                        option.setAttribute("TextDirection", obj.TextDirection)
                        targetSelect.appendChild(option);
                    });
                }
            }
        }

        var srcLang = document.getElementById("sourceLanguage").value;
        var domain = window.location.href;
        var url = domain + "languages?source=" + srcLang;
        document.myForm.targetText.value = "";

        xmlHttp.open("Get", url, true);
        xmlHttp.send(null);
	}

	Detect = function(translate)
	{
	    var srcText = document.getElementById("sourceText").value;
		
	    if (trim(srcText) != "")
	    {
	        // Call-Back Function
	        var xmlHttpDetect = GetXmlHttpObject();
	        xmlHttpDetect.onreadystatechange = function()
	        {
	            if (xmlHttpDetect.readyState == 4)
	            {
				    // Detect Source Language
					var detectedLang = trim(xmlHttpDetect.responseText);

					if (detectedLang == undefined)
					{
						alert("Detection Error.")
					}
					else
					{
						var sourceLanguageSelect = document.getElementById("sourceLanguage");
						sourceLanguageSelect.value = detectedLang.toUpperCase();
						UpdateTargetLanguages();

                        debugger;
						var srcTextBox = document.getElementById("sourceText");
						SetTextDirection(detectedLang, "sourceLanguage", srcTextBox)

						// Check if it's a detect, THEN translate what was requested
						if (translate)
						{
							TranslationCallback();
						}
					}
				}
			}

            srcText = EncodeCGI(srcText);
            var domain = window.location.href;
            var url = domain + "detect?input=" + srcText;

            xmlHttpDetect.open("Get", url, true);
            xmlHttpDetect.send(null);
		}
	}

	Translate = function ()
	{
		// Clear out the target translation
		document.myForm.targetText.value = "";
		var srcText = document.myForm.sourceText.value;

		if (trim(srcText) == "")
		{
		    document.myForm.targetText.value = "";
		}
		else
		{
		    var srcLang = document.myForm.sourceLanguage.value;
		    var tgtLang = document.myForm.targetLanguage.value;

		    // Check if language should be detected
		    if (srcLang == "detect") 
		    {
		        Detect(srcText, true);
		    }
		    else 
		    {
				TranslationCallback();
		    }
		}
	}

	TranslationCallback = function()
	{
		var tgtLang = document.myForm.targetLanguage.value;
		if (tgtLang != "")
		{
		    debugger
		    var targetText = document.getElementById("targetText")
            SetTextDirection(tgtLang, "targetLanguage", targetText);

		    // Call-Back Function
		    var xmlHttp = GetXmlHttpObject();
		    xmlHttp.onreadystatechange = function()
		    {
		        if (xmlHttp.readyState == 4)
		        {
		            debugger;
		            document.myForm.targetText.value = xmlHttp.responseText;
		            t1 = performance.now();
		            var timeElapsed = (t1 - t0).toFixed(2);
		            var x = timeElapsed / 1000;
		            var seconds = (x % 60).toFixed(4);
		            var performText = "<br/><br/>" +
		                              "<b>Source:</b> "       + srcText + "<br/>" + 
		                              "<b>Target:</b> "       + xmlHttp.responseText + "<br/>" + 
		                              "<b>Elapsed Time:</b> " + timeElapsed + " ms " +  
		                              "(" + seconds + " seconds)";                
		            performance.innerHTML = performance.innerHTML + performText;
		            document.getElementById("performance").innerHTML = document.getElementById("performance").innerHTML + performText;
		        }
		    }

            debugger;
            var srcText = document.myForm.sourceText.value;
			var srcLang = document.myForm.sourceLanguage.value;
		    var queryString = "?source=" + srcLang + "&target=" + tgtLang + "&input=" + srcText;
			var domain = window.location.href;
		    var url = domain + "translate" + queryString;

		    xmlHttp.open("Get", url, true);
		    t0 = performance.now();  
		    xmlHttp.send(null);
		}
	}

    LoadSourceLanguages();
});



