Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbfI3Kbf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 06:31:35 -0400
From: guoren@kernel.org
Subject: [GIT PULL] csky changes for v5.3-rc1
Date: Mon, 30 Sep 2019 18:31:24 +0800
Message-ID: <1569839484-28170-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Message-ID: <20190930103124.PVIeb8QZNf3LlcPgqD2B5KKlV6jE7dx2lLPhIPpwj7E@z>

Hi Linus,

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.4-rc1

for you to fetch changes up to 9af032a30172e119a5935f802b066631f8ded2d6:

  csky: Move static keyword to the front of declaration (2019-09-30 11:50:49 +0800)

----------------------------------------------------------------
csky-for-linus-5.4-rc1: arch/csky patches for 5.4-rc1

This round of csky subsystem just some fixups.

Fixup:
 - Fixup mb() synchronization problem
 - Fixup dma_alloc_coherent with PAGE_SO attribute
 - Fixup cache_op failed when cross memory ZONEs
 - Optimize arch_sync_dma_for_cpu/device with dma_inv_range
 - Fixup ioremap function losing
 - Fixup arch_get_unmapped_area() implementation
 - Fixup defer cache flush for 610
 - Support kernel non-aligned access
 - Fixup 610 vipt cache flush mechanism
 - Fixup add zero_fp fixup perf backtrace panic
 - Move static keyword to the front of declaration
 - Fixup csky_pmu.max_period assignment
 - Use generic free_initrd_mem()
 - entry: Remove unneeded need_resched() loop

CI-Tested: https://gitlab.com/c-sky/buildroot/pipelines/77689888

----------------------------------------------------------------
Guo Ren (10):
      csky: Fixup mb() synchronization problem
      csky: Fixup dma_alloc_coherent with PAGE_SO attribute
      csky/dma: Fixup cache_op failed when cross memory ZONEs
      csky: Optimize arch_sync_dma_for_cpu/device with dma_inv_range
      csky: Fixup ioremap function losing
      csky: Fixup arch_get_unmapped_area() implementation
      csky: Fixup defer cache flush for 610
      csky: Support kernel non-aligned access
      csky: Fixup 610 vipt cache flush mechanism
      csky: Fixup add zero_fp fixup perf backtrace panic

Krzysztof Wilczynski (1):
      csky: Move static keyword to the front of declaration

Mao Han (1):
      csky: Fixup csky_pmu.max_period assignment

Mike Rapoport (1):
      csky: Use generic free_initrd_mem()

Valentin Schneider (1):
      csky: entry: Remove unneeded need_resched() loop

 arch/csky/abiv1/alignment.c          | 62 +++++++++++++++++++++--------
 arch/csky/abiv1/cacheflush.c         | 70 ++++++++++++++++++++++-----------
 arch/csky/abiv1/inc/abi/cacheflush.h | 45 ++++++++++++++-------
 arch/csky/abiv1/inc/abi/page.h       |  5 ++-
 arch/csky/abiv1/mmap.c               | 75 ++++++++++++++++++-----------------
 arch/csky/include/asm/barrier.h      | 15 ++++---
 arch/csky/include/asm/cache.h        |  1 +
 arch/csky/include/asm/io.h           | 23 +++++------
 arch/csky/include/asm/pgtable.h      | 10 +++++
 arch/csky/kernel/entry.S             | 54 +++++++++++++------------
 arch/csky/kernel/perf_event.c        |  4 +-
 arch/csky/kernel/process.c           |  2 +-
 arch/csky/mm/cachev1.c               |  7 +++-
 arch/csky/mm/cachev2.c               | 11 +++++-
 arch/csky/mm/dma-mapping.c           | 76 +++++++++++++-----------------------
 arch/csky/mm/init.c                  | 16 --------
 arch/csky/mm/ioremap.c               | 27 ++++++++-----
 17 files changed, 291 insertions(+), 212 deletions(-)
