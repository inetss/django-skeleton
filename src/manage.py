#!/usr/bin/env python3
import sys

if __name__ == "__main__":
	import project_env
	from django.core.management import execute_from_command_line
	execute_from_command_line(sys.argv)
