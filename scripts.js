$(function () {
    $("#addpost").on("click", function () {

        $("#addPostDialog").removeClass("d-none");
        $("#title").focus();
        $(this).attr("disabled","disabled");
        return false;
    });
});
