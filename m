From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH v7 0/4] improvements to the nmi_backtrace code
Date: Mon,  8 Aug 2016 12:03:34 -0400
Message-ID: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Petr Mladek <pmladek@suse.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
List-Id: linux-arch.vger.kernel.org

This is a rebase of the v6 series onto v4.8-rc1, plus some changes
from Petr Mladek's review this morning.

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

I've tested that the change works as desired on tile, and build-tested
x86, arm64, and arm.  For x86 and arm64 I confirmed that the generic
cpuidle stuff as well as the architecture-specific routines are in the
new cpuidle section.  For arm I just build-tested it and made sure the
generic cpuidle routines were in the new cpuidle section, but I didn't
attempt to tease apart the tangle of platform-specific idle routines
that arm has and tag them with __cpuidle.  That might be more usefully
done by someone with arm platform experience in a follow-up patch.

I have also pushed it up to kernel.org to pull if that's easier:

git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git nmi-backtrace

v7: Rebased to kernel v4.8-r1
    Retained the "include_self" bool to avoid cpumask allocation [Petr]
    Switched to using "cpumask_of" to avoid cpumask allocation [Petr]

v6: Rebased to kernel v4.7-rc7

v5: Add CPUIDLE_TEXT to the new arch/arm/kernel/vmlinux-xip.lds.S
    https://lkml.kernel.org/g/1459877208-15119-1-git-send-email-cmetcalf@mellanox.com

v4: Added some more __cpuidle functions (PeterZ, Rafael Wysocki)
    Rebased to kernel v4.6-rc1
    https://lkml.kernel.org/g/1459358170-27745-1-git-send-email-cmetcalf@mellanox.com

v3: Various improvements to the set of __cpuidle functions;
    Add back in a missing section accidentally removed in modpost.c (PeterZ)
    https://lkml.kernel.org/r/1458667179-19630-1-git-send-email-cmetcalf@mellanox.com

v2: Switch to using __cpuidle tagging, switch S-O-B to Mellanox
    https://lkml.kernel.org/r/1458147733-29338-1-git-send-email-cmetcalf@mellanox.com

Chris Metcalf (4):
  nmi_backtrace: add more trigger_*_cpu_backtrace() methods
  nmi_backtrace: do a local dump_stack() instead of a self-NMI
  arch/tile: adopt the new nmi_backtrace framework
  nmi_backtrace: generate one-line reports for idle cpus

 arch/alpha/kernel/vmlinux.lds.S      |  1 +
 arch/arc/kernel/vmlinux.lds.S        |  1 +
 arch/arm/include/asm/irq.h           |  5 ++-
 arch/arm/kernel/smp.c                | 13 +------
 arch/arm/kernel/vmlinux-xip.lds.S    |  1 +
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
 arch/tile/include/asm/irq.h          |  5 ++-
 arch/tile/kernel/entry.S             |  2 +-
 arch/tile/kernel/pmc.c               |  3 --
 arch/tile/kernel/process.c           | 73 +++++++++---------------------------
 arch/tile/kernel/traps.c             |  7 +++-
 arch/tile/kernel/vmlinux.lds.S       |  1 +
 arch/um/kernel/dyn.lds.S             |  1 +
 arch/um/kernel/uml.lds.S             |  1 +
 arch/unicore32/kernel/vmlinux.lds.S  |  1 +
 arch/x86/include/asm/irq.h           |  5 ++-
 arch/x86/kernel/acpi/cstate.c        |  2 +-
 arch/x86/kernel/apic/hw_nmi.c        |  7 ++--
 arch/x86/kernel/process.c            |  4 +-
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 arch/xtensa/kernel/vmlinux.lds.S     |  3 ++
 drivers/acpi/processor_idle.c        |  5 ++-
 drivers/cpuidle/driver.c             |  5 ++-
 drivers/idle/intel_idle.c            |  4 +-
 include/asm-generic/vmlinux.lds.h    |  6 +++
 include/linux/cpu.h                  |  5 +++
 include/linux/nmi.h                  | 49 +++++++++++++++++-------
 kernel/sched/idle.c                  | 13 ++++++-
 lib/nmi_backtrace.c                  | 38 +++++++++++++------
 scripts/mod/modpost.c                |  2 +-
 scripts/recordmcount.c               |  1 +
 scripts/recordmcount.pl              |  1 +
 58 files changed, 176 insertions(+), 118 deletions(-)

-- 
2.7.2
