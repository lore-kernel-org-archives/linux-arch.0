Return-Path: <SRS0=xoZC=5W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDFMhT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Apr 2020 08:37:19 -0400
From: guoren@kernel.org
Subject: [ GIT PULL ] csky updates for v5.7-rc1
Date: Mon,  6 Apr 2020 20:37:13 +0800
Message-ID: <20200406123713.30492-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Message-ID: <20200406123713.HMbm1MA9fS7B-AOMoRpkcrUGj3FncRnzbM6fQR77jrQ@z>

Hi Linus,

Please pull the changes for v5.7-rc1. In this round, we have some features
and fixups.

Best Regards
 Guo Ren

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc1

for you to fetch changes up to aefd9461d34a1b0a2acad0750c43216c1c27b9d4:

  csky: Fixup cpu speculative execution to IO area (2020-04-03 12:40:07 +0800)

----------------------------------------------------------------
csky updates for 5.7-rc1

 - Add kproobes/uprobes support
 - Add lockdep, rseq, gcov support
 - Fixup init_fpu
 - Fixup ftrace_modify deadlock
 - Fixup speculative execution on IO area

----------------------------------------------------------------
Guo Ren (10):
      csky: Fixup init_fpu compile warning with __init
      csky: Implement ptrace regs and stack API
      csky: Add support for restartable sequence
      csky: Implement ftrace with regs
      csky/ftrace: Fixup ftrace_modify_code deadlock without CPU_HAS_ICACHE_INS
      csky: Fixup get wrong psr value from phyical reg
      csky: Enable LOCKDEP_SUPPORT
      csky: Add kprobes supported
      csky: Add uprobes support
      csky: Fixup cpu speculative execution to IO area

Ma Jun (1):
      csky: Enable the gcov function

 arch/csky/Kconfig                            |  13 +
 arch/csky/abiv1/inc/abi/entry.h              |   5 +-
 arch/csky/abiv2/fpu.c                        |   5 -
 arch/csky/abiv2/inc/abi/entry.h              |  67 +++-
 arch/csky/abiv2/inc/abi/fpu.h                |   3 +-
 arch/csky/abiv2/mcount.S                     |  48 +++
 arch/csky/include/asm/Kbuild                 |   1 -
 arch/csky/include/asm/ftrace.h               |   2 +
 arch/csky/include/asm/kprobes.h              |  48 +++
 arch/csky/include/asm/probes.h               |  24 ++
 arch/csky/include/asm/processor.h            |   1 +
 arch/csky/include/asm/ptrace.h               |  43 +++
 arch/csky/include/asm/thread_info.h          |   2 +
 arch/csky/include/asm/uprobes.h              |  33 ++
 arch/csky/kernel/Makefile                    |   1 +
 arch/csky/kernel/asm-offsets.c               |   1 +
 arch/csky/kernel/entry.S                     |  18 +-
 arch/csky/kernel/ftrace.c                    |  42 +++
 arch/csky/kernel/head.S                      |   5 +
 arch/csky/kernel/probes/Makefile             |   7 +
 arch/csky/kernel/probes/decode-insn.c        |  49 +++
 arch/csky/kernel/probes/decode-insn.h        |  20 ++
 arch/csky/kernel/probes/ftrace.c             |  66 ++++
 arch/csky/kernel/probes/kprobes.c            | 499 +++++++++++++++++++++++++++
 arch/csky/kernel/probes/kprobes_trampoline.S |  19 +
 arch/csky/kernel/probes/simulate-insn.c      | 398 +++++++++++++++++++++
 arch/csky/kernel/probes/simulate-insn.h      |  49 +++
 arch/csky/kernel/probes/uprobes.c            | 150 ++++++++
 arch/csky/kernel/ptrace.c                    | 103 ++++++
 arch/csky/kernel/setup.c                     |  63 +---
 arch/csky/kernel/signal.c                    |   6 +
 arch/csky/kernel/smp.c                       |   6 +
 arch/csky/kernel/traps.c                     |  29 +-
 arch/csky/mm/cachev2.c                       |  45 ++-
 arch/csky/mm/fault.c                         |  11 +
 35 files changed, 1807 insertions(+), 75 deletions(-)
 create mode 100644 arch/csky/include/asm/kprobes.h
 create mode 100644 arch/csky/include/asm/probes.h
 create mode 100644 arch/csky/include/asm/uprobes.h
 create mode 100644 arch/csky/kernel/probes/Makefile
 create mode 100644 arch/csky/kernel/probes/decode-insn.c
 create mode 100644 arch/csky/kernel/probes/decode-insn.h
 create mode 100644 arch/csky/kernel/probes/ftrace.c
 create mode 100644 arch/csky/kernel/probes/kprobes.c
 create mode 100644 arch/csky/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/csky/kernel/probes/simulate-insn.c
 create mode 100644 arch/csky/kernel/probes/simulate-insn.h
 create mode 100644 arch/csky/kernel/probes/uprobes.c
