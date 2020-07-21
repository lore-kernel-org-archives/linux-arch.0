From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V4 00/15] entry, x86, kvm: Generic entry/exit functionality
 for host and guest
Date: Tue, 21 Jul 2020 12:57:06 +0200
Message-ID: <20200721105706.030914876@linutronix.de>
Content-Transfer-Encoding: 8-bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

This is the 4rd version of generic entry/exit functionality for host and
guest.

The 3rd version is available here:

    https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

Changes vs. V3:

  - Drop the architecture wrappers for seccomp and audit (Kees)
  - Move the user return notifier out of the loop
  - Bring I/O bitmap handling back
  - Use the existing helpers to get syscall number and return value
  - Drop dummy defines for SYSCALL_TRACE and NOTIFY_RESUME as all
    architectures define them
  - Fix TIF_SYSCALL_AUDIT dummy define
  - Adjust comments

The patches depend on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

The lot is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

Thanks,

	tglx
---
 arch/Kconfig                        |    3 
 arch/x86/Kconfig                    |    1 
 arch/x86/entry/common.c             |  632 ++----------------------------------
 arch/x86/entry/entry_32.S           |    2 
 arch/x86/entry/entry_64.S           |    2 
 arch/x86/include/asm/entry-common.h |   76 ++++
 arch/x86/include/asm/idtentry.h     |   39 --
 arch/x86/include/asm/ptrace.h       |    5 
 arch/x86/include/asm/signal.h       |    1 
 arch/x86/include/asm/thread_info.h  |    5 
 arch/x86/kernel/cpu/mce/core.c      |    4 
 arch/x86/kernel/kvm.c               |    6 
 arch/x86/kernel/signal.c            |    3 
 arch/x86/kernel/traps.c             |   24 -
 arch/x86/kvm/Kconfig                |    1 
 arch/x86/kvm/vmx/vmx.c              |   11 
 arch/x86/kvm/x86.c                  |   15 
 arch/x86/mm/fault.c                 |    6 
 include/linux/entry-common.h        |  372 +++++++++++++++++++++
 include/linux/entry-kvm.h           |   80 ++++
 include/linux/kvm_host.h            |    8 
 include/linux/seccomp.h             |    1 
 kernel/Makefile                     |    1 
 kernel/entry/Makefile               |    4 
 kernel/entry/common.c               |  374 +++++++++++++++++++++
 kernel/entry/kvm.c                  |   51 ++
 virt/kvm/Kconfig                    |    3 
 27 files changed, 1067 insertions(+), 663 deletions(-)
