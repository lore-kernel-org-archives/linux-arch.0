Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34937 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755856AbeASBw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 20:52:59 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 26/27] mm, x86 : introduce arch_pkeys_enabled()
Date: Thu, 18 Jan 2018 17:50:47 -0800
Message-ID: <1516326648-22775-27-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20180119015047.8-f5FF_hisPjARPPn7FzpX2sK4vtDrb9P8KnxoYJ8oc@z>

Arch neutral code needs to know if the architecture supports
protection  keys  to  display protection key in smaps. Hence
introducing arch_pkeys_enabled().

This patch also provides x86 implementation for
arch_pkeys_enabled().

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/x86/include/asm/pkeys.h |    1 +
 arch/x86/kernel/fpu/xstate.c |    5 +++++
 include/linux/pkeys.h        |    5 +++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index a0ba1ff..f6c287b 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -6,6 +6,7 @@
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
+extern bool arch_pkeys_enabled(void);
 
 /*
  * Try to dedicate one of the protection keys to be used as an
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7..4f566e9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -945,6 +945,11 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 	return 0;
 }
+
+bool arch_pkeys_enabled(void)
+{
+	return boot_cpu_has(X86_FEATURE_OSPKE);
+}
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 /*
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 0794ca7..3ca2e44 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -35,6 +35,11 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return 0;
 }
 
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
 static inline void copy_init_pkru_to_fpregs(void)
 {
 }
-- 
1.7.1
