Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:45609 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbEKPw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 11:52:59 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 11 May 2015 16:52:57 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 12/15] futex: clarify that preemption doesn't have to be disabled
Date: Mon, 11 May 2015 17:52:17 +0200
Message-ID: <1431359540-32227-13-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
Message-ID: <20150511155217.fP_7DuOK9ayZxUUQGF-d0LX33S7vFXIhTPV1oo-25is@z>

As arm64 and arc have no special implementations for !CONFIG_SMP, mutual
exclusion doesn't seem to rely on preemption.

Let's make it clear in the comments that preemption doesn't have to be
disabled when accessing user space in the futex code, so we can remove
preempt_disable() from pagefault_disable().

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/arc/include/asm/futex.h   | 10 +++++-----
 arch/arm64/include/asm/futex.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/futex.h b/arch/arc/include/asm/futex.h
index 4dc64dd..05b5aaf 100644
--- a/arch/arc/include/asm/futex.h
+++ b/arch/arc/include/asm/futex.h
@@ -53,7 +53,7 @@ static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	pagefault_disable();	/* implies preempt_disable() */
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -75,7 +75,7 @@ static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();	/* subsumes preempt_enable() */
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
@@ -104,7 +104,7 @@ static inline int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
 	return ret;
 }
 
-/* Compare-xchg with preemption disabled.
+/* Compare-xchg with pagefaults disabled.
  *  Notes:
  *      -Best-Effort: Exchg happens only if compare succeeds.
  *          If compare fails, returns; leaving retry/looping to upper layers
@@ -121,7 +121,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	pagefault_disable();	/* implies preempt_disable() */
+	pagefault_disable();
 
 	/* TBD : can use llock/scond */
 	__asm__ __volatile__(
@@ -142,7 +142,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval,
 	: "r"(oldval), "r"(newval), "r"(uaddr), "ir"(-EFAULT)
 	: "cc", "memory");
 
-	pagefault_enable();	/* subsumes preempt_enable() */
+	pagefault_enable();
 
 	*uval = val;
 	return val;
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 5f750dc..74069b3 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -58,7 +58,7 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
-	pagefault_disable();	/* implies preempt_disable() */
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -85,7 +85,7 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();	/* subsumes preempt_enable() */
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
-- 
2.1.4

