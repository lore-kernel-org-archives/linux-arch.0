From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 00/14] Remove redundant arch_*_relax operations
Date: Tue, 17 Sep 2013 16:07:32 +0100
Message-ID: <1379430466-30520-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41197 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752815Ab3IQPH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Sep 2013 11:07:58 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>

Hi linux-arch,

Now that the core part of this series has hit mainline (c14c338cb05c
["kernel/spinlock.c: add default arch_*_relax definitions for
GENERIC_LOCKBREAK"]), these arch patches should be fine to apply via
their respective trees.

I can mop up what's left next merge window if necessary.

Cheers,

Will


Will Deacon (14):
  ARC: locks: remove redundant arch_*_relax operations
  ARM: locks: remove redundant arch_*_relax operations
  arm64: locks: remove redundant arch_*_relax operations
  blackfin: locks: remove redundant arch_*_relax operations
  cris: locks: remove redundant arch_*_relax operations
  ia64: locks: remove redundant arch_*_relax operations
  m32r: locks: remove redundant arch_*_relax operations
  metag: locks: remove redundant arch_*_relax operations
  mips: locks: remove redundant arch_*_relax operations
  hppa: locks: remove redundant arch_*_relax operations
  s390: locks: remove redundant arch_*_relax operations
  sh: locks: remove redundant arch_*_relax operations
  sparc: locks: remove redundant arch_*_relax operations
  x86: locks: remove redundant arch_*_relax operations

 arch/arc/include/asm/spinlock.h            | 4 ----
 arch/arm/include/asm/spinlock.h            | 4 ----
 arch/arm64/include/asm/spinlock.h          | 4 ----
 arch/blackfin/include/asm/spinlock.h       | 4 ----
 arch/cris/include/arch-v32/arch/spinlock.h | 4 ----
 arch/ia64/include/asm/spinlock.h           | 4 ----
 arch/m32r/include/asm/spinlock.h           | 4 ----
 arch/metag/include/asm/spinlock.h          | 4 ----
 arch/metag/include/asm/spinlock_lnkget.h   | 7 -------
 arch/mips/include/asm/spinlock.h           | 4 ----
 arch/parisc/include/asm/spinlock.h         | 4 ----
 arch/s390/include/asm/spinlock.h           | 4 +---
 arch/sh/include/asm/spinlock.h             | 4 ----
 arch/sparc/include/asm/spinlock_32.h       | 4 ----
 arch/sparc/include/asm/spinlock_64.h       | 4 ----
 arch/x86/include/asm/spinlock.h            | 4 ----
 16 files changed, 1 insertion(+), 66 deletions(-)

-- 
1.8.2.2
