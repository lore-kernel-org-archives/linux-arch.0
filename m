From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH-tip v2 0/2] locking/qrwlock: Improve qrwlock performance
Date: Thu,  9 Jul 2015 12:32:21 -0400
Message-ID: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:1308 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbGIQcs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 12:32:48 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

v1->v2:
 - Take out patch 1 which had been merged to tip.
 - Take out patch 4 as the change may impact light load performance
 - Rebased to the latest tip branch

In converting some existing spinlocks to rwlock, it was found that
the write lock slowpath performance isn't as good as the qspinlock.
This patch series tries to improve qrwlock performance to close the
gap between qspinlock and qrwlock.

With this patch series in place, we can start converting some spinlocks
back to rwlocks where it makes sense and the lock size increase isn't
a concern.

Waiman Long (2):
  locking/qrwlock: Reduce reader/writer to reader lock transfer latency
  locking/qrwlock: Reduce writer to writer lock transfer latency

 kernel/locking/qrwlock.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)
