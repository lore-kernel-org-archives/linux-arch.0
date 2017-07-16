From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 37/62] x86: implementation for arch_pkeys_enabled()
Date: Sat, 15 Jul 2017 20:56:39 -0700
Message-ID: <1500177424-13695-38-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

arch_pkeys_enabled() returns true if the cpu
supports X86_FEATURE_OSPKE.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/x86/include/asm/pkeys.h |    1 +
 arch/x86/kernel/fpu/xstate.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index b3b09b9..fa82799 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -5,6 +5,7 @@
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
+extern bool arch_pkeys_enabled(void);
 
 /*
  * Try to dedicate one of the protection keys to be used as an
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c24ac1e..df594b8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -918,6 +918,11 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 	return 0;
 }
+
+bool arch_pkeys_enabled(void)
+{
+	return boot_cpu_has(X86_FEATURE_OSPKE);
+}
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 /*
-- 
1.7.1

