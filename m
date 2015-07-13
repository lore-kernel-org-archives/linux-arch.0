From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/5] Add generic support for relaxed atomics
Date: Mon, 13 Jul 2015 13:31:22 +0100
Message-ID: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hello,

This patch series adds support for a family of relaxed atomics to the
kernel. More specifically:

  - acquire/release/relaxed flavours of xchg, cmpxchg and {add,sub}_return
  - atomic_read_acquire
  - atomic_set_release

This came out of a separate patch series porting the (barrier-heavy)
qrwlock code to arm64. Rather than have arch-specific hooks littered
around the place, it makes more sense to define a core set of relaxed
atomics that can be used regardless of architecture.

For now, the definitions simply take on the existing (i.e. full-barrier)
semantics, but there is a direct mapping onto arm64 and even architectures
with explicit memory barrier instructions (e.g. powerpc, arm) can benefit,
as they do from the existing smp_load_acquire/smp_store_release macros.

The final patch is a proof-of-concept port of the qrwlock over to the
new atomics. It's based on some of the pending patches from me and Waiman,
so it won't apply to mainline but I think it illustrates the usage well
enough.

All feedback welcome,

Will

--->8

Will Deacon (5):
  atomics: add acquire/release/relaxed variants of some atomic
    operations
  asm-generic: rework atomic-long.h to avoid bulk code duplication
  asm-generic: add relaxed/acquire/release variants for atomic_long_t
  lockref: remove homebrew cmpxchg64_relaxed macro definition
  locking/qrwlock: make use of acquire/release/relaxed atomics

 Documentation/atomic_ops.txt      |   4 +-
 include/asm-generic/atomic-long.h | 263 ++++++++++++++------------------------
 include/asm-generic/qrwlock.h     |  13 +-
 include/linux/atomic.h            | 140 ++++++++++++++++++++
 kernel/locking/qrwlock.c          |  12 +-
 lib/lockref.c                     |   8 --
 6 files changed, 248 insertions(+), 192 deletions(-)

-- 
2.1.4
