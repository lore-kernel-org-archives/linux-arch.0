From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH v2 2/7] arch/sparc: Remove the check #ifndef __LINUX_SPINLOCK_TYPES_H
Date: Fri, 19 May 2017 18:16:56 -0600
Message-ID: <1495239421-441642-3-git-send-email-babu.moger@oracle.com>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17639 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdETARt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 20:17:49 -0400
In-Reply-To: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Remove the un-necessary "ifndef __LINUX_SPINLOCK_TYPES_H" stanza from SPARC.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Suggested-by: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/spinlock_types.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/asm/spinlock_types.h
index 9c454fd..019c085 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -1,10 +1,6 @@
 #ifndef __SPARC_SPINLOCK_TYPES_H
 #define __SPARC_SPINLOCK_TYPES_H
 
-#ifndef __LINUX_SPINLOCK_TYPES_H
-# error "please don't include this file directly"
-#endif
-
 typedef struct {
 	volatile unsigned char lock;
 } arch_spinlock_t;
-- 
1.7.1
