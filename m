Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34217 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbdEYI3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 04:29:09 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] watchdog: remove unused declaration
Date: Thu, 25 May 2017 18:28:53 +1000
Message-ID: <20170525082856.21685-2-npiggin@gmail.com>
In-Reply-To: <20170525082856.21685-1-npiggin@gmail.com>
References: <20170525082856.21685-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170525082853.09kUq_K4BmRiv4o_kVrIWK6U1AgcCmCR0ND2voDai7E@z>

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
