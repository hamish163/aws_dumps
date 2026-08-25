all: dump

# TODO:
# - a full dump takes forever.  Add feature to vicloud to easily allow partial
#   dumps to be taken
#
.PHONY: dump
dump:
	git pull
	rm -rf aws
	vicloud --profile default --region ap-northeast-1 --mode files dump
	git add aws
	git commit -m "Make $@"
	git push

.PHONY: always

reports: report_security.txt
report_security.txt: always
	~/r/cli/vicloud/report_security.py aws >$@

reports: report_elb.dot
report_elb.dot: always
	~/r/cli/vicloud/report_elb.py aws >$@.tmp
	mv $@.tmp $@

report: report_ipaddrs.txt
report_ipaddrs.txt: always
	~/r/cli/vicloud/report_ipaddrs.py aws >$@
