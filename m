From: kernel test robot <rong.a.chen@intel.com>
Subject: [LKP] [lib/test_bitmap.c]  467e3fea0c:
 kernel_selftests.lib.bitmap.sh.fail
Date: Wed, 2 Jan 2019 16:45:06 +0800
Message-ID: <20190102084505.GH17624@shao2-debian>
References: <53bc13df75e9a26ef9fc7ba764c3536b4fc51433.1545198260.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GBDnBH7+ZvLx8QD4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53bc13df75e9a26ef9fc7ba764c3536b4fc51433.1545198260.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, William Breathitt Gray <vilhelm.gray@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkp@01.org
List-Id: linux-arch.vger.kernel.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, we noticed the following commit (built with gcc-7):

commit: 467e3fea0c6a920471f816b755166d1b907db91c ("[PATCH v6 2/8] lib/test_=
bitmap.c: Add for_each_set_clump8 test cases")
url: https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introd=
uce-the-for_each_set_clump8-macro/20181221-201922
base: https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git fo=
r-next

in testcase: kernel_selftests
with following parameters:

	group: kselftests-01

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-467e3fea0c6a920471f816b755166d1b907db91c
2018-12-30 22:36:56 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-12-30 22:36:56 ln -sf /usr/bin/llc-7 /usr/bin/llc

2018-12-30 22:36:56 chown lkp capabilities -R
2018-12-30 22:36:56 su lkp -c make run_tests -C capabilities 2>&1
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/capabilities'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/=
tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c=
/tools/testing/selftests/capabilities/validate_cap
TAP version 13
selftests: capabilities: test_execve
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# [RUN]	+++ Tests with uid =3D=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Root =3D> ep
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Root +i =3D> eip
ok 6 Passed
# [RUN]	UID 0 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# [RUN]	+++ Tests with uid !=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Non-root =3D> no caps
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Non-root +i =3D> i
ok 6 Passed
# [RUN]	UID 1 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ok 1..1 selftests: capabilities: test_execve [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/capabilities'
ignored_by_lkp cgroup test

2018-12-30 22:36:56 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/cpu-hotplug'
TAP version 13
selftests: cpu-hotplug: cpu-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1180's current affinity mask: 3
pid 1180's new affinity mask: 1
CPU online/offline summary:
	 Cpus in online state: 0-1
	 Cpus in offline state: 0
Limited scope test: one hotplug cpu
	 (leaves cpu in the original state):
	 online to offline to online: cpu 1
ok 1..1 selftests: cpu-hotplug: cpu-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/cpu-hotplug'

2018-12-30 22:36:56 make run_tests -C cpufreq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/cpufreq'
TAP version 13
selftests: cpufreq: main.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1244's current affinity mask: 3
pid 1244's new affinity mask: 1
not ok 1..1 selftests: cpufreq: main.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/cpufreq'
ignored_by_lkp efivarfs test: /sys/firmware/efi dir does not exist

2018-12-30 22:36:56 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec'
gcc -Wall    execveat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/execveat
cd /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b=
907db91c/tools/testing/selftests/exec && ln -s -f execveat execveat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b=
907db91c/tools/testing/selftests/exec/execveat /usr/src/perf_selftests-x86_=
64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftest=
s/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9204=
71f816b755166d1b907db91c/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a92047=
1f816b755166d1b907db91c/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/subdir
TAP version 13
selftests: exec: execveat
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/bin/sh: 0: Can't open /dev/fd/7/usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
Check success of execveat(4, '../execveat', 0)... [OK]
Check success of execveat(6, 'execveat', 0)... [OK]
Check success of execveat(8, 'execveat', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execveat'=
, 0)... [OK]
Check success of execveat(10, '', 4096)... [OK]
Check success of execveat(19, '', 4096)... [OK]
Check success of execveat(11, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(17, '', 4096)... [OK]
Check failure of execveat(10, '', 0) with ENOENT... [OK]
Check failure of execveat(10, '(null)', 4096) with EFAULT... [OK]
Check success of execveat(6, 'execveat.symlink', 0)... [OK]
Check success of execveat(8, 'execveat.symlink', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.symlin=
k', 0)... [OK]
Check success of execveat(12, '', 4096)... [OK]
Check success of execveat(12, '', 4352)... [OK]
Check failure of execveat(6, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(8, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.2-46=
7e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/execvea=
t.symlink', 256) with ELOOP... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check success of execveat(6, 'script', 0)... [OK]
Check success of execveat(8, 'script', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scrip=
t', 0)... [OK]
Check success of execveat(15, '', 4096)... [OK]
Check success of execveat(15, '', 4352)... [OK]
Check failure of execveat(20, '', 4096) with ENOENT... [OK]
Check failure of execveat(9, 'script', 0) with ENOENT... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check success of execveat(5, 'script', 0)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check failure of execveat(5, 'script', 0) with ENOENT... [OK]
Check failure of execveat(6, 'execveat', 65535) with EINVAL... [OK]
Check failure of execveat(6, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(8, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(6, '', 4096) with EACCES... [OK]
Check failure of execveat(6, 'Makefile', 0) with EACCES... [OK]
Check failure of execveat(13, '', 4096) with EACCES... [OK]
Check failure of execveat(14, '', 4096) with EACCES... [OK]
Check failure of execveat(99, '', 4096) with EBADF... [OK]
Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
Check failure of execveat(10, 'execveat', 0) with ENOTDIR... [OK]
Invoke copy of 'execveat' via filename of length 4094:
Check success of execveat(21, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
Invoke copy of 'script' via filename of length 4094:
Check success of execveat(22, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
ok 1..1 selftests: exec: execveat [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/exec'
ignored_by_lkp filesystems test
2018-12-30 22:36:57 mv /lib/udev/rules.d/50-firmware.rules .
2018-12-30 22:36:57 /etc/init.d/udev restart
Restarting udev (via systemctl): udev.service.

2018-12-30 22:36:57 make run_tests -C firmware
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/firmware'
TAP version 13
selftests: firmware: fw_run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----------------------------------------------------
Running kernel configuration test 1 -- rare
Emulates:
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_USER_HELPER=3Dn
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dn
=2E/fw_filesystem.sh: filesystem loading works
=2E/fw_filesystem.sh: async filesystem loading works

Testing with the file present...
Batched request_firmware() try #1: OK
Batched request_firmware() try #2: OK
Batched request_firmware() try #3: OK
Batched request_firmware() try #4: OK
Batched request_firmware() try #5: OK
Batched request_firmware_direct() try #1: OK
Batched request_firmware_direct() try #2: OK
Batched request_firmware_direct() try #3: OK
Batched request_firmware_direct() try #4: OK
Batched request_firmware_direct() try #5: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #1: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #2: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #3: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #4: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #5: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #1: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #2: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #3: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #4: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #5: OK

Testing with the file missing...
Batched request_firmware() nofile try #1: OK
Batched request_firmware() nofile try #2: OK
Batched request_firmware() nofile try #3: OK
Batched request_firmware() nofile try #4: OK
Batched request_firmware() nofile try #5: OK
Batched request_firmware_direct() nofile try #1: OK
Batched request_firmware_direct() nofile try #2: OK
Batched request_firmware_direct() nofile try #3: OK
Batched request_firmware_direct() nofile try #4: OK
Batched request_firmware_direct() nofile try #5: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #1: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #2: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #3: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #4: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #5: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #1: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #2: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #3: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #4: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #5: OK
usermode helper disabled so ignoring test
not ok 1..1 selftests: firmware: fw_run_tests.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/firmware'
2018-12-30 22:37:38 mv 50-firmware.rules /lib/udev/rules.d/50-firmware.rules

2018-12-30 22:37:38 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ftrace'
TAP version 13
selftests: ftrace: ftracetest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/ftracetest: 163: [: Illegal number:=20
-e =3D=3D=3D Ftrace unit tests =3D=3D=3D
-e -n [1] Basic trace file check
-e 	[PASS]
-e -n [2] Basic test for tracers
-e 	[PASS]
-e -n [3] Basic trace clock test
-e 	[PASS]
-e -n [4] Basic event tracing check
-e 	[PASS]
-e -n [5] Change the ringbuffer size
-e 	[PASS]
-e -n [6] Snapshot and tracing setting
-e 	[PASS]
-e -n [7] trace_pipe and trace_marker
-e 	[PASS]
-e -n [8] event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [9] event tracing - restricts events based on pid
-e 	[PASS]
-e -n [10] event tracing - enable/disable with subsystem level files
-e 	[PASS]
-e -n [11] event tracing - enable/disable with top level files
-e 	[PASS]
-e -n [12] Test trace_printk from module
-e 	[UNRESOLVED]
-e -n [13] ftrace - function graph filters with stack tracer
-e 	[PASS]
-e -n [14] ftrace - function graph filters
-e 	[PASS]
-e -n [15] ftrace - function glob filters
-e 	[PASS]
-e -n [16] ftrace - function pid filters
-e 	[PASS]
-e -n [17] ftrace - stacktrace filter command
-e 	[PASS]
-e -n [18] ftrace - function trace with cpumask
-e 	[PASS]
-e -n [19] ftrace - test for function event triggers
-e 	[PASS]
-e -n [20] ftrace - function trace on module
-e 	[UNRESOLVED]
-e -n [21] ftrace - function profiling
-e 	[PASS]
-e -n [22] ftrace - function profiler with function tracing
-e 	[PASS]
-e -n [23] ftrace - test reading of set_ftrace_filter
-e 	[PASS]
-e -n [24] ftrace - Max stack tracer
-e 	[PASS]
-e -n [25] ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [26] Test creation and deletion of trace instances while setting an e=
vent
-e 	[PASS]
-e -n [27] Test creation and deletion of trace instances
-e 	[PASS]
-e -n [28] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [29] Kprobe dynamic event - busy event check
-e 	[PASS]
-e -n [30] Kprobe dynamic event with arguments
-e 	[PASS]
-e -n [31] Kprobe event with comm arguments
-e 	[PASS]
-e -n [32] Kprobe event string type argument
-e 	[PASS]
-e -n [33] Kprobe event symbol argument
-e 	[PASS]
-e -n [34] Kprobe event argument syntax
-e 	[PASS]
-e -n [35] Kprobes event arguments with types
-e 	[PASS]
-e -n [36] Kprobe event auto/manual naming
-e 	[PASS]
-e -n [37] Kprobe dynamic event with function tracer
-e 	[PASS]
-e -n [38] Kprobe dynamic event - probing module
-e 	[UNRESOLVED]
-e -n [39] Kretprobe dynamic event with arguments
-e 	[PASS]
-e -n [40] Kretprobe dynamic event with maxactive
-e 	[PASS]
-e -n [41] Register/unregister many kprobe events
-e 	[PASS]
-e -n [42] Kprobe events - probe points
-e 	[PASS]
-e -n [43] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [44] test for the preemptirqsoff tracer
-e 	[UNSUPPORTED]
-e -n [45] Test wakeup tracer
-e 	[PASS]
-e -n [46] Test wakeup RT tracer
-e 	[PASS]
-e -n [47] event trigger - test extended error support
-e 	[PASS]
-e -n [48] event trigger - test field variable support
-e 	[PASS]
-e -n [49] event trigger - test inter-event combined histogram trigger
-e 	[PASS]
-e -n [50] event trigger - test multiple actions on hist trigger
-e 	[PASS]
-e -n [51] event trigger - test inter-event histogram trigger onmatch action
-e 	[PASS]
-e -n [52] event trigger - test inter-event histogram trigger onmatch-onmax=
 action
-e 	[PASS]
-e -n [53] event trigger - test inter-event histogram trigger onmax action
-e 	[PASS]
-e -n [54] event trigger - test synthetic event create remove
-e 	[PASS]
-e -n [55] event trigger - test synthetic_events syntax parser
-e 	[PASS]
-e -n [56] event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [57] event trigger - test trigger filter
-e 	[PASS]
-e -n [58] event trigger - test histogram modifiers
-e 	[PASS]
-e -n [59] event trigger - test histogram trigger
-e 	[PASS]
-e -n [60] event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [61] event trigger - test snapshot-trigger
-e 	[PASS]
-e -n [62] event trigger - test stacktrace-trigger
-e 	[PASS]
-e -n [63] trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [64] trace_marker trigger - test snapshot trigger
-e 	[PASS]
-e -n [65] trace_marker trigger - test histogram with synthetic event again=
st kernel event
-e 	[PASS]
-e -n [66] trace_marker trigger - test histogram with synthetic event
-e 	[PASS]
-e -n [67] event trigger - test traceon/off trigger
-e 	[PASS]
-e -n [68] (instance)  Basic test for tracers
-e 	[PASS]
-e -n [69] (instance)  Basic trace clock test
-e 	[PASS]
-e -n [70] (instance)  Change the ringbuffer size
-e 	[PASS]
-e -n [71] (instance)  Snapshot and tracing setting
-e 	[PASS]
-e -n [72] (instance)  trace_pipe and trace_marker
-e 	[PASS]
-e -n [73] (instance)  event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [74] (instance)  event tracing - restricts events based on pid
-e 	[PASS]
-e -n [75] (instance)  event tracing - enable/disable with subsystem level =
files
-e 	[PASS]
-e -n [76] (instance)  ftrace - stacktrace filter command
-e 	[PASS]
-e -n [77] (instance)  ftrace - test for function event triggers
-e 	[PASS]
-e -n [78] (instance)  ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [79] (instance)  event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [80] (instance)  event trigger - test trigger filter
-e 	[PASS]
-e -n [81] (instance)  event trigger - test histogram modifiers
-e 	[PASS]
-e -n [82] (instance)  event trigger - test histogram trigger
-e 	[PASS]
-e -n [83] (instance)  event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [84] (instance)  trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [85] (instance)  trace_marker trigger - test snapshot trigger
-e 	[PASS]


-e=20
-e # of passed:  81
-e # of failed:  0
-e # of unresolved:  3
-e # of untested:  0
-e # of unsupported:  1
-e # of xfailed:  0
-e # of undefined(test bug):  0
not ok 1..1 selftests: ftrace: ftracetest [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ftrace'

2018-12-30 22:39:59 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functional'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_timeout.c ../include/futextest.h ../include/atomic.h ../inc=
lude/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9204=
71f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_wai=
t_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_wouldblock.c ../include/futextest.h ../include/atomic.h ../=
include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9=
20471f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_=
wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471=
f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_reque=
ue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_signal_restart.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_mismatched_ops.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_uninitialized_heap.c ../include/futextest.h ../include/atom=
ic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3=
fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functiona=
l/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_private_mapped_file.c ../include/futextest.h ../include/ato=
mic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e=
3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/function=
al/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functional'
TAP version 13
selftests: futex: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified

# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
ok 1 futex-requeue-pi-mismatched-ops
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# 	Arguments: <none>
ok 1 futex-requeue-pi-signal-restart
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_timeout: Block on a futex and wait for timeout
# 	Arguments: timeout=3D100000ns
ok 1 futex-wait-timeout
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
ok 1 futex-wait-wouldblock
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_uninitialized_heap: Test the uninitialized futex value in FUTE=
X_WAIT
ok 1 futex-wait-uninitialized-heap
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_wait_private_mapped_file: Test the futex value of private file mapp=
ings in FUTEX_WAIT
ok 1 futex-wait-private-mapped-file
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
ok 1..1 selftests: futex: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/futex'

2018-12-30 22:40:14 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/gpio'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c'
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (501 files)
  INSTALL usr/include/linux/android/ (1 file)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c'
make OUTPUT=3D/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f81=
6b755166d1b907db91c/tools/gpio/ -C /usr/src/perf_selftests-x86_64-rhel-7.2-=
467e3fea0c6a920471f816b755166d1b907db91c/tools/gpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/gpio/include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/gpio/../../include/uapi/linux/gpio.h /usr/src/perf_selft=
ests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/gpio/in=
clude/linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-utils.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dgpio-hammer
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dgpio-event-mon
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/    gpio-mockup-cha=
rdev.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/gpio/gpio-utils.o  -lmount -I/usr/include/libmount -o gp=
io-mockup-chardev
TAP version 13
selftests: gpio: gpio-mockup.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.  Test dynamic allocation of gpio successful means insert gpiochip and
    manipulate gpio pin successful
GPIO gpio-mockup test with ranges: <-1,32>:=20
-1,32     =20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32>=
:=20
-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32,=
-1,32>:=20
-1,32,-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: 3.  Error test: successful means insert gpiochip=
 failed
3.1 Test number of gpio overflow
GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
-1,32,-1,1024=20
Test gpiochip gpio-mockup: Invalid test successful
GPIO test PASS
ok 1..1 selftests: gpio: gpio-mockup.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2018-12-30 22:40:42 make TARGETS=3Dia64
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'

2018-12-30 22:40:43 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ia64: aliasing-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: /dev/mem 0x0-0xa0000 is readable
PASS: /dev/mem 0xa0000-0xc0000 is mappable
PASS: /dev/mem 0xc0000-0x100000 is readable
PASS: /dev/mem 0x0-0x100000 is mappable
PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 39422 bytes
PASS: /sys/devices/pci0000:00/0000:00:03.0/rom read 231422 bytes
PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.1 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.3 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/03.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/04.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/05.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/06.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/07.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/09.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0x100000 not mappable
ok 1..1 selftests: ia64: aliasing-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'

2018-12-30 22:40:45 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/intel_pstate'
gcc  -Wall -D_GNU_SOURCE    msr.c  -lm -o /usr/src/perf_selftests-x86_64-rh=
el-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/int=
el_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c  -lm -o /usr/src/perf_selftests-x86_64-=
rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/i=
ntel_pstate/aperf
TAP version 13
selftests: intel_pstate: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The marketing frequency of the cpu is 0 MHz
The maximum frequency of the cpu is  MHz
The minimum frequency of the cpu is  MHz
Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1..1 selftests: intel_pstate: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/intel_pstate'

2018-12-30 22:40:46 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/ipc/msgque
msgque.c: In function =E2=80=98restore_queue=E2=80=99:
msgque.c:52:7: warning: implicit declaration of function =E2=80=98msgget=E2=
=80=99 [-Wimplicit-function-declaration]
  id =3D msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
       ^~~~~~
msgque.c:66:7: warning: implicit declaration of function =E2=80=98msgsnd=E2=
=80=99 [-Wimplicit-function-declaration]
   if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
       ^~~~~~
msgque.c:76:6: warning: implicit declaration of function =E2=80=98msgctl=E2=
=80=99 [-Wimplicit-function-declaration]
  if (msgctl(id, IPC_RMID, 0))
      ^~~~~~
msgque.c: In function =E2=80=98check_and_destroy_queue=E2=80=99:
msgque.c:87:9: warning: implicit declaration of function =E2=80=98msgrcv=E2=
=80=99 [-Wimplicit-function-declaration]
   ret =3D msgrcv(msgque->msq_id, &message.mtype, MAX_MSG_SIZE,
         ^~~~~~
msgque.c: In function =E2=80=98main=E2=80=99:
msgque.c:203:15: warning: implicit declaration of function =E2=80=98ftok=E2=
=80=99 [-Wimplicit-function-declaration]
  msgque.key =3D ftok(argv[0], 822155650);
               ^~~~
TAP version 13
selftests: ipc: msgque
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: ipc: msgque [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ipc'

2018-12-30 22:40:46 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selft=
ests/kcmp/kcmp_test
TAP version 13
selftests: kcmp: kcmp_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid1:  14051 pid2:  14052 FD:  1 FILES:  2 VM:  2 FS:  1 SIGHAND:  1 IO:  0=
 SYSVSEM:  0 INV: -1
PASS: 0 returned as expected
PASS: 0 returned as expected
PASS: 0 returned as expected
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: kcmp: kcmp_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kcmp'
kmod test: not in Makefile
2018-12-30 22:40:46 make TARGETS=3Dkmod
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'

2018-12-30 22:40:46 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'
TAP version 13
selftests: kmod: kmod.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #0
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #1
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #2
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0002 - run #0
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0002 - run #1
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0002 - run #2
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0003 - run #0
kmod_test_0003: OK! - loading kmod test
kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0004 - run #0
kmod_test_0004: OK! - loading kmod test
kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0005 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0005 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:50 UTC 2018
Running test: kmod_test_0005 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:50 UTC 2018
Running test: kmod_test_0005 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #5
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #6
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #7
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #8
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #9
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:53 UTC 2018
Running test: kmod_test_0006 - run #0
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:54 UTC 2018
Running test: kmod_test_0006 - run #1
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:54 UTC 2018
Running test: kmod_test_0006 - run #2
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:55 UTC 2018
Running test: kmod_test_0006 - run #3
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:55 UTC 2018
Running test: kmod_test_0006 - run #4
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:56 UTC 2018
Running test: kmod_test_0006 - run #5
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:56 UTC 2018
Running test: kmod_test_0006 - run #6
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:57 UTC 2018
Running test: kmod_test_0006 - run #7
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:58 UTC 2018
Running test: kmod_test_0006 - run #8
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:59 UTC 2018
Running test: kmod_test_0006 - run #9
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:00 UTC 2018
Running test: kmod_test_0007 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:01 UTC 2018
Running test: kmod_test_0007 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:02 UTC 2018
Running test: kmod_test_0007 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:03 UTC 2018
Running test: kmod_test_0007 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:04 UTC 2018
Running test: kmod_test_0007 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
Test completed
ok 1..1 selftests: kmod: kmod.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'

2018-12-30 22:41:05 make run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm'
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/assert.c -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/=
testing/selftests/kvm/lib/assert.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/elf.c -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/tes=
ting/selftests/kvm/lib/elf.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/io.c -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/test=
ing/selftests/kvm/lib/io.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/kvm_util.c -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tool=
s/testing/selftests/kvm/lib/kvm_util.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/ucall.c -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/t=
esting/selftests/kvm/lib/ucall.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/sparsebit.c -o /usr/src/=
perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/too=
ls/testing/selftests/kvm/lib/sparsebit.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/processor.=
c -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/lib/x86_64/processor.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/vmx.c -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907d=
b91c/tools/testing/selftests/kvm/lib/x86_64/vmx.o
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c'
ar crs /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/testing/selftests/kvm/libkvm.a /usr/src/perf_selftests-x=
86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selft=
ests/kvm/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9=
20471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/elf.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/too=
ls/testing/selftests/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-7.2-4=
67e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/kvm=
_util.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/testing/selftests/kvm/lib/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/s=
elftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/testing/selftests/kvm/lib/x86_64/vmx.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/platform_inf=
o_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selft=
ests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing=
/selftests/kvm/x86_64/platform_info_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/set_sregs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/sel=
ftests/kvm/x86_64/set_sregs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/sync_regs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/sel=
ftests/kvm/x86_64/sync_regs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/vmx_tsc_adju=
st_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75=
5166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testin=
g/selftests/kvm/x86_64/vmx_tsc_adjust_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/cr4_cpuid_sy=
nc_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75=
5166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testin=
g/selftests/kvm/x86_64/cr4_cpuid_sync_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/state_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftes=
ts/kvm/x86_64/state_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/evmcs_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftes=
ts/kvm/x86_64/evmcs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  dirty_log_test.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/t=
ools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/d=
irty_log_test
TAP version 13
selftests: kvm: platform_info_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..1 selftests: kvm: platform_info_test [SKIP]
selftests: kvm: set_sregs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..2 selftests: kvm: set_sregs_test [SKIP]
selftests: kvm: sync_regs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..3 selftests: kvm: sync_regs_test [SKIP]
selftests: kvm: vmx_tsc_adjust_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..4 selftests: kvm: vmx_tsc_adjust_test [SKIP]
selftests: kvm: cr4_cpuid_sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..5 selftests: kvm: cr4_cpuid_sync_test [SKIP]
selftests: kvm: state_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..6 selftests: kvm: state_test [SKIP]
selftests: kvm: evmcs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..7 selftests: kvm: evmcs_test [SKIP]
selftests: kvm: dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
guest test mem offset: 0x40000000
not ok 1..8 selftests: kvm: dirty_log_test [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm'

2018-12-30 22:41:13 make run_tests -C lib
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/lib'
TAP version 13
selftests: lib: printf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
printf: ok
ok 1..1 selftests: lib: printf.sh [PASS]
selftests: lib: bitmap.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bitmap: [FAIL]
not ok 1..2 selftests: lib: bitmap.sh [FAIL]
selftests: lib: prime_numbers.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
prime_numbers: ok
ok 1..3 selftests: lib: prime_numbers.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/lib'
locking test: not in Makefile
2018-12-30 22:41:13 make TARGETS=3Dlocking
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'

2018-12-30 22:41:14 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'
TAP version 13
selftests: locking: ww_mutex.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
locking/ww_mutex: ok
ok 1..1 selftests: locking: ww_mutex.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in th=
is email



Thanks,
Rong Chen

--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.20.0-rc4-00101-g467e3fe"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.20.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20181229-164014/allot/cyclic:vm:linux-devel:devel-hourly/vm-snb-4G/kernel_selftests.yaml'
	export queue='validate'
	export testbox='vm-snb-4G-438'
	export tbox_group='vm-snb-4G'
	export submit_id='5c28d7cd0b9a9352f449fbb2'
	export job_file='/lkp/jobs/scheduled/vm-snb-4G-438/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-467e3fea0c6a920471f816b755166d1b907db91c-20181230-21236-12qp2n6-3.yaml'
	export id='bab3ec3c6fafc700833fbbf01cbfe20d096c4c4b'
	export queuer_version='/lkp/lkp/.src-20181229-164014'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_KVM_GUEST=y'
	export commit='467e3fea0c6a920471f816b755166d1b907db91c'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2018-12-30 22:35:58 +0800'
	export _id='5c28d7ce0b9a9352f449fbb3'
	export _rt='/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c'
	export user='lkp'
	export head_commit='6e53e7eb1afee8ad6467869c1fa6bc34056a17a5'
	export base_commit='8fe28cb58bcb235034b64cbbb7550a8a43fd88be'
	export branch='linux-devel/devel-hourly-2018122918'
	export result_root='/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/3'
	export scheduler_version='/lkp/lkp/.src-20181229-164014'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-4G-438/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-467e3fea0c6a920471f816b755166d1b907db91c-20181230-21236-12qp2n6-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2018122918
commit=467e3fea0c6a920471f816b755166d1b907db91c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/vmlinuz-4.20.0-rc4-00101-g467e3fe
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-01/vm-snb-4G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2018-12-12.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-f5d582777bcb_2018-12-12.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/467e3fea0c6a920471f816b755166d1b907db91c/vmlinuz-4.20.0-rc4-00101-g467e3fe'
	export dequeue_time='2018-12-30 22:36:15 +0800'
	export nr_vm=80
	export job_initrd='/lkp/jobs/scheduled/vm-snb-4G-438/kernel_selftests-kselftests-01-debian-x86_64-2018-04-03.cgz-467e3fea0c6a920471f816b755166d1b907db91c-20181230-21236-12qp2n6-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-01' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--GBDnBH7+ZvLx8QD4
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel_selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E2-467e3fea0c6a920471f816b755166d1b907db91c
2018-12-30 22:36:56 ln -sf /usr/bin/clang-7 /usr/bin/clang
2018-12-30 22:36:56 ln -sf /usr/bin/llc-7 /usr/bin/llc

2018-12-30 22:36:56 chown lkp capabilities -R
2018-12-30 22:36:56 su lkp -c make run_tests -C capabilities 2>&1
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/capabilities'
gcc -O2 -g -std=3Dgnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o /usr/s=
rc/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/=
tools/testing/selftests/capabilities/test_execve
gcc -O2 -g -std=3Dgnu99 -Wall    validate_cap.c -lcap-ng -lrt -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c=
/tools/testing/selftests/capabilities/validate_cap
TAP version 13
selftests: capabilities: test_execve
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# [RUN]	+++ Tests with uid =3D=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Root =3D> ep
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Root +i =3D> eip
ok 6 Passed
# [RUN]	UID 0 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# validate_cap:: Capabilities after execve were correct
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# [RUN]	+++ Tests with uid !=3D 0 +++
# [NOTE]	Using a user namespace for tests
# [RUN]	Non-root =3D> no caps
ok 1 Passed
# Check cap_ambient manipulation rules
ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
ok 4 PR_CAP_AMBIENT_RAISE worked
ok 5 Basic manipulation appears to work
# [RUN]	Non-root +i =3D> i
ok 6 Passed
# [RUN]	UID 1 +ia =3D> eipa
ok 7 Passed
ok 8 # skip SUID/SGID tests (needs privilege)
Pass 7 Fail 0 Xfail 0 Xpass 0 Skip 1 Error 0
1..8
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ok 1..1 selftests: capabilities: test_execve [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/capabilities'
ignored_by_lkp cgroup test

2018-12-30 22:36:56 make run_tests -C cpu-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/cpu-hotplug'
TAP version 13
selftests: cpu-hotplug: cpu-on-off-test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1180's current affinity mask: 3
pid 1180's new affinity mask: 1
CPU online/offline summary:
	 Cpus in online state: 0-1
	 Cpus in offline state: 0
Limited scope test: one hotplug cpu
	 (leaves cpu in the original state):
	 online to offline to online: cpu 1
ok 1..1 selftests: cpu-hotplug: cpu-on-off-test.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/cpu-hotplug'

2018-12-30 22:36:56 make run_tests -C cpufreq
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/cpufreq'
TAP version 13
selftests: cpufreq: main.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid 1244's current affinity mask: 3
pid 1244's new affinity mask: 1
not ok 1..1 selftests: cpufreq: main.sh [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/cpufreq'
ignored_by_lkp efivarfs test: /sys/firmware/efi dir does not exist

2018-12-30 22:36:56 make run_tests -C exec
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec'
gcc -Wall    execveat.c  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/execveat
cd /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b=
907db91c/tools/testing/selftests/exec && ln -s -f execveat execveat.symlink
cp /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b=
907db91c/tools/testing/selftests/exec/execveat /usr/src/perf_selftests-x86_=
64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftest=
s/exec/execveat.denatured
chmod -x /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/execveat.denatured
echo '#!/bin/sh' > /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9204=
71f816b755166d1b907db91c/tools/testing/selftests/exec/script
echo 'exit $*' >> /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a92047=
1f816b755166d1b907db91c/tools/testing/selftests/exec/script
chmod +x /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/script
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/exec/subdir
TAP version 13
selftests: exec: execveat
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/bin/sh: 0: Can't open /dev/fd/7/usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
Check success of execveat(4, '../execveat', 0)... [OK]
Check success of execveat(6, 'execveat', 0)... [OK]
Check success of execveat(8, 'execveat', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...ftests/exec/execvea=
t', 0)... [OK]
Check success of execveat(99, '/usr/src/perf_selfte...ftests/exec/execveat'=
, 0)... [OK]
Check success of execveat(10, '', 4096)... [OK]
Check success of execveat(19, '', 4096)... [OK]
Check success of execveat(11, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(16, '', 4096)... [OK]
Check success of execveat(17, '', 4096)... [OK]
Check failure of execveat(10, '', 0) with ENOENT... [OK]
Check failure of execveat(10, '(null)', 4096) with EFAULT... [OK]
Check success of execveat(6, 'execveat.symlink', 0)... [OK]
Check success of execveat(8, 'execveat.symlink', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...xec/execveat.symlin=
k', 0)... [OK]
Check success of execveat(12, '', 4096)... [OK]
Check success of execveat(12, '', 4352)... [OK]
Check failure of execveat(6, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(8, 'execveat.symlink', 256) with ELOOP... [OK]
Check failure of execveat(-100, '/usr/src/perf_selftests-x86_64-rhel-7.2-46=
7e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/exec/execvea=
t.symlink', 256) with ELOOP... [OK]
Check success of execveat(4, '../script', 0)... [OK]
Check success of execveat(6, 'script', 0)... [OK]
Check success of execveat(8, 'script', 0)... [OK]
Check success of execveat(-100, '/usr/src/perf_selfte...elftests/exec/scrip=
t', 0)... [OK]
Check success of execveat(15, '', 4096)... [OK]
Check success of execveat(15, '', 4352)... [OK]
Check failure of execveat(20, '', 4096) with ENOENT... [OK]
Check failure of execveat(9, 'script', 0) with ENOENT... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(18, '', 4096)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check success of execveat(5, 'script', 0)... [OK]
Check success of execveat(5, '../script', 0)... [OK]
Check failure of execveat(5, 'script', 0) with ENOENT... [OK]
Check failure of execveat(6, 'execveat', 65535) with EINVAL... [OK]
Check failure of execveat(6, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(8, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(-100, 'no-such-file', 0) with ENOENT... [OK]
Check failure of execveat(6, '', 4096) with EACCES... [OK]
Check failure of execveat(6, 'Makefile', 0) with EACCES... [OK]
Check failure of execveat(13, '', 4096) with EACCES... [OK]
Check failure of execveat(14, '', 4096) with EACCES... [OK]
Check failure of execveat(99, '', 4096) with EBADF... [OK]
Check failure of execveat(99, 'execveat', 0) with EBADF... [OK]
Check failure of execveat(10, 'execveat', 0) with ENOTDIR... [OK]
Invoke copy of 'execveat' via filename of length 4094:
Check success of execveat(21, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
Invoke copy of 'script' via filename of length 4094:
Check success of execveat(22, '', 4096)... [OK]
Check success of execveat(7, 'usr/src/perf_selftes...yyyyyyyyyyyyyyyyyyyy',=
 0)... [OK]
ok 1..1 selftests: exec: execveat [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/exec'
ignored_by_lkp filesystems test
2018-12-30 22:36:57 mv /lib/udev/rules.d/50-firmware.rules .
2018-12-30 22:36:57 /etc/init.d/udev restart
Restarting udev (via systemctl): udev.service.

2018-12-30 22:36:57 make run_tests -C firmware
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/firmware'
TAP version 13
selftests: firmware: fw_run_tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-----------------------------------------------------
Running kernel configuration test 1 -- rare
Emulates:
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_USER_HELPER=3Dn
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dn
=2E/fw_filesystem.sh: filesystem loading works
=2E/fw_filesystem.sh: async filesystem loading works

Testing with the file present...
Batched request_firmware() try #1: OK
Batched request_firmware() try #2: OK
Batched request_firmware() try #3: OK
Batched request_firmware() try #4: OK
Batched request_firmware() try #5: OK
Batched request_firmware_direct() try #1: OK
Batched request_firmware_direct() try #2: OK
Batched request_firmware_direct() try #3: OK
Batched request_firmware_direct() try #4: OK
Batched request_firmware_direct() try #5: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #1: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #2: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #3: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #4: OK
Batched request_firmware_nowait(uevent=3Dtrue) try #5: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #1: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #2: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #3: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #4: OK
Batched request_firmware_nowait(uevent=3Dfalse) try #5: OK

Testing with the file missing...
Batched request_firmware() nofile try #1: OK
Batched request_firmware() nofile try #2: OK
Batched request_firmware() nofile try #3: OK
Batched request_firmware() nofile try #4: OK
Batched request_firmware() nofile try #5: OK
Batched request_firmware_direct() nofile try #1: OK
Batched request_firmware_direct() nofile try #2: OK
Batched request_firmware_direct() nofile try #3: OK
Batched request_firmware_direct() nofile try #4: OK
Batched request_firmware_direct() nofile try #5: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #1: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #2: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #3: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #4: OK
Batched request_firmware_nowait(uevent=3Dtrue) nofile try #5: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #1: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #2: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #3: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #4: OK
Batched request_firmware_nowait(uevent=3Dfalse) nofile try #5: OK
usermode helper disabled so ignoring test
not ok 1..1 selftests: firmware: fw_run_tests.sh [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/firmware'
2018-12-30 22:37:38 mv 50-firmware.rules /lib/udev/rules.d/50-firmware.rules

2018-12-30 22:37:38 make run_tests -C ftrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ftrace'
TAP version 13
selftests: ftrace: ftracetest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2E/ftracetest: 163: [: Illegal number:=20
-e =3D=3D=3D Ftrace unit tests =3D=3D=3D
-e -n [1] Basic trace file check
-e 	[PASS]
-e -n [2] Basic test for tracers
-e 	[PASS]
-e -n [3] Basic trace clock test
-e 	[PASS]
-e -n [4] Basic event tracing check
-e 	[PASS]
-e -n [5] Change the ringbuffer size
-e 	[PASS]
-e -n [6] Snapshot and tracing setting
-e 	[PASS]
-e -n [7] trace_pipe and trace_marker
-e 	[PASS]
-e -n [8] event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [9] event tracing - restricts events based on pid
-e 	[PASS]
-e -n [10] event tracing - enable/disable with subsystem level files
-e 	[PASS]
-e -n [11] event tracing - enable/disable with top level files
-e 	[PASS]
-e -n [12] Test trace_printk from module
-e 	[UNRESOLVED]
-e -n [13] ftrace - function graph filters with stack tracer
-e 	[PASS]
-e -n [14] ftrace - function graph filters
-e 	[PASS]
-e -n [15] ftrace - function glob filters
-e 	[PASS]
-e -n [16] ftrace - function pid filters
-e 	[PASS]
-e -n [17] ftrace - stacktrace filter command
-e 	[PASS]
-e -n [18] ftrace - function trace with cpumask
-e 	[PASS]
-e -n [19] ftrace - test for function event triggers
-e 	[PASS]
-e -n [20] ftrace - function trace on module
-e 	[UNRESOLVED]
-e -n [21] ftrace - function profiling
-e 	[PASS]
-e -n [22] ftrace - function profiler with function tracing
-e 	[PASS]
-e -n [23] ftrace - test reading of set_ftrace_filter
-e 	[PASS]
-e -n [24] ftrace - Max stack tracer
-e 	[PASS]
-e -n [25] ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [26] Test creation and deletion of trace instances while setting an e=
vent
-e 	[PASS]
-e -n [27] Test creation and deletion of trace instances
-e 	[PASS]
-e -n [28] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [29] Kprobe dynamic event - busy event check
-e 	[PASS]
-e -n [30] Kprobe dynamic event with arguments
-e 	[PASS]
-e -n [31] Kprobe event with comm arguments
-e 	[PASS]
-e -n [32] Kprobe event string type argument
-e 	[PASS]
-e -n [33] Kprobe event symbol argument
-e 	[PASS]
-e -n [34] Kprobe event argument syntax
-e 	[PASS]
-e -n [35] Kprobes event arguments with types
-e 	[PASS]
-e -n [36] Kprobe event auto/manual naming
-e 	[PASS]
-e -n [37] Kprobe dynamic event with function tracer
-e 	[PASS]
-e -n [38] Kprobe dynamic event - probing module
-e 	[UNRESOLVED]
-e -n [39] Kretprobe dynamic event with arguments
-e 	[PASS]
-e -n [40] Kretprobe dynamic event with maxactive
-e 	[PASS]
-e -n [41] Register/unregister many kprobe events
-e 	[PASS]
-e -n [42] Kprobe events - probe points
-e 	[PASS]
-e -n [43] Kprobe dynamic event - adding and removing
-e 	[PASS]
-e -n [44] test for the preemptirqsoff tracer
-e 	[UNSUPPORTED]
-e -n [45] Test wakeup tracer
-e 	[PASS]
-e -n [46] Test wakeup RT tracer
-e 	[PASS]
-e -n [47] event trigger - test extended error support
-e 	[PASS]
-e -n [48] event trigger - test field variable support
-e 	[PASS]
-e -n [49] event trigger - test inter-event combined histogram trigger
-e 	[PASS]
-e -n [50] event trigger - test multiple actions on hist trigger
-e 	[PASS]
-e -n [51] event trigger - test inter-event histogram trigger onmatch action
-e 	[PASS]
-e -n [52] event trigger - test inter-event histogram trigger onmatch-onmax=
 action
-e 	[PASS]
-e -n [53] event trigger - test inter-event histogram trigger onmax action
-e 	[PASS]
-e -n [54] event trigger - test synthetic event create remove
-e 	[PASS]
-e -n [55] event trigger - test synthetic_events syntax parser
-e 	[PASS]
-e -n [56] event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [57] event trigger - test trigger filter
-e 	[PASS]
-e -n [58] event trigger - test histogram modifiers
-e 	[PASS]
-e -n [59] event trigger - test histogram trigger
-e 	[PASS]
-e -n [60] event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [61] event trigger - test snapshot-trigger
-e 	[PASS]
-e -n [62] event trigger - test stacktrace-trigger
-e 	[PASS]
-e -n [63] trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [64] trace_marker trigger - test snapshot trigger
-e 	[PASS]
-e -n [65] trace_marker trigger - test histogram with synthetic event again=
st kernel event
-e 	[PASS]
-e -n [66] trace_marker trigger - test histogram with synthetic event
-e 	[PASS]
-e -n [67] event trigger - test traceon/off trigger
-e 	[PASS]
-e -n [68] (instance)  Basic test for tracers
-e 	[PASS]
-e -n [69] (instance)  Basic trace clock test
-e 	[PASS]
-e -n [70] (instance)  Change the ringbuffer size
-e 	[PASS]
-e -n [71] (instance)  Snapshot and tracing setting
-e 	[PASS]
-e -n [72] (instance)  trace_pipe and trace_marker
-e 	[PASS]
-e -n [73] (instance)  event tracing - enable/disable with event level files
-e 	[PASS]
-e -n [74] (instance)  event tracing - restricts events based on pid
-e 	[PASS]
-e -n [75] (instance)  event tracing - enable/disable with subsystem level =
files
-e 	[PASS]
-e -n [76] (instance)  ftrace - stacktrace filter command
-e 	[PASS]
-e -n [77] (instance)  ftrace - test for function event triggers
-e 	[PASS]
-e -n [78] (instance)  ftrace - test for function traceon/off triggers
-e 	[PASS]
-e -n [79] (instance)  event trigger - test event enable/disable trigger
-e 	[PASS]
-e -n [80] (instance)  event trigger - test trigger filter
-e 	[PASS]
-e -n [81] (instance)  event trigger - test histogram modifiers
-e 	[PASS]
-e -n [82] (instance)  event trigger - test histogram trigger
-e 	[PASS]
-e -n [83] (instance)  event trigger - test multiple histogram triggers
-e 	[PASS]
-e -n [84] (instance)  trace_marker trigger - test histogram trigger
-e 	[PASS]
-e -n [85] (instance)  trace_marker trigger - test snapshot trigger
-e 	[PASS]


-e=20
-e # of passed:  81
-e # of failed:  0
-e # of unresolved:  3
-e # of untested:  0
-e # of unsupported:  1
-e # of xfailed:  0
-e # of undefined(test bug):  0
not ok 1..1 selftests: ftrace: ftracetest [FAIL]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ftrace'

2018-12-30 22:39:59 make run_tests -C futex
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functional'
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_timeout.c ../include/futextest.h ../include/atomic.h ../inc=
lude/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9204=
71f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_wai=
t_timeout
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_wouldblock.c ../include/futextest.h ../include/atomic.h ../=
include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9=
20471f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_=
wait_wouldblock
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi.c ../include/futextest.h ../include/atomic.h ../inclu=
de/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471=
f816b755166d1b907db91c/tools/testing/selftests/futex/functional/futex_reque=
ue_pi
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_signal_restart.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_signal_restart
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_requeue_pi_mismatched_ops.c ../include/futextest.h ../include/at=
omic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467=
e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functio=
nal/futex_requeue_pi_mismatched_ops
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_uninitialized_heap.c ../include/futextest.h ../include/atom=
ic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3=
fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functiona=
l/futex_wait_uninitialized_heap
gcc  -g -O2 -Wall -D_GNU_SOURCE -pthread -I../include -I../../   -pthread -=
lrt  futex_wait_private_mapped_file.c ../include/futextest.h ../include/ato=
mic.h ../include/logging.h  -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e=
3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/function=
al/futex_wait_private_mapped_file
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/futex/functional'
TAP version 13
selftests: futex: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified

# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D1 timeout=3D0ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D0 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D5000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D0 owner=3D1 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D500000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D1 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=3D0 locked=3D1 owner=3D0 timeout=3D2000000000ns
ok 1 futex-requeue-pi
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
ok 1 futex-requeue-pi-mismatched-ops
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# 	Arguments: <none>
ok 1 futex-requeue-pi-signal-restart
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_timeout: Block on a futex and wait for timeout
# 	Arguments: timeout=3D100000ns
ok 1 futex-wait-timeout
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
ok 1 futex-wait-wouldblock
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1

# futex_wait_uninitialized_heap: Test the uninitialized futex value in FUTE=
X_WAIT
ok 1 futex-wait-uninitialized-heap
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
# futex_wait_private_mapped_file: Test the futex value of private file mapp=
ings in FUTEX_WAIT
ok 1 futex-wait-private-mapped-file
Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..1
ok 1..1 selftests: futex: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/futex'

2018-12-30 22:40:14 make run_tests -C gpio
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/gpio'
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c'
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/basic/fixdep
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/unifdef
  INSTALL usr/include/asm-generic/ (37 files)
  INSTALL usr/include/drm/ (26 files)
  INSTALL usr/include/linux/ (501 files)
  INSTALL usr/include/linux/android/ (1 file)
  INSTALL usr/include/linux/byteorder/ (2 files)
  INSTALL usr/include/linux/caif/ (2 files)
  INSTALL usr/include/linux/can/ (6 files)
  INSTALL usr/include/linux/cifs/ (1 file)
  INSTALL usr/include/linux/dvb/ (8 files)
  INSTALL usr/include/linux/genwqe/ (1 file)
  INSTALL usr/include/linux/hdlc/ (1 file)
  INSTALL usr/include/linux/hsi/ (2 files)
  INSTALL usr/include/linux/iio/ (2 files)
  INSTALL usr/include/linux/isdn/ (1 file)
  INSTALL usr/include/linux/mmc/ (1 file)
  INSTALL usr/include/linux/netfilter/ (88 files)
  INSTALL usr/include/linux/netfilter/ipset/ (4 files)
  INSTALL usr/include/linux/netfilter_arp/ (2 files)
  INSTALL usr/include/linux/netfilter_bridge/ (17 files)
  INSTALL usr/include/linux/netfilter_ipv4/ (9 files)
  INSTALL usr/include/linux/netfilter_ipv6/ (13 files)
  INSTALL usr/include/linux/nfsd/ (5 files)
  INSTALL usr/include/linux/raid/ (2 files)
  INSTALL usr/include/linux/sched/ (1 file)
  INSTALL usr/include/linux/spi/ (1 file)
  INSTALL usr/include/linux/sunrpc/ (1 file)
  INSTALL usr/include/linux/tc_act/ (15 files)
  INSTALL usr/include/linux/tc_ematch/ (5 files)
  INSTALL usr/include/linux/usb/ (13 files)
  INSTALL usr/include/linux/wimax/ (1 file)
  INSTALL usr/include/misc/ (2 files)
  INSTALL usr/include/mtd/ (5 files)
  INSTALL usr/include/rdma/ (25 files)
  INSTALL usr/include/rdma/hfi/ (2 files)
  INSTALL usr/include/scsi/ (5 files)
  INSTALL usr/include/scsi/fc/ (4 files)
  INSTALL usr/include/sound/ (16 files)
  INSTALL usr/include/video/ (3 files)
  INSTALL usr/include/xen/ (4 files)
  INSTALL usr/include/asm/ (62 files)
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c'
make OUTPUT=3D/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f81=
6b755166d1b907db91c/tools/gpio/ -C /usr/src/perf_selftests-x86_64-rhel-7.2-=
467e3fea0c6a920471f816b755166d1b907db91c/tools/gpio
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
mkdir -p /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/gpio/include/linux 2>&1 || true
ln -sf /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/gpio/../../include/uapi/linux/gpio.h /usr/src/perf_selft=
ests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/gpio/in=
clude/linux/gpio.h
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dlsgpio
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio.o
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-utils.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/lsgpio
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dgpio-hammer
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-hammer
make -f /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/build/Makefile.build dir=3D. obj=3Dgpio-event-mon
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/gpio'
  CC       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon.o
  LD       /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon-in.o
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
  LINK     /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/gpio/gpio-event-mon
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/gpio'
gcc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/    gpio-mockup-cha=
rdev.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/gpio/gpio-utils.o  -lmount -I/usr/include/libmount -o gp=
io-mockup-chardev
TAP version 13
selftests: gpio: gpio-mockup.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.  Test dynamic allocation of gpio successful means insert gpiochip and
    manipulate gpio pin successful
GPIO gpio-mockup test with ranges: <-1,32>:=20
-1,32     =20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32>=
:=20
-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: GPIO gpio-mockup test with ranges: <-1,32,-1,32,=
-1,32>:=20
-1,32,-1,32,-1,32=20
gpio<gpio-mockup> test failed
Test gpiochip gpio-mockup: 3.  Error test: successful means insert gpiochip=
 failed
3.1 Test number of gpio overflow
GPIO gpio-mockup test with ranges: <-1,32,-1,1024>:=20
-1,32,-1,1024=20
Test gpiochip gpio-mockup: Invalid test successful
GPIO test PASS
ok 1..1 selftests: gpio: gpio-mockup.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/gpio'
ia64 test: not in Makefile
2018-12-30 22:40:42 make TARGETS=3Dia64
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
gcc     aliasing-test.c   -o aliasing-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'

2018-12-30 22:40:43 make run_tests -C ia64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'
Makefile:9: warning: overriding recipe for target 'clean'
=2E./lib.mk:137: warning: ignoring old recipe for target 'clean'
TAP version 13
selftests: ia64: aliasing-test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PASS: /dev/mem 0x0-0xa0000 is readable
PASS: /dev/mem 0xa0000-0xc0000 is mappable
PASS: /dev/mem 0xc0000-0x100000 is readable
PASS: /dev/mem 0x0-0x100000 is mappable
PASS: /sys/devices/pci0000:00/0000:00:02.0/rom read 39422 bytes
PASS: /sys/devices/pci0000:00/0000:00:03.0/rom read 231422 bytes
PASS: /proc/bus/pci/00/00.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0xa0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.1 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/01.3 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/02.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/03.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/04.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/05.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/06.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/07.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/08.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/09.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xa0000-0xc0000 not mappable
PASS: /proc/bus/pci/00/00.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0xc0000-0x100000 not mappable
PASS: /proc/bus/pci/00/00.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.1 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/01.3 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/02.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/03.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/04.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/05.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/06.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/07.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/08.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/09.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0a.0 0x0-0x100000 not mappable
PASS: /proc/bus/pci/00/0b.0 0x0-0x100000 not mappable
ok 1..1 selftests: ia64: aliasing-test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ia64'

2018-12-30 22:40:45 make run_tests -C intel_pstate
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/intel_pstate'
gcc  -Wall -D_GNU_SOURCE    msr.c  -lm -o /usr/src/perf_selftests-x86_64-rh=
el-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/int=
el_pstate/msr
gcc  -Wall -D_GNU_SOURCE    aperf.c  -lm -o /usr/src/perf_selftests-x86_64-=
rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/i=
ntel_pstate/aperf
TAP version 13
selftests: intel_pstate: run.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 90: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
cpupower: error while loading shared libraries: libcpupower.so.0: cannot op=
en shared object file: No such file or directory
=2E/run.sh: line 92: / 1000: syntax error: operand expected (error token is=
 "/ 1000")
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The marketing frequency of the cpu is 0 MHz
The maximum frequency of the cpu is  MHz
The minimum frequency of the cpu is  MHz
Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
ok 1..1 selftests: intel_pstate: run.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/intel_pstate'

2018-12-30 22:40:46 make run_tests -C ipc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/ipc'
gcc -DCONFIG_X86_64 -D__x86_64__ -I../../../../usr/include/    msgque.c  -o=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/ipc/msgque
msgque.c: In function =E2=80=98restore_queue=E2=80=99:
msgque.c:52:7: warning: implicit declaration of function =E2=80=98msgget=E2=
=80=99 [-Wimplicit-function-declaration]
  id =3D msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
       ^~~~~~
msgque.c:66:7: warning: implicit declaration of function =E2=80=98msgsnd=E2=
=80=99 [-Wimplicit-function-declaration]
   if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
       ^~~~~~
msgque.c:76:6: warning: implicit declaration of function =E2=80=98msgctl=E2=
=80=99 [-Wimplicit-function-declaration]
  if (msgctl(id, IPC_RMID, 0))
      ^~~~~~
msgque.c: In function =E2=80=98check_and_destroy_queue=E2=80=99:
msgque.c:87:9: warning: implicit declaration of function =E2=80=98msgrcv=E2=
=80=99 [-Wimplicit-function-declaration]
   ret =3D msgrcv(msgque->msq_id, &message.mtype, MAX_MSG_SIZE,
         ^~~~~~
msgque.c: In function =E2=80=98main=E2=80=99:
msgque.c:203:15: warning: implicit declaration of function =E2=80=98ftok=E2=
=80=99 [-Wimplicit-function-declaration]
  msgque.key =3D ftok(argv[0], 822155650);
               ^~~~
TAP version 13
selftests: ipc: msgque
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: ipc: msgque [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/ipc'

2018-12-30 22:40:46 make run_tests -C kcmp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kcmp'
gcc -I../../../../usr/include/    kcmp_test.c  -o /usr/src/perf_selftests-x=
86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selft=
ests/kcmp/kcmp_test
TAP version 13
selftests: kcmp: kcmp_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
pid1:  14051 pid2:  14052 FD:  1 FILES:  2 VM:  2 FS:  1 SIGHAND:  1 IO:  0=
 SYSVSEM:  0 INV: -1
PASS: 0 returned as expected
PASS: 0 returned as expected
PASS: 0 returned as expected
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..3
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..1 selftests: kcmp: kcmp_test [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kcmp'
kmod test: not in Makefile
2018-12-30 22:40:46 make TARGETS=3Dkmod
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'

2018-12-30 22:40:46 make run_tests -C kmod
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'
TAP version 13
selftests: kmod: kmod.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #0
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #1
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0001 - run #2
kmod_test_0001_driver: OK! - loading kmod test
kmod_test_0001_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0001_fs: OK! - loading kmod test
kmod_test_0001_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:47 UTC 2018
Running test: kmod_test_0002 - run #0
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0002 - run #1
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0002 - run #2
kmod_test_0002_driver: OK! - loading kmod test
kmod_test_0002_driver: OK! - Return value: 256 (MODULE_NOT_FOUND), expected=
 MODULE_NOT_FOUND
kmod_test_0002_fs: OK! - loading kmod test
kmod_test_0002_fs: OK! - Return value: -22 (-EINVAL), expected -EINVAL
Sun Dec 30 22:40:48 UTC 2018
Running test: kmod_test_0003 - run #0
kmod_test_0003: OK! - loading kmod test
kmod_test_0003: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0004 - run #0
kmod_test_0004: OK! - loading kmod test
kmod_test_0004: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0005 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:49 UTC 2018
Running test: kmod_test_0005 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:50 UTC 2018
Running test: kmod_test_0005 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:50 UTC 2018
Running test: kmod_test_0005 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #5
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:51 UTC 2018
Running test: kmod_test_0005 - run #6
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #7
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #8
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:52 UTC 2018
Running test: kmod_test_0005 - run #9
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:53 UTC 2018
Running test: kmod_test_0006 - run #0
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:54 UTC 2018
Running test: kmod_test_0006 - run #1
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:54 UTC 2018
Running test: kmod_test_0006 - run #2
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:55 UTC 2018
Running test: kmod_test_0006 - run #3
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:55 UTC 2018
Running test: kmod_test_0006 - run #4
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:56 UTC 2018
Running test: kmod_test_0006 - run #5
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:56 UTC 2018
Running test: kmod_test_0006 - run #6
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:57 UTC 2018
Running test: kmod_test_0006 - run #7
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:58 UTC 2018
Running test: kmod_test_0006 - run #8
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:40:59 UTC 2018
Running test: kmod_test_0006 - run #9
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:00 UTC 2018
Running test: kmod_test_0007 - run #0
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:01 UTC 2018
Running test: kmod_test_0007 - run #1
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:02 UTC 2018
Running test: kmod_test_0007 - run #2
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:03 UTC 2018
Running test: kmod_test_0007 - run #3
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
Sun Dec 30 22:41:04 UTC 2018
Running test: kmod_test_0007 - run #4
kmod_test_0005: OK! - loading kmod test
kmod_test_0005: OK! - Return value: 0 (SUCCESS), expected SUCCESS
kmod_test_0006: OK! - loading kmod test
kmod_test_0006: OK! - Return value: 0 (SUCCESS), expected SUCCESS
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
=2E/kmod.sh: line 529: [[: 1 0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1=
 0007:5:1 0008:150:1 0009:150:1: syntax error in expression (error token is=
 "0002:3:1 0003:1:1 0004:1:1 0005:10:1 0006:10:1 0007:5:1 0008:150:1 0009:1=
50:1")
Test completed
ok 1..1 selftests: kmod: kmod.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kmod'

2018-12-30 22:41:05 make run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm'
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/assert.c -o /usr/src/per=
f_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/=
testing/selftests/kvm/lib/assert.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/elf.c -o /usr/src/perf_s=
elftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/tes=
ting/selftests/kvm/lib/elf.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/io.c -o /usr/src/perf_se=
lftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/test=
ing/selftests/kvm/lib/io.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/kvm_util.c -o /usr/src/p=
erf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tool=
s/testing/selftests/kvm/lib/kvm_util.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/ucall.c -o /usr/src/perf=
_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/t=
esting/selftests/kvm/lib/ucall.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib -Iinclude/x86_64 -I..   -c lib/sparsebit.c -o /usr/src/=
perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/too=
ls/testing/selftests/kvm/lib/sparsebit.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/processor.=
c -o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/lib/x86_64/processor.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I..   -c lib/x86_64/vmx.c -o /=
usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907d=
b91c/tools/testing/selftests/kvm/lib/x86_64/vmx.o
make ARCH=3Dx86 -C ../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c'
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c'
ar crs /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75516=
6d1b907db91c/tools/testing/selftests/kvm/libkvm.a /usr/src/perf_selftests-x=
86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selft=
ests/kvm/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a9=
20471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/elf.o /usr/src/=
perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/too=
ls/testing/selftests/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-7.2-4=
67e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/kvm=
_util.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7551=
66d1b907db91c/tools/testing/selftests/kvm/lib/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/s=
elftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b7=
55166d1b907db91c/tools/testing/selftests/kvm/lib/x86_64/vmx.o
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/platform_inf=
o_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755=
166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selft=
ests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing=
/selftests/kvm/x86_64/platform_info_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/set_sregs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/sel=
ftests/kvm/x86_64/set_sregs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/sync_regs_te=
st.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d=
1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests=
-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/sel=
ftests/kvm/x86_64/sync_regs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/vmx_tsc_adju=
st_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75=
5166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testin=
g/selftests/kvm/x86_64/vmx_tsc_adjust_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/cr4_cpuid_sy=
nc_test.c /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b75=
5166d1b907db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_self=
tests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testin=
g/selftests/kvm/x86_64/cr4_cpuid_sync_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/state_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftes=
ts/kvm/x86_64/state_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  x86_64/evmcs_test.c=
 /usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b90=
7db91c/tools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86=
_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftes=
ts/kvm/x86_64/evmcs_test
gcc -O2 -g -std=3Dgnu99 -I../../../../tools/include -I../../../../usr/inclu=
de/ -Iinclude -I. -Iinclude/x86_64 -I..  -pthread  dirty_log_test.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.2-467e3fea0c6a920471f816b755166d1b907db91c/t=
ools/testing/selftests/kvm/libkvm.a  -o /usr/src/perf_selftests-x86_64-rhel=
-7.2-467e3fea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm/d=
irty_log_test
TAP version 13
selftests: kvm: platform_info_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..1 selftests: kvm: platform_info_test [SKIP]
selftests: kvm: set_sregs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..2 selftests: kvm: set_sregs_test [SKIP]
selftests: kvm: sync_regs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..3 selftests: kvm: sync_regs_test [SKIP]
selftests: kvm: vmx_tsc_adjust_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..4 selftests: kvm: vmx_tsc_adjust_test [SKIP]
selftests: kvm: cr4_cpuid_sync_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..5 selftests: kvm: cr4_cpuid_sync_test [SKIP]
selftests: kvm: state_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..6 selftests: kvm: state_test [SKIP]
selftests: kvm: evmcs_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
not ok 1..7 selftests: kvm: evmcs_test [SKIP]
selftests: kvm: dirty_log_test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Test iterations: 32, interval: 10 (ms)
Testing guest mode: PA-bits:52, VA-bits:48, 4K pages
guest test mem offset: 0x40000000
not ok 1..8 selftests: kvm: dirty_log_test [SKIP]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/kvm'

2018-12-30 22:41:13 make run_tests -C lib
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/lib'
TAP version 13
selftests: lib: printf.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
printf: ok
ok 1..1 selftests: lib: printf.sh [PASS]
selftests: lib: bitmap.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bitmap: [FAIL]
not ok 1..2 selftests: lib: bitmap.sh [FAIL]
selftests: lib: prime_numbers.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
prime_numbers: ok
ok 1..3 selftests: lib: prime_numbers.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/lib'
locking test: not in Makefile
2018-12-30 22:41:13 make TARGETS=3Dlocking
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3f=
ea0c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fe=
a0c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'

2018-12-30 22:41:14 make run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0=
c6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'
TAP version 13
selftests: locking: ww_mutex.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
locking/ww_mutex: ok
ok 1..1 selftests: locking: ww_mutex.sh [PASS]
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-467e3fea0c=
6a920471f816b755166d1b907db91c/tools/testing/selftests/locking'

--GBDnBH7+ZvLx8QD4--
