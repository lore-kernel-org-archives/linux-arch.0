From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/9] locking/qrwlock: get qrwlocks up and running on arm64
Date: Tue,  7 Jul 2015 18:24:16 +0100
Message-ID: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50324 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757636AbbGGRZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:25:07 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, peterz@infradead.org, mingo@redhat.com, Will Deacon <will.deacon@arm.com>

Hi all,

This patch series gently massages the qrwlock code so as to make it
usable on arm64 as a replacement for our current implementation. The
last two patches actually do the arch conversion and are included here
for reference.

Most of the work is removing redundant memory barriers from the current
implementation and adding hooks to the contended paths to allow us to
avoid busy-waiting.

Implemented on top of -tip (i.e. the patches queued there from Waiman),
but this is likely to conflict with his latest series.

All feedback welcome,

Will

--->8

Will Deacon (9):
  locking/qrwlock: include <linux/spinlock.h> for
    arch_spin_{lock,unlock}
  locking/qrwlock: avoid redundant atomic_add_return on
    read_lock_slowpath
  locking/qrwlock: tidy up rspin_until_writer_unlock
  locking/qrwlock: implement queue_write_unlock using smp_store_release
  locking/qrwlock: remove redundant cmpxchg barriers on writer slow-path
  locking/qrwlock: allow architectures to hook in to contended paths
  locking/qrwlock: expose internal lock structure in qrwlock definition
  arm64: cmpxchg: implement cmpxchg_relaxed
  arm64: locking: replace read/write locks with generic qrwlock code

 arch/arm64/Kconfig                      |   1 +
 arch/arm64/include/asm/cmpxchg.h        |   6 +-
 arch/arm64/include/asm/qrwlock.h        |  30 ++++++++
 arch/arm64/include/asm/spinlock.h       | 122 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |  10 +--
 arch/x86/include/asm/qrwlock.h          |  10 ---
 include/asm-generic/qrwlock.h           |  11 ++-
 include/asm-generic/qrwlock_types.h     |  17 ++++-
 kernel/locking/qrwlock.c                |  60 +++++++---------
 9 files changed, 81 insertions(+), 186 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h

-- 
2.1.4
