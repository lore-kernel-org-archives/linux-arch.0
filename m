From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
Date: Wed,  3 May 2017 17:51:39 +0300
Message-ID: <20170503145141.4966-2-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:31520
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752013AbdECOwn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 May 2017 10:52:43 -0400
In-Reply-To: <20170503145141.4966-1-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

qrwlock.c calls arch_spin_lock() and arch_spin_unlock() but doesn't
include the asm/spinlock.h, where those functions are defined. It
may produce "implicit declaration of function" errors. This patch
fixes it.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/locking/qrwlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0ccdfa2..6fb42925b201 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <asm/spinlock.h>
 #include <asm/qrwlock.h>
 
 /*
-- 
2.11.0
