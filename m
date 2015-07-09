From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 00/24] arch: Provide atomic logic ops
Date: Thu, 09 Jul 2015 19:28:55 +0200
Message-ID: <20150709172855.564686637@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Currently there is an incoherent mess of atomic_{set,clear}_mask() and
atomic_or() (but no atomic_{and,nand,xor}()) in the tree.

Those archs that implement atomic_{set,clear}_mask() are not even consistent on
its signature.

Implement atomic_{or,and,xor}() on all archs and deprecate
atomic_{set,clear}_mask().

Notes:
 - FRV got a total rewrite of its atomic implementation,
 - Blackfin could use one, or at least some macro help,
 - TILE still needs to be done.

The series has been compile tested by the build-bot, only TILE fails to build.

---
 arch/alpha/include/asm/atomic.h        |    6 +
 arch/arc/include/asm/atomic.h          |    4 
 arch/arm/include/asm/atomic.h          |    6 +
 arch/arm64/include/asm/atomic.h        |    6 +
 arch/avr32/include/asm/atomic.h        |   12 ++
 arch/blackfin/include/asm/atomic.h     |   16 ++-
 arch/blackfin/kernel/bfin_ksyms.c      |    7 -
 arch/blackfin/mach-bf561/atomic.S      |   30 +++---
 arch/blackfin/mach-common/smp.c        |    2 
 arch/frv/include/asm/atomic.h          |  107 ++++++++++++------------
 arch/frv/include/asm/atomic_defs.h     |  143 +++++++++++++++++++++++++++++++++
 arch/frv/include/asm/bitops.h          |   99 ++--------------------
 arch/frv/kernel/dma.c                  |    6 -
 arch/frv/lib/Makefile                  |    2 
 arch/frv/lib/atomic-lib.c              |    7 +
 arch/frv/lib/atomic-ops.S              |  110 -------------------------
 arch/frv/lib/atomic64-ops.S            |   94 ---------------------
 arch/hexagon/include/asm/atomic.h      |    3 
 arch/ia64/include/asm/atomic.h         |   24 ++++-
 arch/m32r/include/asm/atomic.h         |   44 ----------
 arch/m32r/kernel/smp.c                 |    4 
 arch/m68k/include/asm/atomic.h         |   13 ---
 arch/metag/include/asm/atomic_lnkget.h |   37 --------
 arch/metag/include/asm/atomic_lock1.h  |   23 -----
 arch/mips/include/asm/atomic.h         |    6 +
 arch/mn10300/include/asm/atomic.h      |   70 ----------------
 arch/mn10300/mm/tlb-smp.c              |    2 
 arch/parisc/include/asm/atomic.h       |    6 +
 arch/powerpc/include/asm/atomic.h      |    6 +
 arch/powerpc/kernel/misc_32.S          |   19 ----
 arch/s390/include/asm/atomic.h         |   41 +++++----
 arch/s390/kernel/time.c                |    4 
 arch/s390/kvm/interrupt.c              |   28 +++---
 arch/s390/kvm/kvm-s390.c               |   24 ++---
 arch/sh/include/asm/atomic-grb.h       |   42 ---------
 arch/sh/include/asm/atomic-irq.h       |   21 ----
 arch/sh/include/asm/atomic-llsc.h      |   31 -------
 arch/sparc/include/asm/atomic_32.h     |    3 
 arch/sparc/include/asm/atomic_64.h     |    3 
 arch/sparc/lib/atomic32.c              |   22 ++++-
 arch/sparc/lib/atomic_64.S             |    6 +
 arch/sparc/lib/ksyms.c                 |    3 
 arch/x86/include/asm/atomic.h          |   25 +++--
 arch/x86/include/asm/atomic64_32.h     |   14 +++
 arch/x86/include/asm/atomic64_64.h     |   15 +++
 arch/xtensa/include/asm/atomic.h       |   72 ----------------
 drivers/gpu/drm/i915/i915_drv.c        |    2 
 drivers/gpu/drm/i915/i915_gem.c        |    2 
 drivers/gpu/drm/i915/i915_irq.c        |    4 
 drivers/s390/scsi/zfcp_aux.c           |    2 
 drivers/s390/scsi/zfcp_erp.c           |   62 +++++++-------
 drivers/s390/scsi/zfcp_fc.c            |    8 -
 drivers/s390/scsi/zfcp_fsf.c           |   26 +++---
 drivers/s390/scsi/zfcp_qdio.c          |   14 +--
 include/asm-generic/atomic.h           |   11 +-
 include/asm-generic/atomic64.h         |    3 
 include/linux/atomic.h                 |   30 +++---
 lib/atomic64.c                         |    3 
 58 files changed, 569 insertions(+), 866 deletions(-)
