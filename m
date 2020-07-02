From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/8] powerpc: queued spinlocks and rwlocks
Date: Thu,  2 Jul 2020 17:48:31 +1000
Message-ID: <20200702074839.1057733-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHsy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:48:54 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

This series adds an option to use queued spinlocks for powerpc, and
makes it the default for the Book3S-64 subarch.

This effort starts with the generic code so it's very simple but
still very performant. There are optimisations that can be made to
slowpaths, but I think it's better to attack those incrementally
if/when we find things, and try to add the improvements to generic
code as much as possible.

Still in the process of getting numbers and testing, but the
implementation turned out to be surprisingly simple and we have a
config option, so I think we could merge it fairly soon.

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/powernv: must include hvcall.h to get PAPR defines
  powerpc/pseries: use smp_rmb() in H_CONFER spin yield
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint
  powerpc/64s: remove paravirt from simple spinlocks (RFC only)

 arch/powerpc/Kconfig                          |  13 +
 arch/powerpc/include/asm/Kbuild               |   2 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/paravirt.h           |  84 +++++
 arch/powerpc/include/asm/qspinlock.h          |  75 +++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   5 +
 arch/powerpc/include/asm/simple_spinlock.h    | 235 +++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c           |   6 -
 arch/powerpc/lib/Makefile                     |   1 -
 arch/powerpc/lib/locks.c                      |  65 ----
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |   1 +
 arch/powerpc/platforms/pseries/Kconfig        |   5 +
 arch/powerpc/platforms/pseries/setup.c        |   6 +-
 include/asm-generic/qspinlock.h               |   4 +
 17 files changed, 488 insertions(+), 388 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h
 delete mode 100644 arch/powerpc/lib/locks.c

-- 
2.23.0
