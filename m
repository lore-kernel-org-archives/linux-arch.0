From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/47] x86: Hpet: Fix bogus error check in hpet_assign_irq()
Date: Thu, 30 Sep 2010 23:14:40 -0000
Message-ID: <20100930221738.674120334@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
	filename=x86-hpet-fix-bogus-error-check-in-hpet_assign_irq.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>, Venkatesh Pallipadi <venki@google.com>, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

create_irq() returns -1 if the interrupt allocation failed, but the
code checks for irq == 0.

Use create_irq_nr() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Venkatesh Pallipadi <venki@google.com>
LKML-Reference: <alpine.LFD.2.00.1009282310360.2416@localhost6.localdomain6>
Cc: stable@kernel.org
---
 arch/x86/kernel/hpet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/x86/kernel/hpet.c
===================================================================
--- linux-2.6-tip.orig/arch/x86/kernel/hpet.c
+++ linux-2.6-tip/arch/x86/kernel/hpet.c
@@ -506,7 +506,7 @@ static int hpet_assign_irq(struct hpet_d
 {
 	unsigned int irq;
 
-	irq = create_irq();
+	irq = create_irq_nr(0, -1);
 	if (!irq)
 		return -EINVAL;
 
