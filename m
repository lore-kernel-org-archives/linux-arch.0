From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies on disabled preemption
Date: Mon, 11 May 2015 17:52:16 +0200
Message-ID: <1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

The !CONFIG_SMP implementation of futex_atomic_op_inuser() seems to rely
on disabled preemption to guarantee mutual exclusion.

From commit e589ed23dd27:
    "For UP it's enough to disable preemption to ensure mutual exclusion..."
From the code itself:
    "!SMP, we can work around lack of atomic ops by disabling preemption"

Let's make this explicit, to prepare for pagefault_disable() not
touching preemption anymore.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/arm/include/asm/futex.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 255bfd1..5eed828 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -127,7 +127,10 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
-	pagefault_disable();	/* implies preempt_disable() */
+#ifndef CONFIG_SMP
+	preempt_disable();
+#endif
+	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -149,7 +152,10 @@ futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();	/* subsumes preempt_enable() */
+	pagefault_enable();
+#ifndef CONFIG_SMP
+	preempt_enable();
+#endif
 
 	if (!ret) {
 		switch (cmp) {
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
