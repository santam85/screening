$.extend($.mobile.datebox.prototype.options, {
    "mode": "calbox",
    "theme":"c",
    "useNewStyle":true,
    "lockInput":false,
    "useFocus":false,
    "calUsePickers":true,
    "calNoHeader":true,
    "calPickersYearOffset":100,
    "themeDateToday":"b",
    "overrideDateFormat":"%d/%m/%Y"
});
    
$(document).on("pagecreate","#index",function(event,ui){
    $(this).find("ul.patient-list").listview({
        autodividers: true,
        autodividersSelector: function ( li ) {
            return li.find("p.folder-number > strong").text().substr(0, 1);
        }
    });
});

$(document).on("change",".screeningslider",function(event,ui){
    $(".cartellafieldcontain").toggle().find("input").val("");  
});
$(document).on("change",".othercslider",function(event,ui){
    $(".othercfieldcontain").toggle().find("textarea").val("");  
});

$(document).on("pagebeforechange",function(event,ui){
    if(typeof(ui.toPage) === "string" && ui.options.type == "post" && ui.options.data.indexOf("action=delete")>=0)
        if(!confirm("Confermi la cancellazione?")){
            event.preventDefault();
            return false;
        }
});
