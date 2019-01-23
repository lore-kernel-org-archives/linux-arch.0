From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] locking/qspinlock: Handle > 4 nesting levels
Date: Tue, 22 Jan 2019 22:49:07 -0500
Message-ID: <1548215351-18896-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

 v2:
  - Use the simple trylock loop as suggested by PeterZ.

The current allows up to 4 levels of nested slowpath spinlock calls.
That should be enough for the process, soft irq, hard irq, and nmi.
With the unfortunate event of nested NMIs happening with slowpath
spinlock call in each of the previous level, we are going to run out
of useable MCS node for queuing.

In this case, we fall back to a simple TAS lock and spin on the lock
cacheline until the lock is free. This is not most elegant solution
but is simple enough.

Patch 1 implements the TAS loop when all the existing MCS nodes are
occupied.

Patches 2-4 enhances the locking statistics code to track the new code
as well as enabling it on other architectures such as ARM64.

By setting MAX_NODES to 1, we can have some usage of the new code path
during the booting process as demonstrated by the stat counter values
shown below on an 1-socket 22-core 44-thread x86-64 system after booting
up the new kernel.

  lock_no_node=20
  lock_pending=29660
  lock_slowpath=172714

Waiman Long (4):
  locking/qspinlock: Handle > 4 slowpath nesting levels
  locking/qspinlock_stat: Track the no MCS node available case
  locking/qspinlock_stat: Separate out the PV specific stat counts
  locking/qspinlock_stat: Allow QUEUED_LOCK_STAT for all archs

 arch/Kconfig                    |   7 ++
 arch/x86/Kconfig                |   8 ---
 kernel/locking/qspinlock.c      |  18 ++++-
 kernel/locking/qspinlock_stat.h | 150 +++++++++++++++++++++++++---------------
 4 files changed, 120 insertions(+), 63 deletions(-)

-- 
1.8.3.1
