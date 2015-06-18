From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v4 0/2] locking/qrwlock: More optimizations in qrwlock
Date: Wed, 17 Jun 2015 22:20:21 -0400
Message-ID: <1434594023-43589-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

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

Waiman Long (2):
  locking/qrwlock: Better optimization for interrupt context readers
  locking/qrwlock: Don't contend with readers when setting _QW_WAITING

 include/asm-generic/qrwlock.h |    4 ++--
 kernel/locking/qrwlock.c      |   41 +++++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 12 deletions(-)
