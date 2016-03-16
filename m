From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v2 0/4] improvements to the nmi_backtrace code
Date: Wed, 16 Mar 2016 13:02:09 -0400
Message-ID: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
References: <20160307204317.GR6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160307204317.GR6344@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
List-Id: linux-arch.vger.kernel.org

From the version 1 cover letter:

  This patch series modifies the trigger_xxx_backtrace() NMI-based
  remote backtracing code to make it more flexible, and makes a few
  small improvements along the way.

  The motivation comes from the task isolation code, where there are
  scenarios where we want to be able to diagnose a case where some cpu
  is about to interrupt a task-isolated cpu.  It can be helpful to
  see both where the interrupting cpu is, and also an approximation
  of where the cpu that is being interrupted is.  The nmi_backtrace
  framework allows us to discover the stack of the interrupted cpu.

Version 2 of the patch series adopts the CPUIDLE_TEXT approach that I
suggested in some discussion around identifying idle cpus, and that
Peter Zijlstra endorsed.  I renumbered the patches to put the idle-test
patch last in the series (4/4) and it is the only one modified in this
version of the patch series.  (To be fair I did also change all the
S-O-B and author lines to be mellanox.com instead of ezchip.com).

I've tested that the change works as desired on tile, and build-tested
x86, arm64, and arm.  For x86 and arm64 I confirmed that the generic
cpuidle stuff as well as the architecture-specific routines are in the
new cpuidle section.  For arm I just build-tested it and made sure the
generic cpuidle routines were in the new cpuidle section, but I didn't
attempt to tease apart the tangle of platform-specific idle routines
that arm has and tag them with __cpuidle.  That might be more usefully
done by someone with arm platform experience in a follow-up patch.

v1 of the series is here:

https://lkml.kernel.org/r/1456782024-7122-1-git-send-email-cmetcalf@ezchip.com

Chris Metcalf (4):
  nmi_backtrace: add more trigger_*_cpu_backtrace() methods
  nmi_backtrace: do a local dump_stack() instead of a self-NMI
  arch/tile: adopt the new nmi_backtrace framework
  nmi_backtrace: generate one-line reports for idle cpus

 arch/alpha/kernel/vmlinux.lds.S      |  1 +
 arch/arc/kernel/vmlinux.lds.S        |  1 +
 arch/arm/include/asm/irq.h           |  4 +-
 arch/arm/kernel/smp.c                | 13 +------
 arch/arm/kernel/vmlinux.lds.S        |  1 +
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 arch/arm64/mm/proc.S                 |  2 +
 arch/avr32/kernel/vmlinux.lds.S      |  1 +
 arch/blackfin/kernel/vmlinux.lds.S   |  1 +
 arch/c6x/kernel/vmlinux.lds.S        |  1 +
 arch/cris/kernel/vmlinux.lds.S       |  1 +
 arch/frv/kernel/vmlinux.lds.S        |  1 +
 arch/h8300/kernel/vmlinux.lds.S      |  1 +
 arch/hexagon/kernel/vmlinux.lds.S    |  1 +
 arch/ia64/kernel/vmlinux.lds.S       |  1 +
 arch/m32r/kernel/vmlinux.lds.S       |  1 +
 arch/m68k/kernel/vmlinux-nommu.lds   |  1 +
 arch/m68k/kernel/vmlinux-std.lds     |  1 +
 arch/m68k/kernel/vmlinux-sun3.lds    |  1 +
 arch/metag/kernel/vmlinux.lds.S      |  1 +
 arch/microblaze/kernel/vmlinux.lds.S |  1 +
 arch/mips/kernel/vmlinux.lds.S       |  1 +
 arch/mn10300/kernel/vmlinux.lds.S    |  1 +
 arch/nios2/kernel/vmlinux.lds.S      |  1 +
 arch/openrisc/kernel/vmlinux.lds.S   |  1 +
 arch/parisc/kernel/vmlinux.lds.S     |  1 +
 arch/powerpc/kernel/vmlinux.lds.S    |  1 +
 arch/s390/kernel/vmlinux.lds.S       |  1 +
 arch/score/kernel/vmlinux.lds.S      |  1 +
 arch/sh/kernel/vmlinux.lds.S         |  1 +
 arch/sparc/kernel/vmlinux.lds.S      |  1 +
 arch/tile/include/asm/irq.h          |  4 +-
 arch/tile/kernel/entry.S             |  2 +-
 arch/tile/kernel/pmc.c               |  3 --
 arch/tile/kernel/process.c           | 72 ++++++++----------------------------
 arch/tile/kernel/traps.c             |  7 +++-
 arch/tile/kernel/vmlinux.lds.S       |  1 +
 arch/um/kernel/dyn.lds.S             |  1 +
 arch/um/kernel/uml.lds.S             |  1 +
 arch/unicore32/kernel/vmlinux.lds.S  |  1 +
 arch/x86/include/asm/irq.h           |  4 +-
 arch/x86/kernel/apic/hw_nmi.c        |  6 +--
 arch/x86/kernel/process.c            |  4 +-
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 include/asm-generic/vmlinux.lds.h    |  6 +++
 include/linux/cpu.h                  |  5 +++
 include/linux/nmi.h                  | 63 ++++++++++++++++++++++++-------
 kernel/sched/idle.c                  | 13 ++++++-
 lib/nmi_backtrace.c                  | 40 +++++++++++++-------
 scripts/mod/modpost.c                |  4 +-
 scripts/recordmcount.c               |  1 +
 scripts/recordmcount.pl              |  1 +
 52 files changed, 172 insertions(+), 115 deletions(-)

-- 
2.7.2
