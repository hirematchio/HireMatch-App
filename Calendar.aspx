<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="Calendar" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    

<link href='calendar/fullcalendar.css' rel='stylesheet' />
<link href='calendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='calendar/lib/moment.min.js'></script>
<script src='calendar/lib/jquery.min.js'></script>
<script src='calendar/fullcalendar.min.js'></script>
<script>

	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek,basicDay'
			},
			defaultDate: '<%=DateTime.Now.ToString("yyyy-MM-dd")%>',
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: <%=reservations%>,
		    
		    eventDrop: function(event, delta, revertFunc) {
		        if (event.end == null)
		        {
		            $.post( "updatereservationdate.aspx?id=" + String(event.id) + "&start=" + String(event.start.format()) + "&end=" +  String(event.start.format()));
		        }
		        else
                    {
		        $.post( "updatereservationdate.aspx?id=" + String(event.id) + "&start=" + String(event.start.format()) + "&end=" + String(event.end.format()));
}
		    } 

		});
		
	});

</script>
<style>



	#calendar {
		max-width: 1200px;
		margin: 0 auto;
	}

</style>


	<div id='calendar' class="border-around padding-30"></div>


</asp:Content>

