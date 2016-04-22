From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Fri, 22 Apr 2016 11:04:13 +0200
Message-ID: <20160422090413.393652501@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

As there have been a few requests for atomic_fetch_$op primitives and recently
by Linus, I figured I'd go and implement the lot.

The atomic_fetch_$op differs from the existing atomic_$op_return we already
have by returning the old value instead of the new value. This is especially
useful when the operation is irreversible (like bitops), and allows for things
like test-and-set.

I did these patches on the plane, without access to architecture documentation,
so mistakes are quite possible. However, I mostly started with the
atomic_$op_return implementation and modified those to return the old value,
which significantly decreases the creativity required.

The one that I did not do was ARMv8.1-LSE and I was hoping Will would help out
with that. Also, it looks like the 0-day built bot does not do arm64 builds,
people might want to look into that.

No known build breakage on the build-bot, boot tested on x86_64.

Notes:
 - tile might have a barrier issue
 - there are a few more archs that can be converted to _relaxed if they so care:
   arc metag tile

---
 arch/alpha/include/asm/atomic.h        |  89 ++++-
 arch/arc/include/asm/atomic.h          |  67 +++-
 arch/arm/include/asm/atomic.h          | 106 +++++-
 arch/arm64/include/asm/atomic.h        |  30 ++
 arch/arm64/include/asm/atomic_ll_sc.h  | 108 ++++--
 arch/avr32/include/asm/atomic.h        |  54 ++-
 arch/blackfin/include/asm/atomic.h     |   8 +
 arch/blackfin/kernel/bfin_ksyms.c      |   1 +
 arch/blackfin/mach-bf561/atomic.S      |  43 ++-
 arch/frv/include/asm/atomic.h          |  30 +-
 arch/frv/include/asm/atomic_defs.h     |   2 +
 arch/h8300/include/asm/atomic.h        |  29 +-
 arch/hexagon/include/asm/atomic.h      |  31 +-
 arch/ia64/include/asm/atomic.h         | 130 ++++++-
 arch/m32r/include/asm/atomic.h         |  36 +-
 arch/m68k/include/asm/atomic.h         |  51 ++-
 arch/metag/include/asm/atomic_lnkget.h |  36 +-
 arch/metag/include/asm/atomic_lock1.h  |  33 +-
 arch/mips/include/asm/atomic.h         | 154 +++++++-
 arch/mn10300/include/asm/atomic.h      |  33 +-
 arch/parisc/include/asm/atomic.h       |  63 +++-
 arch/powerpc/include/asm/atomic.h      |  83 ++++-
 arch/s390/include/asm/atomic.h         |  40 ++-
 arch/sh/include/asm/atomic-grb.h       |  34 +-
 arch/sh/include/asm/atomic-irq.h       |  31 +-
 arch/sh/include/asm/atomic-llsc.h      |  32 +-
 arch/sparc/include/asm/atomic_32.h     |  13 +-
 arch/sparc/include/asm/atomic_64.h     |  16 +-
 arch/sparc/lib/atomic32.c              |  29 +-
 arch/sparc/lib/atomic_64.S             |  61 +++-
 arch/sparc/lib/ksyms.c                 |  17 +-
 arch/tile/include/asm/atomic.h         |   2 +
 arch/tile/include/asm/atomic_32.h      |  60 +++-
 arch/tile/include/asm/atomic_64.h      | 117 ++++--
 arch/tile/include/asm/bitops_32.h      |  18 +-
 arch/tile/lib/atomic_32.c              |  42 +--
 arch/tile/lib/atomic_asm_32.S          |  14 +-
 arch/x86/include/asm/atomic.h          |  35 +-
 arch/x86/include/asm/atomic64_32.h     |  25 +-
 arch/x86/include/asm/atomic64_64.h     |  35 +-
 arch/xtensa/include/asm/atomic.h       |  52 ++-
 include/asm-generic/atomic-long.h      |  36 +-
 include/asm-generic/atomic.h           |  47 +++
 include/asm-generic/atomic64.h         |  15 +-
 include/linux/atomic.h                 | 627 ++++++++++++++++++++++++---------
 kernel/locking/qrwlock.c               |   2 +-
 kernel/locking/qspinlock_paravirt.h    |   4 +-
 kernel/time/tick-sched.c               |   4 +-
 lib/atomic64.c                         |  32 +-
 lib/atomic64_test.c                    |  34 ++
 50 files changed, 2181 insertions(+), 510 deletions(-)
