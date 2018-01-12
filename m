From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 00/11] siginfo fixes/cleanups esp SI_USER
Date: Thu, 11 Jan 2018 18:57:35 -0600
Message-ID: <87373b6ghs.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


The following changes are available at:
    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git  siginfo-minor-fixesv2

While answering a question about my earlier introduction to
siginfo_layout I realized that the code introduces a small number
of cases where unitialized memory is copied to userspace as
a result of the fact that SI_USER is sometimes confused with
another si_code.

This modifies all of the places in the kernel that generate a signal
with si_code == SI_USER to fully initialize all of siginfo.  Further
this change updates architectures that are using si_code of 0 to
mean something other than SI_USER to use TRAP_FIXME, FPE_FIXME, or
BUS_FIXME to document the problem.

With all these changes take together there is no danger of copying
unitialized values to userspace when SI_USER is mistaken for TRAP_FIXME,
FPE_FIXME or BUS_FIXME.

This series also contains a fix for sh and a fix for openrisc where
they are improperly generating a signal and the fix is obvious.

Eric W. Biederman (11):
      signal: Simplify and fix kdb_send_sig
      signal/sh: Ensure si_signo is initialized in do_divide_error
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/parisc: Document a conflict with SI_USER with SIGFPE
      signal/metag: Document a conflict with SI_USER with SIGFPE
      signal/powerpc: Document conflicts with SI_USER and SIGFPE and SIGTRAP
      signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS
      signal/arm: Document conflicts with SI_USER and SIGFPE
      signal: Reduce copy_siginfo to just a memcpy
      signal: Introduce clear_siginfo
      signal: Ensure generic siginfos the kernel sends have all bits initialized

 arch/arm/include/uapi/asm/siginfo.h     |  13 ++++
 arch/arm/vfp/vfpmodule.c                |   2 +-
 arch/arm64/include/uapi/asm/siginfo.h   |  21 ++++++
 arch/arm64/kernel/fpsimd.c              |   2 +-
 arch/arm64/mm/fault.c                   | 114 ++++++++++++++++----------------
 arch/metag/include/uapi/asm/siginfo.h   |   7 ++
 arch/metag/kernel/traps.c               |   2 +-
 arch/openrisc/kernel/traps.c            |  10 +--
 arch/parisc/include/uapi/asm/siginfo.h  |   7 ++
 arch/parisc/kernel/traps.c              |   2 +-
 arch/powerpc/include/uapi/asm/siginfo.h |  15 +++++
 arch/powerpc/kernel/traps.c             |  10 +--
 arch/sh/kernel/traps_32.c               |   3 +-
 fs/fcntl.c                              |   1 +
 include/linux/signal.h                  |  13 ++--
 ipc/mqueue.c                            |   1 +
 kernel/debug/kdb/kdb_main.c             |  10 +--
 kernel/debug/kdb/kdb_private.h          |   2 +-
 kernel/signal.c                         |  27 +++++---
 19 files changed, 167 insertions(+), 95 deletions(-)
