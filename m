From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 0/3] arm64: queued spinlocks and rw-locks
Date: Wed,  3 May 2017 17:51:38 +0300
Message-ID: <20170503145141.4966-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:23131
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751118AbdECOwC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 May 2017 10:52:02 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

The patch 3 adds implementation for queued-based locking on
ARM64, and the option in kernel config to enable it. Patches
1 and 2 fix some mess in header files to apply patch 3 smoothly.

Tested on QDF2400 with huge improvements with these patches on
the torture tests, by Adam Wallis.

Tested on ThunderX, by Andrew Pinski:
120 thread (30 core - 4 thread/core) CN99xx (single socket):

benchmark               Units	qspinlocks vs ticket locks
sched/messaging		s	73.91%
sched/pipe		ops/s	104.18%
futex/hash		ops/s	103.87%
futex/wake		ms	71.04%
futex/wake-parallel	ms	93.88%
futex/requeue		ms	96.47%
futex/lock-pi		ops/s	118.33%

Notice, there's the queued locks implementation for the Power PC introduced
by Pan Xinhui. He largely tested it and also found significant performance
gain. In arch part it is very similar to this patch though.
https://lwn.net/Articles/701137/

RFC: https://www.spinics.net/lists/arm-kernel/msg575575.html
v1:
 - queued_spin_unlock_wait() and queued_spin_is_locked() are
   re-implemented in arch part to add additional memory barriers;
 - queued locks are made optional, ticket locks are enabled by default.

Jan Glauber (1):
  arm64/locking: qspinlocks and qrwlocks support

Yury Norov (2):
  kernel/locking: #include <asm/spinlock.h> in qrwlock.c
  asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h

 arch/arm64/Kconfig                      | 24 +++++++++++++++++++
 arch/arm64/include/asm/qrwlock.h        |  7 ++++++
 arch/arm64/include/asm/qspinlock.h      | 42 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/spinlock.h       | 12 ++++++++++
 arch/arm64/include/asm/spinlock_types.h | 14 ++++++++---
 arch/arm64/kernel/Makefile              |  1 +
 arch/arm64/kernel/qspinlock.c           | 34 ++++++++++++++++++++++++++
 include/asm-generic/qspinlock.h         |  1 +
 include/asm-generic/qspinlock_types.h   |  8 -------
 kernel/locking/qrwlock.c                |  1 +
 10 files changed, 133 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h
 create mode 100644 arch/arm64/include/asm/qspinlock.h
 create mode 100644 arch/arm64/kernel/qspinlock.c

-- 
2.11.0
