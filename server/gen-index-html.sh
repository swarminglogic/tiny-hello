#!/bin/sh

LINKS_BODY=""
LINKS=$(env | sed -n -r 's,^(.*)_PORT_([0-9]*)_(TCP|UDP)=(.*),<b>\1</b> listening in \2 available at \4<br/>,p')
if [ ! -z "$LINKS" ] ; then
	LINKS_BODY="<h3>Links found:</h3>${LINKS}"
fi

cat << EOF > /www/index.html
<html>
<head>
	<title>tiny-hello</title>
	<link href=//fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
	<style>
	body {
		background-color: white;
		text-align: center;
		padding: 100px;
		font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
	}
	</style>
</head>
<body>
	<h1><pre>tiny-hello</pre></h1>
	<p>Page last generated at: $(date)</p>
	<h3>My hostname is <b>$(hostname)</b></h3>	</body>
	${LINKS_BODY}
</html>
EOF
