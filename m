Return-Path: <SRS0=2OaM=4Q=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 22:11:21 -0500
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] kallsyms: architecture specific symbol lookups
Date: Fri, 28 Feb 2020 13:10:26 +1000
Message-ID: <20200228031027.271510-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, skiboot@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200228031026.yW726XtfEaS5G1Fj6OoyUgXnC5jtzgGw64y-lDlqJS4@z>

Provide CONFIG_ARCH_HAS_ADDRESS_LOOKUP which allows architectures to
do their own symbol/address lookup if kernel and module lookups miss.

powerpc will use this to deal with firmware symbols.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/kallsyms.h | 20 ++++++++++++++++++++
 kernel/kallsyms.c        | 13 ++++++++++++-
 lib/Kconfig              |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 657a83b943f0..8fdd44873373 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -83,6 +83,26 @@ extern int kallsyms_lookup_size_offset(unsigned long addr,
 				  unsigned long *symbolsize,
 				  unsigned long *offset);
 
+#ifdef CONFIG_ARCH_HAS_ADDRESS_LOOKUP
+const char *arch_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf);
+unsigned long arch_address_lookup_name(const char *name);
+#else
+static inline const char *arch_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf)
+{
+	return NULL;
+}
+static inline unsigned long arch_address_lookup_name(const char *name)
+{
+	return 0;
+}
+#endif
+
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9b3f660dee7..580c762fadd8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -164,6 +164,7 @@ static unsigned long kallsyms_sym_address(int idx)
 unsigned long kallsyms_lookup_name(const char *name)
 {
 	char namebuf[KSYM_NAME_LEN];
+	unsigned long ret;
 	unsigned long i;
 	unsigned int off;
 
@@ -173,7 +174,12 @@ unsigned long kallsyms_lookup_name(const char *name)
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
 	}
-	return module_kallsyms_lookup_name(name);
+
+	ret = module_kallsyms_lookup_name(name);
+	if (ret)
+		return ret;
+
+	return arch_address_lookup_name(name);
 }
 EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
@@ -311,6 +317,11 @@ const char *kallsyms_lookup(unsigned long addr,
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
+
+	if (!ret)
+		ret = arch_address_lookup(addr, symbolsize,
+						offset, modname, namebuf);
+
 	return ret;
 }
 
diff --git a/lib/Kconfig b/lib/Kconfig
index bc7e56370129..16d3b8dbcadf 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -80,6 +80,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config ARCH_HAS_ADDRESS_LOOKUP
+	bool
+
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
-- 
2.23.0
