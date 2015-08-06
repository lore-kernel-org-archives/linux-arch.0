From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v5 0/8] Add generic support for relaxed atomics
Date: Thu,  6 Aug 2015 17:54:36 +0100
Message-ID: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi all,

Here is version five of the patches previously posted here:

  v1: https://lwn.net/Articles/650862/
  v2: https://lwn.net/Articles/651293/
  v3: https://lwn.net/Articles/652369/
  v4: https://lwn.net/Articles/653388/

The series adds support for a family of relaxed atomics to the kernel.
More specifically:

  - acquire/release/relaxed flavours of xchg, cmpxchg and {add,sub}_return
  - atomic_read_acquire
  - atomic_set_release

This came out of a separate patch series porting the (barrier-heavy)
qrwlock code to arm64. Rather than have arch-specific hooks littered
around the place, it makes more sense to define a core set of relaxed
atomics that can be used regardless of architecture.

Changes since v4 are:

  * Drop the ret_t macro parameter in favour of typeof tricks (Peter Z)

  * Add a missing acquire to the qrwlock code, as it was based on a
    previous patch that I posted (Waiman Long)

Build tested on ARM, arm64, PowerPC and x86.

All feedback welcome,

Will

--->8

Will Deacon (8):
  atomics: add acquire/release/relaxed variants of some atomic
    operations
  asm-generic: rework atomic-long.h to avoid bulk code duplication
  asm-generic: add relaxed/acquire/release variants for atomic_long_t
  lockref: remove homebrew cmpxchg64_relaxed macro definition
  locking/qrwlock: implement queue_write_unlock using smp_store_release
  locking/qrwlock: make use of acquire/release/relaxed atomics
  include/llist: use linux/atomic.h instead of asm/cmpxchg.h
  ARM: atomics: define our SMP atomics in terms of _relaxed operations

 arch/arm/include/asm/atomic.h     |  37 ++---
 arch/arm/include/asm/cmpxchg.h    |  47 +-----
 arch/x86/include/asm/qrwlock.h    |  10 --
 include/asm-generic/atomic-long.h | 263 +++++++++++--------------------
 include/asm-generic/qrwlock.h     |  22 +--
 include/linux/atomic.h            | 323 ++++++++++++++++++++++++++++++++++++++
 include/linux/llist.h             |   2 +-
 kernel/locking/qrwlock.c          |  22 ++-
 lib/lockref.c                     |   8 -
 9 files changed, 462 insertions(+), 272 deletions(-)

-- 
2.1.4
