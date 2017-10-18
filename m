From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 0/4][PoC][RFC] Add rlimit-resources change notification
 mechanism
Date: Wed, 18 Oct 2017 22:32:26 +0200
Message-ID: <20171018203230.29871-1-k.opasiak@samsung.com>
References: <CGME20171018203324epcas2p310def24eea6171d0821f1068d055d3b7@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

This is a Proof of Concept and RFC of rlimit-events - generic,
low-overhead notification mechanism for monitoring process-level
resources. This series is not ready for submission. Its main purpose is
to share the overall idea and collect feedback from the community.
All comments are very welcome.

Problem statement
=================

Linux is running tons of userspace software and a big part of it
is imperfect. It's nothing new. People discovered this long time ago
on their servers and that's why they introduced monitoring tools like
Nagios. Those tools are used not only to monitor system-wide resources
but also process-specific ones for critical services.

Base idea of such a monitoring tool is to run periodic check
(like every 10 min) of given resource usage, collect the results and
most importantly perform some action (like send email to admin) when
resource usage reaches particular level.

This idea has couple of disadvantages. First of all, one have no
information what happens between the checks. The resource may go above
and/or below notification level many times but no action is going to
be performed. Secondly this solution comes from the server world. In
that case power usage is not not a major problem, as the power is not
as scarce a resource as in battery-powered devices.

IoT world and servers seems to be very different but they have at
least one common feature - they need to run imperfect software for
a long period of time with best possible availability. That's why
we would like to monitor resource usage also on IoT devices while the
server world would still be able to benefit from the new solution.

In contrast to server world IoT devices are very concerned about power
usage. Also their usage profile is very different. Servers are very
busy machines (working with high load) while IoT devices usually just
do nothing waiting for user stimulus. That's why if we simply try to
reuse server world solution it turns out that devices often wake
up only to check the resource usage even though it's it has remained
unchanged for a number of hours. Not to mention that when user comes
back home and starts playing with lights, music etc resource usage may
change way more often than the polling period. To solve those issues
we need to replace polling with asynchronous notification about
resource usage change.

Try #1 - use existing tools
===========================

First of all we tried to use existing tools - audit in particular.
We manage to implement some very simple version but then we
discovered couple of problems:

1) It's not possible to monitor resources which are not bound to
syscalls e.g. CPU

2) It's not possible to monitor number of open FDs if they are
allocated and returned from ioctl() or socket

3) Audit has a significant performance overhead. With only a single
audit rule in the system, which is not being triggered, the time
overhead for open() call on Odroid U3+ is 44.6% for a hot file (in
cache or virtual) and 33.34% for a cold file (on eMMC).

3) Audit slows down the entire system, not only the process that's
being monitored

Solution - rlimit-events
========================

To resolve audit-related problems we developed a kernel infrastructure
to notify userspace about reaching a particular level of resource
usage by given process.

The main idea is to provide a userspace process a file descriptor
which can be used to subscribe for a notification when the chosen
process reaches given resource usage level.

To provide a fully-flexible solution we decided that a single process
may monitor multiple other processes and a single process can be
monitored by many other processes. One of important design goals
was to minimize the performance overhead. That's why watchers are
not only installed in per process manner but also every resource has
a separate list of them. This allows to limit overhead not only to
the process that's being monitored but also to syscalls related to the
monitored resource (if you monitor only FD usage there is no performance
impact on memory-related syscalls). Using the same test as for audit
our PoC achieved 1.58% overhead for cold file and 5.63% for hot file
(Plus 4% overhead for each of them for very simple counting of number
of open file descriptors which could be replaced with a counter).

Typical scenario:
1) Obtain a notification FD from the kernel via Netlink
(if someone has a better idea I will be happy to change this)

2) Issue ioctl() to add new watchers. Each ioctl() contains a triplet:
PID, Resource, Level

3) read() or poll() the notification FD. When the monitored resource's
usage of a process specified in 2) crosses the level set there FD
suitable event can be read from this FD

A sample test application can be found on my github:

    https://github.com/kopasiak/rlimit-events-tests


Please share your opinion about idea and current design.

--
Best regards
Krzysztof Opasiak
---
Krzysztof Opasiak (4):
  sched: Allow to get() and put() signal struct
  Add rlimit-events framework
  Connect rlimit-events with process life cycle
  Allow to trace fd usage with rlimit-events

 drivers/android/binder.c         |   2 +-
 fs/exec.c                        |   2 +-
 fs/file.c                        |  80 +++-
 fs/open.c                        |   2 +-
 include/asm-generic/resource.h   |  37 +-
 include/linux/fdtable.h          |   6 +-
 include/linux/init_task.h        |   1 +
 include/linux/rlimit_noti_kern.h |  54 +++
 include/linux/sched/signal.h     |  19 +
 include/uapi/linux/netlink.h     |   1 +
 include/uapi/linux/rlimit_noti.h |  71 ++++
 init/Kconfig                     |   6 +
 kernel/Makefile                  |   1 +
 kernel/exit.c                    |   4 +
 kernel/fork.c                    |  25 +-
 kernel/rlimit_noti.c             | 793 +++++++++++++++++++++++++++++++++++++++
 16 files changed, 1076 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/rlimit_noti_kern.h
 create mode 100644 include/uapi/linux/rlimit_noti.h
 create mode 100644 kernel/rlimit_noti.c

-- 
2.9.3
