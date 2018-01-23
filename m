From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 00/10] siginfo infrastructure
Date: Tue, 23 Jan 2018 15:05:29 -0600
Message-ID: <87607s5lra.fsf_-_@xmission.com>
References: <87373b6ghs.fsf@xmission.com> <87vag6zupo.fsf@xmission.com>
        <87k1wimybi.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:45974 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeAWVG2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 16:06:28 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Mon, 15 Jan 2018 18:39:29 -0600")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>


The following changes are available at:
    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git  siginfo-testing

This updates the signal sending infrastructure to make it easier to get
to the point where we are certain every struct siginfo we send to
userspace is fully initialized and thus can be copied verbatim to
userspace.

Today copy_siginfo_to_user performs a piecewise copy of siginfo to
userspace because we don't know that all of the struct siginfo has
been initialized.

Unfortunately do to bugs not even knowing the proper union member is
enough to know that the fields we copy to userspace have all been
initialized in every case.

The core idiom that needs to be used is:

	struct siginfo si;

	clear_siginfo(&si);
        si.xxx = yyy;
        ...
        force_sig_info(SIG_sss, &si, tsk);

As the fields for the different union members all need to be initialized
this patchset works to make this less error prone by introducing a
series of helpers that take the needed fields and properly initialize
siginfo before sending it deeper into the signal stack.

The helpers are:
force_sig_fault
force_sig_mceerr
force_sig_bnderr
force_sig_pkuerr
send_sig_fault
send_sig_mceer

Today I count 227 calls of force_sig_info and send_sig_info in the
kernel.  After the helpers introduced here are used in the obvious
places to use them the count shrinks to just 43.  Something that is much
more reasonable to maintain and to audit to ensure all of the details
are just so.

This changeset does not include all of the architecture changes as that
is still a large set of changes that needs to be reviewed carefully.
I expect those to be post 4.17 material.  While the infrastrcture
can go in in 4.16.

In addition to the helpers a several general cleanups happen to help
ensure that all instances of struct siginfo are intialized.

Eric W. Biederman (10):
      ptrace: Use copy_siginfo in setsiginfo and getsiginfo
      signal/arm64: Better isolate the COMPAT_TASK portion of ptrace_hbptriggered
      signal: Don't use structure initializers for struct siginfo
      signal: Replace memset(info,...) with clear_siginfo for clarity
      signal: Add send_sig_fault and force_sig_fault
      signal: Helpers for faults with specialized siginfo layouts
      signal/powerpc: Remove unnecessary signal_code parameter of do_send_trap
      signal/ptrace: Add force_sig_ptrace_errno_trap and use it where needed
      mm/memory_failure: Remove unused trapno from memory_failure
      signal/memory-failure: Use force_sig_mceerr and send_sig_mceerr

 arch/arc/kernel/traps.c                            |  14 ++-
 arch/arm/kernel/ptrace.c                           |   8 +-
 arch/arm64/kernel/debug-monitors.c                 |  13 ++-
 arch/arm64/kernel/ptrace.c                         |  42 +++----
 arch/m68k/mm/fault.c                               |   3 +-
 arch/mips/kernel/traps.c                           |  29 +++--
 arch/parisc/kernel/pdt.c                           |   2 +-
 arch/powerpc/include/asm/debug.h                   |   2 +-
 arch/powerpc/kernel/process.c                      |  13 +--
 arch/powerpc/kernel/traps.c                        |  12 +-
 .../powerpc/platforms/powernv/opal-memory-errors.c |   2 +-
 arch/tile/kernel/single_step.c                     |  24 ++--
 arch/tile/kernel/traps.c                           |   4 +-
 arch/tile/kernel/unaligned.c                       |  46 ++++----
 arch/um/kernel/trap.c                              |   2 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |   6 +-
 arch/xtensa/kernel/ptrace.c                        |   8 +-
 drivers/acpi/apei/ghes.c                           |   2 +-
 drivers/base/memory.c                              |   2 +-
 drivers/ras/cec.c                                  |   2 +-
 drivers/usb/core/devio.c                           |   4 +-
 include/linux/mm.h                                 |   4 +-
 include/linux/sched/signal.h                       |  28 +++++
 kernel/ptrace.c                                    |   4 +-
 kernel/seccomp.c                                   |   2 +-
 kernel/signal.c                                    | 126 ++++++++++++++++++++-
 kernel/time/posix-timers.c                         |   2 +-
 mm/hwpoison-inject.c                               |   2 +-
 mm/madvise.c                                       |   2 +-
 mm/memory-failure.c                                |  48 ++++----
 30 files changed, 305 insertions(+), 153 deletions(-)

Eric
