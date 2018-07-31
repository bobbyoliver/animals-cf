<cfcookie name="#GridName#PerPage" value="#URL.PerPage#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
<cfcookie name="#GridName#Order" value="#URL.Order#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">
<cfcookie name="#GridName#Direction" value="#URL.Direction#" expires="#CreateTimeSpan(5, 0, 0, 0)#" httponly="true">