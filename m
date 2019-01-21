From: Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] locking/qspinlock: Safely handle > 4 nesting levels
Date: Sun, 20 Jan 2019 21:49:49 -0500
Message-ID: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

My first thought of making qspinlocks to handle more than 4 slowpath
nesting levels to to use lock stealing when no more MCS nodes are
available. That is easy for PV qspinlocks as lock stealing is supported.
For native qspinlocks, we have to make setting the locked bit an atomic
operation which will add to slowpath lock acquisition latency. Using
my locking microbenchmark, I saw up to 10% reduction in the locking
throughput in some cases.

So we need to use a different technique in order to allow more than 4
slowpath nesting levels without introducing any noticeable performance
degradation for native qspinlocks. I settled on adding a new waiting
bit to the lock word to allow a CPU running out of percpu MCS nodes
to insert itself into the waiting queue using the new waiting bit for
synchronization. See patch 1 for details of how all this works.

Patches 2-4 enhances the locking statistics code to track the new code
as well as enabling it on other architectures such as ARM64.

Patch 5 is optional and it adds some debug code for testing purposes.

By setting MAX_NODES to 1, we can have some usage of the new code path
during the booting process as demonstrated by the stat counter values
shown below on an 1-socket 22-core 44-thread x86-64 system after booting
up the new kernel.

  lock_no_node=34
  lock_pending=30027
  lock_slowpath=173174
  lock_waiting=8

The new kernel was booted up a dozen times without seeing any problem.

Similar bootup test was done on a 2-socket 56-core 224-thread ARM64 system
with the following stat counter values.

  lock_no_node=21
  lock_pending=70245
  lock_slowpath=132703
  lock_waiting=3

No problem was seen in the ARM64 system with the new kernel. The number
of instances where 2-level spinlock slowpath nesting happens is less
frequent in the ARM64 system than in the x86-64 system.

Waiman Long (5):
  locking/qspinlock: Safely handle > 4 nesting levels
  locking/qspinlock_stat: Track the no MCS node available case
  locking/qspinlock_stat: Separate out the PV specific stat counts
  locking/qspinlock_stat: Allow QUEUED_LOCK_STAT for all archs
  locking/qspinlock: Add some locking debug code

 arch/Kconfig                          |   7 ++
 arch/x86/Kconfig                      |   8 --
 include/asm-generic/qspinlock_types.h |  41 +++++--
 kernel/locking/qspinlock.c            | 212 +++++++++++++++++++++++++++++++---
 kernel/locking/qspinlock_paravirt.h   |  30 ++++-
 kernel/locking/qspinlock_stat.h       | 153 +++++++++++++++---------
 6 files changed, 362 insertions(+), 89 deletions(-)

-- 
1.8.3.1
