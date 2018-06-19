From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 00/27] kprobes: Cleanup jprobe implementation
Date: Wed, 20 Jun 2018 01:04:08 +0900
Message-ID: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello,

This is the 6th version of the series for removing jprobe.
Previous version is here:

 https://lkml.org/lkml/2018/6/4/681

In this version, I fixed x86 and powerpc kprobe_ftrace_handler
to include post-handler emulation code according to Naveen's
suggestion. This also simplifies [24/27] a bit. Also fixed some
typo in patch description.

Series structure
=====
Basically this series introduces 3 major changes;

- Remove jprobe implementation ([2/27] - [12/27])

- Remove break_handler() related code ([13/27] - [23/27])
  This should be done after (or with) removing jprobe
  because break_handler is only used by jprobe.
 (I'm not so sure, should I merge above patches into one
  arch-wide patch as next one does?)

- Clean current_kprobe and enable preempt if pre_handler()
  returns !0 ([24/27] and [25/27]<- x86 specific update)
  This also depends on above patches because those
  current_kprobe and preemption are expected to be adjusted
  by jprobe implementation via break_handler.

And some minor changes;

- Document cleanup and update ([1/27], [26/27])

And finally remove jprobe stub APIs and break_handler
from kprobes.h ([27/27]). Of course this depends on
above patches.

Result
=====
I've tested it with kprobe sanity test on x86-64, and arm64
but for other archs, I just did cross-build test.

Thank you,

---

Masami Hiramatsu (27):
      Documentation/kprobes: Fix to remove remaining jprobe
      kprobes: Remove jprobe API implementation
      kprobes/x86: Remove jprobe implementation
      ARC: kprobes: Remove jprobe implementation
      ARM: kprobes: Remove jprobe arm implementation
      arm64: kprobes: Remove jprobe implementation
      powerpc/kprobes: Remove jprobe powerpc implementation
      ia64: kprobes: Remove jprobe implementation
      MIPS: kprobes: Remove jprobe implementation
      s390/kprobes: Remove jprobe implementation
      sh: kprobes: Remove jprobe implementation
      sparc64: kprobes: Remove jprobe implementation
      kprobes: Don't check the ->break_handler() in generic kprobes code
      kprobes/x86: Don't call ->break_handler() in x86 kprobes
      ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
      ARM: kprobes: Don't call the ->break_handler() in arm kprobes code
      arm64: kprobes: Don't call the ->break_handler() in arm64 kprobes code
      powerpc/kprobes: Don't call the ->break_handler() in powerpc kprobes code
      ia64: kprobes: Don't call the ->break_handler() in ia64 kprobes code
      MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
      s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
      sh: kprobes: Don't call the ->break_handler() in SH kprobes code
      sparc64: kprobes: Don't call the ->break_handler() in sparc64 kprobes code
      bpf: error-inject: kprobes: Clear current_kprobe and enable preempt in kprobe
      kprobes/x86: Do not disable preempt on int3 path
      Documentation: kprobes: Add how to change the execution path
      kprobes: Remove jprobe stub API


 Documentation/kprobes.txt                      |   35 +++++-
 arch/arc/include/asm/kprobes.h                 |    2 
 arch/arc/kernel/kprobes.c                      |   50 +--------
 arch/arm/include/asm/kprobes.h                 |    2 
 arch/arm/include/asm/probes.h                  |    1 
 arch/arm/probes/kprobes/core.c                 |  135 +-----------------------
 arch/arm64/include/asm/kprobes.h               |    1 
 arch/arm64/kernel/probes/kprobes.c             |   86 +--------------
 arch/ia64/include/asm/kprobes.h                |    2 
 arch/ia64/include/uapi/asm/break.h             |    1 
 arch/ia64/kernel/Makefile                      |    2 
 arch/ia64/kernel/jprobes.S                     |   90 ----------------
 arch/ia64/kernel/kprobes.c                     |   93 +----------------
 arch/mips/include/asm/kprobes.h                |   13 --
 arch/mips/kernel/kprobes.c                     |   70 ++----------
 arch/powerpc/include/asm/kprobes.h             |   12 --
 arch/powerpc/kernel/kprobes-ftrace.c           |   72 ++-----------
 arch/powerpc/kernel/kprobes.c                  |   92 +++-------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 +------
 arch/s390/include/asm/kprobes.h                |    2 
 arch/s390/kernel/kprobes.c                     |   86 +--------------
 arch/sh/include/asm/kprobes.h                  |    4 -
 arch/sh/kernel/kprobes.c                       |   72 +------------
 arch/sparc/include/asm/kprobes.h               |    1 
 arch/sparc/kernel/kprobes.c                    |   65 +-----------
 arch/x86/include/asm/kprobes.h                 |    5 -
 arch/x86/kernel/kprobes/common.h               |   10 --
 arch/x86/kernel/kprobes/core.c                 |  119 +--------------------
 arch/x86/kernel/kprobes/ftrace.c               |   49 ++-------
 arch/x86/kernel/kprobes/opt.c                  |    1 
 include/linux/kprobes.h                        |   53 ---------
 kernel/fail_function.c                         |    3 -
 kernel/kprobes.c                               |  115 +-------------------
 kernel/test_kprobes.c                          |   94 -----------------
 kernel/trace/trace_kprobe.c                    |   11 +-
 lib/Kconfig.debug                              |    2 
 36 files changed, 139 insertions(+), 1351 deletions(-)
 delete mode 100644 arch/ia64/kernel/jprobes.S

--
Masami Hiramatsu (Linaro)
