From: Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking/qspinlock: Allow lock to store lock holder cpu number
Date: Sat, 11 Jul 2020 14:21:26 -0400
Message-ID: <20200711182128.29130-1-longman@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726281AbgGKSW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jul 2020 14:22:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>

This patchset modifies the qspinlock code to allow it to store the lock
holder cpu number in the lock itself if feasible for easier debugging
and crash dump analysis. This lock holder cpu information may also be
useful to architectures like PowerPC that needs the lock holder cpu
number for better paravirtual spinlock performance.

A new config option QUEUED_SPINLOCKS_CPUINFO is added. If this config
option is set, lock holder cpu number will always be stored if the
number is small enough.  Without this option, lock holder cpu number
will only be stored in the slowpath of the native qspinlock.

Waiman Long (2):
  locking/qspinlock: Store lock holder cpu in lock if feasible
  locking/pvqspinlock: Optionally store lock holder cpu into lock

 arch/Kconfig                              | 12 ++++++
 arch/x86/include/asm/qspinlock_paravirt.h |  9 ++--
 include/asm-generic/qspinlock.h           | 13 ++++--
 include/asm-generic/qspinlock_types.h     |  5 +++
 kernel/locking/qspinlock.c                | 50 +++++++++++++++--------
 kernel/locking/qspinlock_paravirt.h       | 41 ++++++++++---------
 6 files changed, 87 insertions(+), 43 deletions(-)

-- 
2.18.1
