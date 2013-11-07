From: peterz@infradead.org
Subject: [PATCH 0/4] arch: Introduce smp_load_acquire() and smp_store_release()
Date: Thu, 07 Nov 2013 23:03:14 +0100
Message-ID: <20131107220314.740353088@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37057 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab3KGWPZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2013 17:15:25 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Peter Zijlstra <peterz@infradead.org>

*** last posting didn't make it out to the lists ***

These patches introduce 2 new barrier primitives:

  smp_load_acquire(p)
  smp_store_release(p, v)

See the first patch, which changes Documentation/memory-barriers.txt, to find
the exact definitions of what an ACQUIRE/RELEASE barrier is -- previously known
as LOCK/UNLOCK barriers.

The second patch simplifies the asm/barrier.h implementation of a lot of
architectures by using asm-generic/barrier.h in order to save a lot of code
duplication later on.

The third patch adds the new barrier primitives.

The fourth adds the first user.

Build tested for:

alpha-defconfig - OK
ia64-defconfig - OK
m32r-defconfig - OK
frv-defconfig - OK
m68k-defconfig - OK
mips-defconfig - OK
mips-fuloong2e_defconfig - OK
arm-defconfig - OK
blackfin-defconfig - OK
mn10300-defconfig - OK
powerpc-ppc40x_defconfig - OK
powerpc-defconfig - OK
s390-defconfig - OK
sh-defconfig - OK
sparc-defconfig - OK
sparc64-defconfig - OK
i386-defconfig - OK
x86_64-defconfig - OK

Changes since the last posting that didn't make it out to lkml (and other lists)
due to an excessive Cc list:

 - added the fourth patch as a first user
 - changed the x86 implementation to not assume a TSO model 
   when OOSTORE or PPRO_FENCE

---
 Documentation/memory-barriers.txt     | 164 ++++++++++++++++++----------------
 arch/alpha/include/asm/barrier.h      |  25 ++----
 arch/arc/include/asm/Kbuild           |   1 +
 arch/arc/include/asm/atomic.h         |   5 ++
 arch/arc/include/asm/barrier.h        |  42 ---------
 arch/arm/include/asm/barrier.h        |  15 ++++
 arch/arm64/include/asm/barrier.h      |  50 +++++++++++
 arch/avr32/include/asm/barrier.h      |  17 ++--
 arch/blackfin/include/asm/barrier.h   |  18 +---
 arch/cris/include/asm/Kbuild          |   1 +
 arch/cris/include/asm/barrier.h       |  25 ------
 arch/frv/include/asm/barrier.h        |   8 +-
 arch/h8300/include/asm/barrier.h      |  21 +----
 arch/hexagon/include/asm/Kbuild       |   1 +
 arch/hexagon/include/asm/barrier.h    |  41 ---------
 arch/ia64/include/asm/barrier.h       |  49 ++++++++++
 arch/m32r/include/asm/barrier.h       |  80 +----------------
 arch/m68k/include/asm/barrier.h       |  14 +--
 arch/metag/include/asm/barrier.h      |  15 ++++
 arch/microblaze/include/asm/Kbuild    |   1 +
 arch/microblaze/include/asm/barrier.h |  27 ------
 arch/mips/include/asm/barrier.h       |  15 ++++
 arch/mn10300/include/asm/Kbuild       |   1 +
 arch/mn10300/include/asm/barrier.h    |  37 --------
 arch/parisc/include/asm/Kbuild        |   1 +
 arch/parisc/include/asm/barrier.h     |  35 --------
 arch/powerpc/include/asm/barrier.h    |  21 ++++-
 arch/s390/include/asm/barrier.h       |  15 ++++
 arch/score/include/asm/Kbuild         |   1 +
 arch/score/include/asm/barrier.h      |  16 ----
 arch/sh/include/asm/barrier.h         |  21 +----
 arch/sparc/include/asm/barrier_32.h   |  12 +--
 arch/sparc/include/asm/barrier_64.h   |  15 ++++
 arch/tile/include/asm/barrier.h       |  68 +-------------
 arch/unicore32/include/asm/barrier.h  |  11 +--
 arch/x86/include/asm/barrier.h        |  43 ++++++++-
 arch/xtensa/include/asm/barrier.h     |   9 +-
 include/asm-generic/barrier.h         |  55 +++++++++---
 include/linux/compiler.h              |   9 ++
 kernel/events/ring_buffer.c           |  62 +++++++------
 40 files changed, 444 insertions(+), 623 deletions(-)
