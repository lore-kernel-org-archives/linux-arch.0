From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH v4 2/7] kernel/locking: Fix compile error with qrwlock.c
Date: Wed, 24 May 2017 17:55:10 -0600
Message-ID: <1495670115-63960-3-git-send-email-babu.moger@oracle.com>
References: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32109 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033618AbdEXX4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 19:56:04 -0400
In-Reply-To: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, davem@davemloft.net
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com

Saw these compile errors on SPARC when queued rwlock feature is enabled.

 CC      kernel/locking/qrwlock.o
kernel/locking/qrwlock.c: In function ‘queued_read_lock_slowpath’:
kernel/locking/qrwlock.c:89: error: implicit declaration of function ‘arch_spin_lock’
kernel/locking/qrwlock.c:102: error: implicit declaration of function ‘arch_spin_unlock’
make[4]: *** [kernel/locking/qrwlock.o] Error 1

Include spinlock.h in qrwlock.c to fix it.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 kernel/locking/qrwlock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0c..2655f26 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/spinlock.h>
 #include <asm/qrwlock.h>
 
 /*
-- 
1.7.1
