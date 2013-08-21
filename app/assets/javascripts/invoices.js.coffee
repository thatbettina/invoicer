$ ->
  $(document).on "click", ".change_date", ->
    classes = $(this).attr("class")
    field = classes.split(" ")[0]
    $("#" + field + "_1i").val $(this).data('year')
    $("#" + field + "_2i").val $(this).data('month')
    $("#" + field + "_3i").val $(this).data('day')

  $(document).on "change", "select.addnew", ->
    addnew = $(this).val()
    unless addnew is ""
      window.open addnew, "_self"
    else
      false
