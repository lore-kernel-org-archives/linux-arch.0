From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v4 05/10] x86: Make sure _etext includes function sections
Date: Fri, 17 Jul 2020 10:00:02 -0700
Message-ID: <20200717170008.5949-6-kristen@linux.intel.com>
References: <20200717170008.5949-1-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200717170008.5949-1-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: arjan@linux.intel.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com, Kristen Carlson Accardi <kristen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When using -ffunction-sections to place each function in
it's own text section so it can be randomized at load time, the
linker considers these .text.* sections "orphaned sections", and
will place them after the first similar section (.text). In order
to accurately represent the end of the text section and the
orphaned sections, _etext must be moved so that it is after both
.text and .text.* The text size must also be calculated to
include .text AND .text.*

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     | 17 +++++++++++++++--
 include/asm-generic/vmlinux.lds.h |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..e8da7eeb4d8d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -146,9 +146,22 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
-	/* End of text section, which should occupy whole number of pages */
-	_etext = .;
+	/*
+	 * -ffunction-sections creates .text.* sections, which are considered
+	 * "orphan sections" and added after the first similar section (.text).
+	 * Placing this ALIGN statement before _etext causes the address of
+	 * _etext to be below that of all the .text.* orphaned sections
+	 */
 	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+
+	/*
+	 * the size of the .text section is used to calculate the address
+	 * range for orc lookups. If we just use SIZEOF(.text), we will
+	 * miss all the .text.* sections. Calculate the size using _etext
+	 * and _stext and save the value for later.
+	 */
+	text_size = _etext - _stext;
 
 	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a5552cf28d5d..34eab6513fdc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -835,7 +835,7 @@
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
