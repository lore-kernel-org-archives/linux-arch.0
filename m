From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
Date: Tue, 11 Apr 2017 01:35:01 +0400
Message-ID: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:33680
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751660AbdDJVfS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Apr 2017 17:35:18 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>

The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
latest kernel sources, and added a couple of fixes to headers to apply it 
smoothly.

Though, locktourture test shows significant performance degradation in the
acquisition of rw-lock for read on qemu:

                          Before           After
spin_lock-torture:      38957034        37076367         -4.83
rw_lock-torture W:       5369471        18971957        253.33
rw_lock-torture R:       6413179         3668160        -42.80

I'm  not much experienced in locking, and so wonder how it's possible that
simple switching to generic queued rw-lock causes so significant performance
degradation, while in theory it should improve it. Even more, on x86 there
are no such problems probably.

I also think that patches 1 and 2 are correct and useful, and should be applied
anyway.

Any comments appreciated.

Yury.

Jan Glauber (1):
  arm64/locking: qspinlocks and qrwlocks support

Yury Norov (2):
  kernel/locking: #include <asm/spinlock.h> in qrwlock.c
  asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h

 arch/arm64/Kconfig                      |  2 ++
 arch/arm64/include/asm/qrwlock.h        |  7 +++++++
 arch/arm64/include/asm/qspinlock.h      | 20 ++++++++++++++++++++
 arch/arm64/include/asm/spinlock.h       | 12 ++++++++++++
 arch/arm64/include/asm/spinlock_types.h | 14 +++++++++++---
 include/asm-generic/qspinlock.h         |  1 +
 include/asm-generic/qspinlock_types.h   |  8 --------
 kernel/locking/qrwlock.c                |  1 +
 8 files changed, 54 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h
 create mode 100644 arch/arm64/include/asm/qspinlock.h

-- 
2.7.4
