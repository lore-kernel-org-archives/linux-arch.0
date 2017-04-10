Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:38560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752940AbdDJVf0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Apr 2017 17:35:26 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
Date: Tue, 11 Apr 2017 01:35:02 +0400
Message-ID: <1491860104-4103-2-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>
Message-ID: <20170410213502.B6pGWsOKywG7Yw2Mkw8oVSGfaYwLW9E6LgNQ8L6yqfI@z>

qrwlock.c calls arch_spin_lock() and arch_spin_unlock() but doesn't
include the asm/spinlock.h, where those functions are defined. It
may produce "implicit declaration of function" errors. This patch
fixes it.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/locking/qrwlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0c..6fb4292 100644
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
2.7.4
