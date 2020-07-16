From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/5] x86, locking/qspinlock: Allow lock to store lock holder cpu number
Date: Thu, 16 Jul 2020 15:29:22 -0400
Message-ID: <20200716192927.12944-1-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

This patchset modifies the x86 qspinlock and qrwlock code to allow it to
store the lock holder cpu number (lock writer cpu number for qrwlock)
in the lock itself if feasible.  This lock holder cpu information is 
useful for debugging and crash dump analysis. It may also be useful to
architectures like PowerPC that needs the lock holder cpu number for
better paravirtual spinlock performance.

This capability is enabled on a per-architecture basis by defining
the macros __cpu_number_sadd1 (for qrwlock) and __cpu_number_sadd2
(for qspinlock). These macros define the architecture's way to get
to a percpu saturated +1 and +2 cpu number that can be used in the
lock byte of qspinlock and qrwlock.

This patchset enables it for the x86 architecture only. Additional
patches can be submitted later on to enable other architectures,
if desired.

I have run some locking microbenchmark with and without this patch. I
saw about 1% peformance degradation at low lock contention level, but
about 1% performance gain at high lock contention level. That slight
performance may be caused by a slight difference in the generated code
and may not be entirely due to the access of the percpu variable. Anyway,
that performance difference should be negligible for most real workloads.

Waiman Long (5):
  x86/smp: Add saturated +1/+2 1-byte cpu numbers
  locking/pvqspinlock: Make pvqsinlock code easier to read
  locking/qspinlock: Pass lock value as function argument
  locking/qspinlock: Make qspinhlock store lock holder cpu number
  locking/qrwlock: Make qrwlock store writer cpu number

 arch/x86/include/asm/qspinlock_paravirt.h | 42 +++++++++++------------
 arch/x86/include/asm/spinlock.h           |  5 +++
 arch/x86/kernel/setup_percpu.c            | 11 ++++++
 include/asm-generic/qrwlock.h             | 12 ++++++-
 include/asm-generic/qspinlock.h           | 10 ++++++
 include/asm-generic/qspinlock_types.h     |  2 +-
 kernel/locking/qrwlock.c                  | 11 +++---
 kernel/locking/qspinlock.c                | 31 ++++++++---------
 kernel/locking/qspinlock_paravirt.h       | 35 ++++++++++---------
 9 files changed, 97 insertions(+), 62 deletions(-)

-- 
2.18.1
