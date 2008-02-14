Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:49928 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753437AbYBNPjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Feb 2008 10:39:14 -0500
From: =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>
Subject: [PATCH 12/14] fs/binfmt_aout.c: Use time_* macros
Date: Thu, 14 Feb 2008 17:36:50 +0200
Message-Id: <1203003412-11594-13-git-send-email-caglar@pardus.org.tr>
In-Reply-To: y
References: y
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>

The functions time_before, time_before_eq, time_after, and time_after_eq are more robust for comparing jiffies against other values.

So following patch implements usage of the time_after() macro, defined at linux/jiffies.h, which deals with wrapping correctly

Cc: linux-arch@vger.kernel.org
Signed-off-by: S.Çağlar Onur <caglar@pardus.org.tr>
---
 fs/binfmt_aout.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index a1bb224..72757fe 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -6,6 +6,7 @@
 
 #include <linux/module.h>
 
+#include <linux/jiffies.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -374,14 +375,14 @@ static int load_aout_binary(struct linux_binprm * bprm, struct pt_regs * regs)
 	} else {
 		static unsigned long error_time, error_time2;
 		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) != NMAGIC) && (jiffies-error_time2) > 5*HZ)
+		    (N_MAGIC(ex) != NMAGIC) && time_after(jiffies, error_time2 + 5 * HZ))
 		{
 			printk(KERN_NOTICE "executable not page aligned\n");
 			error_time2 = jiffies;
 		}
 
 		if ((fd_offset & ~PAGE_MASK) != 0 &&
-		    (jiffies-error_time) > 5*HZ)
+		    time_after(jiffies, error_time + 5 * HZ))
 		{
 			printk(KERN_WARNING 
 			       "fd_offset is not page aligned. Please convert program: %s\n",
@@ -498,7 +499,7 @@ static int load_aout_library(struct file *file)
 		static unsigned long error_time;
 		loff_t pos = N_TXTOFF(ex);
 
-		if ((jiffies-error_time) > 5*HZ)
+		if (time_after(jiffies ,error_time + 5 * HZ))
 		{
 			printk(KERN_WARNING 
 			       "N_TXTOFF is not page aligned. Please convert library: %s\n",
-- 
1.5.3.7

