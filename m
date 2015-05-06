From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH RFC 09/15] futex: UP futex_atomic_cmpxchg_inatomic() relies on disabled preemption
Date: Wed,  6 May 2015 19:50:33 +0200
Message-ID: <1430934639-2131-10-git-send-email-dahi@linux.vnet.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Let's explicitly disable/enable preemption in the !CONFIG_SMP version
of futex_atomic_cmpxchg_inatomic, to prepare for pagefault_disable() not
touching preemption anymore. This is needed for this function to be
callable from both, atomic and non-atomic context.

Otherwise we might break mutual exclusion when relying on a get_user()/
put_user() implementation.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 include/asm-generic/futex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 3586017..e56272c 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -107,6 +107,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	u32 val;
 
+	preempt_disable();
 	if (unlikely(get_user(val, uaddr) != 0))
 		return -EFAULT;
 
@@ -114,6 +115,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		return -EFAULT;
 
 	*uval = val;
+	preempt_enable();
 
 	return 0;
 }
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
