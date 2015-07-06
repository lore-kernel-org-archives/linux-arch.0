From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH 0/4] locking/qrwlock: Improve qrwlock performance
Date: Mon,  6 Jul 2015 11:43:02 -0400
Message-ID: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52]:40914 "EHLO
	g2t2353.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbGFPnW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2015 11:43:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

In converting some existing spinlocks to rwlock, it was found that the
write lock slowpath performance isn't as good as the qspinlock. With
a workload that added a large number of inodes to the superblock and
was rate-limited by the inode_sb_list_lock, converting that spinlock
into a write lock slowed down its performance from about 22s to 36s.

This patch series tries to squeeze out as much performance as possible
to close the performance gap between qspinlock and qrwlock. With
all that patches applies, the workload performance improves to about
24-25s which is much better than before, though still a bit slower
than the spinlock.

With this patch series in place, we can start converting some spinlocks
back to rwlocks where it makes sense and the lock size increase isn't
a concern.

Waiman Long (4):
  locking/qrwlock: Better optimization for interrupt context readers
  locking/qrwlock: Reduce reader/writer to reader lock transfer latency
  locking/qrwlock: Reduce writer to writer lock transfer latency
  locking/qrwlock: Use direct MCS lock/unlock in slowpath

 arch/x86/include/asm/qrwlock.h      |    4 +
 include/asm-generic/qrwlock.h       |    4 +-
 include/asm-generic/qrwlock_types.h |   26 ++++-
 kernel/locking/qrwlock.c            |  185 ++++++++++++++++++++++++++--------
 kernel/locking/qspinlock.c          |    9 +-
 5 files changed, 174 insertions(+), 54 deletions(-)
