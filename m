From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 34/38] procfs: display the protection-key number associated with a vma
Date: Wed,  5 Jul 2017 14:22:11 -0700
Message-ID: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

Display the pkey number associated with the vma in smaps of a task.
The key will be seen as below:

ProtectionKey: 0

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kernel/setup_64.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f35ff9d..ebc82b3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -37,6 +37,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/nmi.h>
+#include <linux/pkeys.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
 }
 early_initcall(disable_hardlockup_detector);
 #endif
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
+{
+	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
-- 
1.7.1
