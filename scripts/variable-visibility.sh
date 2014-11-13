#!/bin/bash
# Demonstrate the variable visibility within different shells

foo="bar"
echo within first shell \(pid $BASHPID\): \$foo\=$foo
bash -c 'echo within second shell \(pid $BASHPID\): \$foo\=$foo'
