Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32812 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3B1O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 21:27:14 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] watchdog: remove unused declaration
Date: Tue, 30 May 2017 11:26:56 +1000
Message-ID: <20170530012659.16791-2-npiggin@gmail.com>
In-Reply-To: <20170530012659.16791-1-npiggin@gmail.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170530012656.__P75w7FOrXT9-Wwdj9l66uf11D57O8qkH_73on8-tk@z>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/nmi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index aa3cd0878270..5e2e57536d98 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -12,9 +12,6 @@ extern void touch_softlockup_watchdog_sched(void);
 extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
-extern int proc_dowatchdog_thresh(struct ctl_table *table, int write,
-				  void __user *buffer,
-				  size_t *lenp, loff_t *ppos);
 extern unsigned int  softlockup_panic;
 extern unsigned int  hardlockup_panic;
 void lockup_detector_init(void);
-- 
2.11.0
