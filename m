From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 0/3] locking/qrwlock: More optimizations in qrwlock
Date: Fri, 19 Jun 2015 11:49:59 -0400
Message-ID: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:38008 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbbFSPvE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 11:51:04 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

v4->v5:
 - Add a new patch to rename function names to sync up to qspinlock
   naming convention.
 - Move the extended qrwlock structure to the header file as requested
   by Will Deacon so that it can also be used in the ARM's architecture
   specific code.

v3->v4:
 - Remove the unnecessary _QW_WMASK check in
   queue_read_lock_slowpath().

v2->v3:
 - Fix incorrect commit log message in patch 1.

v1->v2:
 - Add microbenchmark data for the second patch

This patch set contains 2 patches on qrwlock. The first one is to
optimize the interrupt context reader slowpath.  The second one is
to optimize the writer slowpath.


*** BLURB HERE ***

Waiman Long (3):
  locking/qrwlock: Rename functions to queued_*()
  locking/qrwlock: Better optimization for interrupt context readers
  locking/qrwlock: Don't contend with readers when setting _QW_WAITING

 arch/x86/include/asm/qrwlock.h      |    7 ++--
 include/asm-generic/qrwlock.h       |   58 +++++++++++++++++-----------------
 include/asm-generic/qrwlock_types.h |   18 ++++++++++-
 kernel/locking/qrwlock.c            |   29 ++++++++---------
 4 files changed, 63 insertions(+), 49 deletions(-)
