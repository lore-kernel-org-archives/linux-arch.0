From: Waiman Long <longman@redhat.com>
Subject: [PATCH] x86, locking/spinlocks: Remove paravirt_ticketlocks_enabled
Date: Thu, 12 Jan 2017 10:17:16 -0500
Message-ID: <1484234236-12976-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

This is a follow-up of commit cfd8983f03c7b2 ("x86, locking/spinlocks:
Remove ticket (spin)lock implementation"). The static_key structure
paravirt_ticketlocks_enabled is now removed as it is no longer used.

A simple build and boot test was done to verify it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/spinlock.h      | 3 ---
 arch/x86/kernel/kvm.c                | 1 -
 arch/x86/kernel/paravirt-spinlocks.c | 3 ---
 arch/x86/xen/spinlock.c              | 1 -
 4 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 921bea7..6d39190 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -23,9 +23,6 @@
 /* How long a lock should spin before we consider blocking */
 #define SPIN_THRESHOLD	(1 << 15)
 
-extern struct static_key paravirt_ticketlocks_enabled;
-static __always_inline bool static_key_false(struct static_key *key);
-
 #include <asm/qspinlock.h>
 
 /*
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 36bc664..6750fdc 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -627,7 +627,6 @@ static __init int kvm_spinlock_init_jump(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return 0;
 
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
 	printk(KERN_INFO "KVM setup paravirtual spinlock\n");
 
 	return 0;
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 6d4bf81..6259327 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -42,6 +42,3 @@ struct pv_lock_ops pv_lock_ops = {
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
-
-struct static_key paravirt_ticketlocks_enabled = STATIC_KEY_INIT_FALSE;
-EXPORT_SYMBOL(paravirt_ticketlocks_enabled);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index e8a9ea7..a822606 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -155,7 +155,6 @@ static __init int xen_init_spinlocks_jump(void)
 	if (!xen_domain())
 		return 0;
 
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
 	return 0;
 }
 early_initcall(xen_init_spinlocks_jump);
-- 
1.8.3.1
