From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RESEND PATCHv4 4/5] byteorder: fix direct byteswap includes
Date: Mon, 09 Jun 2008 16:19:42 -0700
Message-ID: <1213053582.5974.115.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:5075 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbYFIXTs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jun 2008 19:19:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2311701wfd.4
        for <linux-arch@vger.kernel.org>; Mon, 09 Jun 2008 16:19:48 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "tony.luck" <tony.luck@intel.com>, Russell King <rmk@arm.linux.org.uk>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/media/dvb/ttpci/av7110.c       |    2 +-
 drivers/media/video/cx18/cx18-driver.h |    2 +-
 drivers/media/video/ivtv/ivtv-driver.h |    2 +-
 drivers/media/video/vpx3220.c          |    2 +-
 kernel/rcupreempt.c                    |    2 +-
 kernel/rcutorture.c                    |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 747e7f1..c9e94b9 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -36,7 +36,6 @@
 #include <linux/fs.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/smp_lock.h>
 
 #include <linux/kernel.h>
@@ -52,6 +51,7 @@
 #include <linux/i2c.h>
 #include <linux/kthread.h>
 
+#include <asm/byteorder.h>
 #include <asm/system.h>
 
 #include <linux/dvb/frontend.h>
diff --git a/drivers/media/video/cx18/cx18-driver.h b/drivers/media/video/cx18/cx18-driver.h
index a2a6c58..49076c0 100644
--- a/drivers/media/video/cx18/cx18-driver.h
+++ b/drivers/media/video/cx18/cx18-driver.h
@@ -38,10 +38,10 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/list.h>
 #include <linux/unistd.h>
-#include <linux/byteorder/swab.h>
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
+#include <asm/byteorder.h>
 
 #include <linux/dvb/video.h>
 #include <linux/dvb/audio.h>
diff --git a/drivers/media/video/ivtv/ivtv-driver.h b/drivers/media/video/ivtv/ivtv-driver.h
index ba06e81..4e779c7 100644
--- a/drivers/media/video/ivtv/ivtv-driver.h
+++ b/drivers/media/video/ivtv/ivtv-driver.h
@@ -49,11 +49,11 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/list.h>
 #include <linux/unistd.h>
-#include <linux/byteorder/swab.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
+#include <asm/byteorder.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index 3529302..5920a9e 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -24,7 +24,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-#include <linux/byteorder/swab.h>
+#include <asm/byteorder.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff --git a/kernel/rcupreempt.c b/kernel/rcupreempt.c
index e1cdf19..02afa9d 100644
--- a/kernel/rcupreempt.c
+++ b/kernel/rcupreempt.c
@@ -54,9 +54,9 @@
 #include <linux/cpu.h>
 #include <linux/random.h>
 #include <linux/delay.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/cpumask.h>
 #include <linux/rcupreempt_trace.h>
+#include <asm/byteorder.h>
 
 /*
  * Macro that prevents the compiler from reordering accesses, but does
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 33acc42..e50ec0d 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -42,10 +42,10 @@
 #include <linux/freezer.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
-#include <linux/byteorder/swabb.h>
 #include <linux/stat.h>
 #include <linux/srcu.h>
 #include <linux/slab.h>
+#include <asm/byteorder.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and "
-- 
1.5.6.rc0.277.g804cf
