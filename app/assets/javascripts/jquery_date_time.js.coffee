$ -> 
    picker_selects = (name) ->
        $("##{name}_#{i}i") for i in [1..5]

    pad_two = (num) ->
        pad = if num < 10 then "0" else ""
        "#{pad}#{num}"
    
    fix_picker = (name) ->
        elems = picker_selects(name)
        #elem.hide() for elem in elems

        id = "#{name}_input"
        elem = """<input type="text" name="#{id}" id="#{id}" value="" />"""

        new_input = $(elem)
        new_input.attr( "id", "#{name}_input" )
        elems[0].parent().append new_input

        on_select = (txt, picker) ->
            td = new_input.datetimepicker("getDate")
            console.log "selected time for #{name}: #{txt} #{td}"

            $("##{name}_1i").val( "" + td.getFullYear()     )
            $("##{name}_2i").val( "" + (td.getMonth() + 1)  )
            $("##{name}_3i").val( "" + td.getDate()         )
            $("##{name}_4i").val( pad_two(td.getHours()  )  )
            $("##{name}_5i").val( pad_two(td.getMinutes())  )

        [yr, mo, da, ho, mi] = [
            0 + $("##{name}_1i").val(),
            0 + $("##{name}_2i").val() - 1,
            0 + $("##{name}_3i").val(),
            0 + $("##{name}_4i").val(),
            0 + $("##{name}_5i").val(),
        ]
        date = new Date( yr, mo, da, ho, mi )
        $(new_input).datetimepicker( timeFormat: 'hh:mm tt', ampm: true, stepMinute: 5, onSelect: on_select )
        $(new_input).datetimepicker( "setDate", date )

    fix_picker("work_start")
    fix_picker("work_finish")
