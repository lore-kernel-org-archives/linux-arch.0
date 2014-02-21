From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH RESEND 00/14] spinlock: remove redundant arch_*_relax operations
Date: Fri, 21 Feb 2014 17:34:47 +0000
Message-ID: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44719 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933124AbaBURfI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Feb 2014 12:35:08 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

Hi Andrew,

I've been carrying these for ages and, whilst they're boring cosmetic
changes, I'd like to get them upstream so I can forget about this series.

The commit introducing the generic change making this possible went in
with c14c338cb05c ("kernel/spinlock.c: add default arch_*_relax definitions
for GENERIC_LOCKBREAK") back in September.

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
