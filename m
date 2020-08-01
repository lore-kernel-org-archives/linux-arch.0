From: guoren@kernel.org
Subject: [PATCH 00/13] Update csky subsystem for linux-5.9-rc1
Date: Sat,  1 Aug 2020 01:14:00 +0000
Message-ID: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHABOi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:38 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <guoren@linux.alibaba.com>

Here are the patchess for the next linux version. Add features
(seccomp-filter, err-injection, top-down&random mmap-layout, irq_work,
show_ipi, context-tracking), and fixup (kprobe_on_ftrace, ...),
Optimize (fault print, ...).

I think we'll finish most of features for arch/csky this year :) 

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
 arch/csky/kernel/entry.S                      |  26 +++
 arch/csky/kernel/process.c                    |  10 --
 arch/csky/kernel/ptrace.c                     |  37 +----
 arch/csky/kernel/smp.c                        |  62 ++++++-
 arch/csky/kernel/traps.c                      | 223 +++++++++++++++++---------
 arch/csky/lib/Makefile                        |   1 +
 arch/csky/lib/error-inject.c                  |  10 ++
 arch/csky/mm/fault.c                          |  10 +-
 arch/csky/mm/highmem.c                        |   2 -
 tools/testing/selftests/seccomp/seccomp_bpf.c |  13 +-
 19 files changed, 317 insertions(+), 143 deletions(-)
 create mode 100644 arch/csky/include/asm/irq_work.h
 create mode 100644 arch/csky/lib/error-inject.c

-- 
2.7.4
