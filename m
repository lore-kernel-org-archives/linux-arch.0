From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/7] Add generic support for relaxed atomics
Date: Thu, 16 Jul 2015 16:32:31 +0100
Message-ID: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lwn.net/Articles/650862/

The series adds support for a family of relaxed atomics to the kernel.
More specifically:

  - acquire/release/relaxed flavours of xchg, cmpxchg and {add,sub}_return
  - atomic_read_acquire
  - atomic_set_release

This came out of a separate patch series porting the (barrier-heavy)
qrwlock code to arm64. Rather than have arch-specific hooks littered
around the place, it makes more sense to define a core set of relaxed
atomics that can be used regardless of architecture.

Changes since v1 include:

  - Added macros to construct acquire/release/fence variants from a
    relaxed variant + barrier macros

  - Ported ARM as a proof of concept (with a negative diffstat!)

Build tested on ARM, arm64, PowerPC and x86.

All feedback welcome,

Will

--->8

Will Deacon (7):
  atomics: add acquire/release/relaxed variants of some atomic
    operations
  asm-generic: rework atomic-long.h to avoid bulk code duplication
  asm-generic: add relaxed/acquire/release variants for atomic_long_t
  lockref: remove homebrew cmpxchg64_relaxed macro definition
  locking/qrwlock: make use of acquire/release/relaxed atomics
  include/llist: use linux/atomic.h instead of asm/cmpxchg.h
  ARM: atomics: define our SMP atomics in terms of _relaxed operations

 arch/arm/include/asm/atomic.h     |  37 ++---
 arch/arm/include/asm/cmpxchg.h    |  47 +-----
 include/asm-generic/atomic-long.h | 263 ++++++++++++--------------------
 include/asm-generic/qrwlock.h     |  13 +-
 include/linux/atomic.h            | 312 ++++++++++++++++++++++++++++++++++++++
 include/linux/llist.h             |   2 +-
 kernel/locking/qrwlock.c          |  12 +-
 lib/lockref.c                     |   8 -
 8 files changed, 442 insertions(+), 252 deletions(-)

-- 
2.1.4
