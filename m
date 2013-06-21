From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 00/16] Remove unused arch_*_relax operations from spinlocks
Date: Fri, 21 Jun 2013 18:17:21 +0100
Message-ID: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49293 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423320Ab3FURRo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Jun 2013 13:17:44 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>

Hello,

This is an RFC cleanup series removing the unused
arch_{spin,read,write}_relax macros from (nearly) all architectures that
define them. The macros have no users in core code and are typically
synonymous with cpu_relax(), the notable exceptions being PowerPC (where
the thing is still unused) and S390.

S390 does actually use the relax macros internally, as part of the
spinlock implementation, in order to yield the CPU when a virtual CPU
is spinning. For that reason, I've left arch_spin_relax alone there.

Feedback welcome,

Will


Will Deacon (16):
  alpha: locks: remove unused arch_*_relax operations
  arc: locks: remove unused arch_*_relax operations
  ARM: locks: remove unused arch_*_relax operations
  arm64: locks: remove unused arch_*_relax operations
  blackfin: locks: remove unused arch_*_relax operations
  cris: locks: remove unused arch_*_relax operations
  ia64: locks: remove unused arch_*_relax operations
  m32r: locks: remove unused arch_*_relax operations
  metag: locks: remove unused arch_*_relax operations
  mips: locks: remove unused arch_*_relax operations
  hppa: locks: remove unused arch_*_relax operations
  powerpc: locks: remove unused arch_*_relax operations
  s390: locks: remove unused arch_*_relax operations
  sh: locks: remove unused arch_*_relax operations
  sparc: locks: remove unused arch_*_relax operations
  x86: locks: remove unused arch_*_relax operations

 arch/alpha/include/asm/spinlock.h          | 4 ----
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
 arch/powerpc/include/asm/spinlock.h        | 4 ----
 arch/s390/include/asm/spinlock.h           | 3 ---
 arch/sh/include/asm/spinlock.h             | 4 ----
 arch/sparc/include/asm/spinlock_32.h       | 4 ----
 arch/sparc/include/asm/spinlock_64.h       | 4 ----
 arch/x86/include/asm/spinlock.h            | 4 ----
 18 files changed, 74 deletions(-)

-- 
1.8.2.2
