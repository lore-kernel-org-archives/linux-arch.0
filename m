From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Date: Mon, 13 Sep 2010 07:07:31 +0100
Message-ID: <cover.1284357372.git.matt@console-pimps.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The perf-events backend for OProfile that Will Deacon wrote in
8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
perf-events framework as backend") is of use to more architectures
than just ARM. Move the code into drivers/oprofile/ so that SH can use
it instead of the nearly identical copy of its OProfile code.

The benefit of the backend is that it becomes necessary to only
maintain one copy of the PMU accessor functions for each architecture,
with bug fixes and new features benefiting both OProfile and perf.

Note that I haven't been able to test these patches on an ARM board to
see if I've caused any regressions. If anyone else could do that I'd
appreciate it. Though, I have been able to compile this version of the
series.

This patch series is based on,

    git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git core

These patches can also be found at,

    git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.git perf-oprofile

Changes from v2:
 - Rebased against Robert's oprofile core branch
 - Moved even more of the ARM code into the generic oprofile code
 - Broke the patches up into more logical steps

Changes from v1:
 - Prefix the new functons with "oprofile_" instead of "op_".
 - Fix ARM compilation errors
 - Move all the oprofile-perf logic into oprofile_perf.c
 - Include cleanup patch from Will

Matt Fleming (6):
  perf: Add helper function to return number of counters
  ARM: oprofile: Rename op_arm to oprofile_perf
  ARM: oprofile: Move non-ARM code into separate init/exit functions
  oprofile: Abstract the perf-events backend
  ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS
  sh: oprofile: Use perf-events oprofile backend

 arch/arm/Kconfig                 |    2 +-
 arch/arm/kernel/perf_event.c     |    6 +
 arch/arm/oprofile/Makefile       |    2 +-
 arch/arm/oprofile/common.c       |  315 +------------------------------------
 arch/sh/Kconfig                  |    2 +-
 arch/sh/kernel/perf_event.c      |   17 ++
 arch/sh/oprofile/Makefile        |    2 +-
 arch/sh/oprofile/common.c        |  104 ++-----------
 arch/sh/oprofile/op_impl.h       |   33 ----
 drivers/oprofile/oprofile_perf.c |  322 ++++++++++++++++++++++++++++++++++++++
 include/linux/oprofile.h         |    6 +
 include/linux/perf_event.h       |    1 +
 12 files changed, 368 insertions(+), 444 deletions(-)
 delete mode 100644 arch/sh/oprofile/op_impl.h
 create mode 100644 drivers/oprofile/oprofile_perf.c

