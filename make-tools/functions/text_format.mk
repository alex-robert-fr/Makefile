#	$1 TEXT
#	$2 LENGTH
define column_length
	printf "%-$(2)b" $(1)
endef
