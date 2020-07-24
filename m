From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 0/6] powerpc: queued spinlocks and rwlocks
Date: Fri, 24 Jul 2020 23:14:17 +1000
Message-ID: <20200724131423.1362108-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
Sender: kvm-ppc-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Updated with everybody's feedback (thanks all), and more performance
results.

What I've found is I might have been measuring the worst load point for
the paravirt case, and by looking at a range of loads it's clear that
queued spinlocks are overall better even on PV, doubly so when you look
at the generally much improved worst case latencies.

I have defaulted it to N even though I'm less concerned about the PV
numbers now, just because I think it needs more stress testing. But
it's very nicely selectable so should be low risk to include.

All in all this is a very cool technology and great results especially
on the big systems but even on smaller ones there are nice gains. Thanks
Waiman and everyone who developed it.

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/pseries: move some PAPR paravirt functions to their own file
  powerpc: move spinlock implementation to simple_spinlock
  powerpc/64s: implement queued spinlocks and rwlocks
  powerpc/pseries: implement paravirt qspinlocks for SPLPAR
  powerpc/qspinlock: optimised atomic_try_cmpxchg_lock that adds the
    lock hint
  powerpc: implement smp_cond_load_relaxed

 arch/powerpc/Kconfig                          |  15 +
 arch/powerpc/include/asm/Kbuild               |   1 +
 arch/powerpc/include/asm/atomic.h             |  28 ++
 arch/powerpc/include/asm/barrier.h            |  14 +
 arch/powerpc/include/asm/paravirt.h           |  87 +++++
 arch/powerpc/include/asm/qspinlock.h          |  91 ++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |   7 +
 arch/powerpc/include/asm/simple_spinlock.h    | 288 ++++++++++++++++
 .../include/asm/simple_spinlock_types.h       |  21 ++
 arch/powerpc/include/asm/spinlock.h           | 308 +-----------------
 arch/powerpc/include/asm/spinlock_types.h     |  17 +-
 arch/powerpc/lib/Makefile                     |   3 +
 arch/powerpc/lib/locks.c                      |  12 +-
 arch/powerpc/platforms/pseries/Kconfig        |   9 +-
 arch/powerpc/platforms/pseries/setup.c        |   4 +-
 include/asm-generic/qspinlock.h               |   4 +
 16 files changed, 588 insertions(+), 321 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock.h
 create mode 100644 arch/powerpc/include/asm/simple_spinlock_types.h

-- 
2.23.0
