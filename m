From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 5/9] x86: make sure _etext includes function sections
Date: Wed, 15 Apr 2020 14:04:47 -0700
Message-ID: <20200415210452.27436-6-kristen@linux.intel.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442230AbgDOVFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:51 -0400
In-Reply-To: <20200415210452.27436-1-kristen@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com, linux-arch@vger.kernel.org

We will be using -ffunction-sections to place each function in
it's own text section so it can be randomized at load time. The
linker considers these .text.* sections "orphaned sections", and
will place them after the first similar section (.text). However,
we need to move _etext so that it is after both .text and .text.*
We also need to calculate text size to include .text AND .text.*

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/vmlinux.lds.S     | 18 +++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1bf7e312361f..044f7528a2f0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,8 +147,24 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
-	/* End of text section, which should occupy whole number of pages */
+#ifdef CONFIG_FG_KASLR
+	/*
+	 * -ffunction-sections creates .text.* sections, which are considered
+	 * "orphan sections" and added after the first similar section (.text).
+	 * Adding this ALIGN statement causes the address of _etext
+	 * to be below that of all the .text.* orphaned sections
+	 */
+	. = ALIGN(PAGE_SIZE);
+#endif
 	_etext = .;
+
+	/*
+	 * the size of the .text section is used to calculate the address
+	 * range for orc lookups. If we just use SIZEOF(.text), we will
+	 * miss all the .text.* sections. Calculate the size using _etext
+	 * and _stext and save the value for later.
+	 */
+	text_size = _etext - _stext;
 	. = ALIGN(PAGE_SIZE);
 
 	X86_ALIGN_RODATA_BEGIN
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 71e387a5fe90..f5baee74854c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -813,7 +813,7 @@
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
 		orc_lookup = .;						\
-		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
+		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
 		orc_lookup_end = .;					\
 	}
-- 
2.20.1
