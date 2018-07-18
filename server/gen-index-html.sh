#!/bin/sh

LINKS_BODY=""
LINKS=$(env | sed -n -r 's,^(.*)_PORT_([0-9]*)_(TCP|UDP)=(.*),<b>\1</b> listening in \2 available at \4<br/>,p')
LINKS=$(env | sed -n -r 's,^(.*)_PORT_([0-9]*)_(TCP|UDP)=(.*),<tr><td>\1</td><td>\2</td><td>\3</td><td>\4</td></tr>,p')
if [ ! -z "$LINKS" ] ; then
	LINKS_BODY="<br/><h3>Links found:</h3><table><tr><th>Service</th><th>port</th><th>protocol</th><th>target</th></tr>${LINKS}</tabl>"
fi

cat << EOF > "$1"
<html>
<head>
	<title>tiny-hello</title>
	<link href=//fonts.googleapis.com/css?family=Inconsolata:400,700' rel='stylesheet' type='text/css'>
	<style>
	body {
		background-color: white;
		text-align: left;
		padding: 100px;
		font-family: "Inconsolata","Helvetica Neue",Helvetica,Arial,sans-serif;
	}
	th {
		text-align: left;
		padding-right: 10px;
	}
	td {
		padding-right: 15px;
	}
	</style>
</head>
<body>
	<h1><pre>tiny-hello</pre></h1>
	<p>Page last generated at: $(date)</p>
	<p><b>hostname:</b> $(hostname)</p>
	<p><b>uname:</b> $(uname -a)</p>

	${LINKS_BODY}
</body>
</html>
EOF
