From: guoren@kernel.org
Subject: [GIT PULL] csky updates for v5.9-rc1
Date: Thu,  6 Aug 2020 08:10:01 +0800
Message-ID: <1596672601-8227-1-git-send-email-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgHFAKO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 20:10:14 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org

Hi Linus,

Please pull csky updates for v5.9-rc1:

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.9-rc1

for you to fetch changes up to bdcd93ef9afb42a6051e472fa62c693b1f9edbd8:

  csky: Add context tracking support (2020-08-01 08:17:51 +0000)

----------------------------------------------------------------
arch/csky patches for 5.9-rc1

Features:
 - seccomp-filter
 - err-injection
 - top-down&random mmap-layout
 - irq_work
 - show_ipi
 - context-tracking)

Fixup & Optimize:
 - kprobe_on_ftrace
 - optimize panic print

----------------------------------------------------------------
Guo Ren (12):
      csky: Add SECCOMP_FILTER supported
      csky: Add cpu feature register hint for smp
      csky: Fixup duplicated restore sp in RESTORE_REGS_FTRACE
      csky: Fixup kprobes handler couldn't change pc
      csky: Add support for function error injection
      csky: Optimize the trap processing flow
      csky: Use top-down mmap layout
      csky: Set CONFIG_NR_CPU 4 as default
      csky: Fixup warning by EXPORT_SYMBOL(kmap)
      csky: Add irq_work support
      csky: Add arch_show_interrupts for IPI interrupts
      csky: Add context tracking support

Tobias Klauser (1):
      csky: remove unusued thread_saved_pc and *_segments functions/macros

 arch/csky/Kconfig                             |  29 +++-
 arch/csky/abiv2/inc/abi/entry.h               |   3 -
 arch/csky/abiv2/mcount.S                      |   4 +-
 arch/csky/include/asm/Kbuild                  |   1 +
 arch/csky/include/asm/bug.h                   |   3 +-
 arch/csky/include/asm/irq_work.h              |  11 ++
 arch/csky/include/asm/processor.h             |   6 -
 arch/csky/include/asm/ptrace.h                |   7 +
 arch/csky/include/asm/thread_info.h           |   2 +-
 arch/csky/kernel/entry.S                      |  28 ++++
 arch/csky/kernel/process.c                    |  10 --
 arch/csky/kernel/ptrace.c                     |  37 +----
 arch/csky/kernel/smp.c                        |  62 ++++++-
 arch/csky/kernel/traps.c                      | 223 +++++++++++++++++---------
 arch/csky/lib/Makefile                        |   1 +
 arch/csky/lib/error-inject.c                  |  10 ++
 arch/csky/mm/fault.c                          |  10 +-
 arch/csky/mm/highmem.c                        |   2 -
 tools/testing/selftests/seccomp/seccomp_bpf.c |  13 +-
 19 files changed, 319 insertions(+), 143 deletions(-)
 create mode 100644 arch/csky/include/asm/irq_work.h
 create mode 100644 arch/csky/lib/error-inject.c
