From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH/RFC] headers: drop 2 #included headers from
 <linux/interrupt.h>
Date: Thu, 15 Feb 2018 16:49:45 -0800
Message-ID: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

It seems that <linux/interrupt.h> does not need <linux/linkage.h>
nor <linux/preempt.h>.  8 kernels builds are successful without
these 2 headers (allmodconfig, allyesconfig, allnoconfig, and
tinyconfig on both i386 and x86_64).

<linux/interrupt.h> is #included 3875 times in 4.16-rc1, so this
reduces #include processing of these 2 files by a total of 7750 times.

Since I only tested x86 builds, this needs to be tested on other
$ARCHes as well.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---

Does anyone know or see why <linux/interrupt.h> needs <linux/linkage.h> or
<linux/preempt.h>?  There are no direct uses in <linux/interrupt.h> AFAICT.

 include/linux/interrupt.h |    2 --
 1 file changed, 2 deletions(-)

--- lnx-416-rc1.orig/include/linux/interrupt.h
+++ lnx-416-rc1/include/linux/interrupt.h
@@ -4,9 +4,7 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/kernel.h>
-#include <linux/linkage.h>
 #include <linux/bitops.h>
-#include <linux/preempt.h>
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
