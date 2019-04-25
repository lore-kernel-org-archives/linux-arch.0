Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfDYIgs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Apr 2019 04:36:48 -0400
From: guoren@kernel.org
Subject: [GIT PULL] csky fixes for v5.1-rc7
Date: Thu, 25 Apr 2019 16:36:43 +0800
Message-ID: <1556181403-3881-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190425083643.OHbjGVTsUCFzNCQ3bUugBgD1_oYcoZaCrdP9k1_2abU@z>

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.1-rc7

for you to fetch changes up to a691f3334d58b833e41d56de1b9820e687edcd78:

  csky/syscall_trace: Fixup return processing flow (2019-04-22 15:55:28 +0800)

----------------------------------------------------------------
arch/csky patches for 5.1-rc7

Here are the patches which made on 5.1-rc6 and all are tested in our
buildroot gitlab CI:
https://gitlab.com/c-sky/buildroot/pipelines/57892579

 - Fixup vdsp&fpu issues in kernel
 - Add dynamic function tracer
 - Use in_syscall & forget_syscall instead of r11_sig
 - Reconstruct signal processing
 - Support dynamic start physical address
 - Fixup wrong update_mmu_cache implementation
 - Support vmlinux bootup with MMU off
 - Use va_pa_offset instead of phys_offset
 - Fixup syscall_trace return processing flow
 - Add perf callchain support
 - Add perf_arch_fetch_caller_regs support
 - Add page fault perf event support
 - Add support for perf registers sampling

----------------------------------------------------------------
Guo Ren (12):
      csky: Fixup vdsp&fpu issues in kernel
      csky/ftrace: Add dynamic function tracer (include graph tracer)
      csky: Update syscall_trace_enter/exit implementation
      csky: Add non-uapi asm/ptrace.h namespace
      csky: Use in_syscall & forget_syscall instead of r11_sig
      csky: Reconstruct signal processing
      csky: Support dynamic start physical address
      csky: Fixup wrong update_mmu_cache implementation
      csky: Support vmlinux bootup with MMU off
      csky: Use va_pa_offset instead of phys_offset
      csky: Fixup compile warning
      csky/syscall_trace: Fixup return processing flow

Jagadeesh Pagadala (1):
      csky: mm/fault.c: Remove duplicate header

Mao Han (4):
      csky: Add perf callchain support
      csky: Add perf_arch_fetch_caller_regs support
      csky: add page fault perf event support
      csky: Add support for perf registers sampling

Masahiro Yamada (1):
      csky: remove redundant generic-y

 arch/csky/Kconfig                      |   7 +-
 arch/csky/Makefile                     |   2 +-
 arch/csky/abiv1/inc/abi/ckmmu.h        |  24 ++-
 arch/csky/abiv1/inc/abi/entry.h        |  41 ++--
 arch/csky/abiv1/inc/abi/regdef.h       |   5 +-
 arch/csky/abiv2/cacheflush.c           |  13 +-
 arch/csky/abiv2/inc/abi/ckmmu.h        |  34 +++-
 arch/csky/abiv2/inc/abi/entry.h        |  87 +++++++--
 arch/csky/abiv2/inc/abi/regdef.h       |   5 +-
 arch/csky/abiv2/mcount.S               |  39 +++-
 arch/csky/abiv2/memmove.S              |   6 +-
 arch/csky/include/asm/Kbuild           |   1 -
 arch/csky/include/asm/ftrace.h         |  18 +-
 arch/csky/include/asm/mmu_context.h    |  17 +-
 arch/csky/include/asm/page.h           |  39 ++--
 arch/csky/include/asm/perf_event.h     |   8 +
 arch/csky/include/asm/ptrace.h         |  41 ++++
 arch/csky/include/asm/syscall.h        |   9 +
 arch/csky/include/asm/thread_info.h    |  27 ++-
 arch/csky/include/asm/unistd.h         |   2 +
 arch/csky/include/uapi/asm/perf_regs.h |  51 +++++
 arch/csky/include/uapi/asm/ptrace.h    |  15 --
 arch/csky/kernel/Makefile              |   2 +
 arch/csky/kernel/atomic.S              |  26 +--
 arch/csky/kernel/entry.S               |  77 +++-----
 arch/csky/kernel/ftrace.c              | 148 +++++++++++++-
 arch/csky/kernel/head.S                |  60 +-----
 arch/csky/kernel/perf_callchain.c      | 119 +++++++++++
 arch/csky/kernel/perf_regs.c           |  40 ++++
 arch/csky/kernel/ptrace.c              |  51 +++--
 arch/csky/kernel/setup.c               |  12 +-
 arch/csky/kernel/signal.c              | 348 +++++++++++++--------------------
 arch/csky/mm/fault.c                   |  15 +-
 scripts/recordmcount.pl                |   3 +
 34 files changed, 890 insertions(+), 502 deletions(-)
 create mode 100644 arch/csky/include/asm/ptrace.h
 create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 arch/csky/kernel/perf_callchain.c
 create mode 100644 arch/csky/kernel/perf_regs.c
