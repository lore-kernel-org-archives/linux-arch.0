Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33199 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbdGEVXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 17:23:13 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 18/38] powerpc: store and restore the pkey state across context switches
Date: Wed,  5 Jul 2017 14:21:55 -0700
Message-ID: <1499289735-14220-19-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170705212155.s5exoePS2_Eeb7fJOU-m5nhP_SxSXMkBRyKvVynCW6o@z>

Store and restore the AMR, IAMR and UMOR register state of the task
before scheduling out and after scheduling in, respectively.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/processor.h |    5 +++++
 arch/powerpc/kernel/process.c        |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index a2123f2..1f714df 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -310,6 +310,11 @@ struct thread_struct {
 	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
 	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	unsigned long	amr;
+	unsigned long	iamr;
+	unsigned long	uamor;
+#endif
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index baae104..37d001a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1096,6 +1096,11 @@ static inline void save_sprs(struct thread_struct *t)
 		t->tar = mfspr(SPRN_TAR);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	t->amr = mfspr(SPRN_AMR);
+	t->iamr = mfspr(SPRN_IAMR);
+	t->uamor = mfspr(SPRN_UAMOR);
+#endif
 }
 
 static inline void restore_sprs(struct thread_struct *old_thread,
@@ -1131,6 +1136,14 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (old_thread->amr != new_thread->amr)
+		mtspr(SPRN_AMR, new_thread->amr);
+	if (old_thread->iamr != new_thread->iamr)
+		mtspr(SPRN_IAMR, new_thread->iamr);
+	if (old_thread->uamor != new_thread->uamor)
+		mtspr(SPRN_UAMOR, new_thread->uamor);
+#endif
 }
 
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -1686,6 +1699,11 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	current->thread.amr   = 0x0ul;
+	current->thread.iamr  = 0x0ul;
+	current->thread.uamor = 0x0ul;
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 }
 EXPORT_SYMBOL(start_thread);
 
-- 
1.7.1
