From: ralf@linux-mips.org
Subject: [patch 12/14] i8253: Move remaining content and delete <asm/i8253.h>
Date: Wed, 01 Jun 2011 19:05:08 +0100
Message-ID: <20110601180610.913463093@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline; filename=i8253-sort-remaining-definitions.patch
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

There is no really good other place but one line for two out of three
architectures that have a <asm/i8253.h> file doesn't justify this files
existence.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

 arch/arm/include/asm/i8253.h  |    4 ----
 arch/mips/include/asm/i8253.h |   10 ----------
 arch/mips/include/asm/time.h  |    5 +++++
 arch/x86/include/asm/i8253.h  |    6 ------
 arch/x86/include/asm/time.h   |    1 +
 include/linux/i8253.h         |    1 -
 6 files changed, 6 insertions(+), 21 deletions(-)

Index: linux-i8253/arch/x86/include/asm/i8253.h
===================================================================
--- linux-i8253.orig/arch/x86/include/asm/i8253.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_X86_I8253_H
-#define _ASM_X86_I8253_H
-
-extern void setup_pit_timer(void);
-
-#endif /* _ASM_X86_I8253_H */
Index: linux-i8253/include/linux/i8253.h
===================================================================
--- linux-i8253.orig/include/linux/i8253.h
+++ linux-i8253/include/linux/i8253.h
@@ -12,7 +12,6 @@
 #include <linux/param.h>
 #include <linux/spinlock.h>
 #include <linux/timex.h>
-#include <asm/i8253.h>
 
 /* i8253A PIT registers */
 #define PIT_MODE	0x43
Index: linux-i8253/arch/x86/include/asm/time.h
===================================================================
--- linux-i8253.orig/arch/x86/include/asm/time.h
+++ linux-i8253/arch/x86/include/asm/time.h
@@ -6,6 +6,7 @@
 
 extern void hpet_time_init(void);
 extern void time_init(void);
+extern void setup_pit_timer(void);
 
 extern struct clock_event_device *global_clock_event;
 
Index: linux-i8253/arch/mips/include/asm/i8253.h
===================================================================
--- linux-i8253.orig/arch/mips/include/asm/i8253.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- *  Machine specific IO port address definition for generic.
- *  Written by Osamu Tomita <tomita@cinet.co.jp>
- */
-#ifndef __ASM_I8253_H
-#define __ASM_I8253_H
-
-extern void setup_pit_timer(void);
-
-#endif /* __ASM_I8253_H */
Index: linux-i8253/arch/arm/include/asm/i8253.h
===================================================================
--- linux-i8253.orig/arch/arm/include/asm/i8253.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASMARM_I8253_H
-#define __ASMARM_I8253_H
-
-#endif
Index: linux-i8253/arch/mips/include/asm/time.h
===================================================================
--- linux-i8253.orig/arch/mips/include/asm/time.h
+++ linux-i8253/arch/mips/include/asm/time.h
@@ -36,6 +36,11 @@ extern int rtc_mips_set_mmss(unsigned lo
 extern void plat_time_init(void);
 
 /*
+ * Initialize i8253 / i8254 PIT clockevent device.
+ */
+extern void setup_pit_timer(void);
+
+/*
  * mips_hpt_frequency - must be set if you intend to use an R4k-compatible
  * counter as a timer interrupt source.
  */
