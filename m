Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:52640 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbEKPwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 11:52:54 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 11 May 2015 16:52:52 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 08/15] futex: UP futex_atomic_op_inuser() relies on disabled preemption
Date: Mon, 11 May 2015 17:52:13 +0200
Message-ID: <1431359540-32227-9-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
Message-ID: <20150511155213.G-m9FlJP_uO9lgwhMpKqifcgZpZ1CA3xO-XfKCouWYY@z>

Let's explicitly disable/enable preemption in the !CONFIG_SMP version
of futex_atomic_op_inuser, to prepare for pagefault_disable() not
touching preemption anymore.

Otherwise we might break mutual exclusion when relying on a get_user()/
put_user() implementation.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 include/asm-generic/futex.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index b59b5a5..3586017 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -8,8 +8,7 @@
 #ifndef CONFIG_SMP
 /*
  * The following implementation only for uniprocessor machines.
- * For UP, it's relies on the fact that pagefault_disable() also disables
- * preemption to ensure mutual exclusion.
+ * It relies on preempt_disable() ensuring mutual exclusion.
  *
  */
 
@@ -38,6 +37,7 @@ futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
+	preempt_disable();
 	pagefault_disable();
 
 	ret = -EFAULT;
@@ -72,6 +72,7 @@ futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 
 out_pagefault_enable:
 	pagefault_enable();
+	preempt_enable();
 
 	if (ret == 0) {
 		switch (cmp) {
-- 
2.1.4

