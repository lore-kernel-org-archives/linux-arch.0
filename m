From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip 4/4] extable: kallsyms: Add in_init_text() and in_core_text() helper
Date: Thu, 17 Aug 2017 16:17:11 +0900
Message-ID: <150295422137.14424.6418378586511440462.stgit@devbox>
References: <150295395797.14424.968407208436624832.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150295395797.14424.968407208436624832.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-arch.vger.kernel.org

Add in_init_text() and in_core_text() helper to check the
address is in between _sinittext and _einittext, and
in between _stext and _etext correspondingly.

This changes extable.c and kallsyms.c to use these helpers
and memory_contains() helper.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  BTW, is_kernel_text() and core_kernel_text() seem different.
  is_kernel_text() checks arch dependent area and
  in_gate_area_no_mm(), but core_kernel_text() doesn't.
  Can we ignore this differences?
---
 include/asm-generic/sections.h |   24 ++++++++++++++++++++++++
 kernel/extable.c               |   18 ++++--------------
 kernel/kallsyms.c              |   14 +++-----------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index e5da44eddd2f..25ef53fc594c 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -135,4 +135,28 @@ static inline bool init_section_intersects(void *virt, size_t size)
 	return memory_intersects(__init_begin, __init_end, virt, size);
 }
 
+/**
+ * in_init_text - check if an address is in between _sinittext and _einittext.
+ * @addr: virtual address to be checked
+ *
+ * Returns: true if the address specified by @addr is in between _sinittext
+ * and _einittext, false otherwise.
+ */
+static inline bool in_init_text(unsigned long addr)
+{
+	return memory_contains(_sinittext, _einittext, (void *)addr, 0);
+}
+
+/**
+ * in_core_text - check if an address is in between _stext and _etext.
+ * @addr: virtual address to be checked
+ *
+ * Returns: true if the address specified by @addr is in between _stext
+ * and _etext, false otherwise.
+ */
+static inline bool in_core_text(unsigned long addr)
+{
+	return memory_contains(_stext, _etext, (void *)addr, 0);
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff --git a/kernel/extable.c b/kernel/extable.c
index 38c2412401a1..d8b365c8c916 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -62,22 +62,13 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 	return e;
 }
 
-static inline int init_kernel_text(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sinittext &&
-	    addr < (unsigned long)_einittext)
-		return 1;
-	return 0;
-}
-
 int notrace core_kernel_text(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext &&
-	    addr < (unsigned long)_etext)
+	if (in_core_text(addr))
 		return 1;
 
 	if (system_state < SYSTEM_RUNNING &&
-	    init_kernel_text(addr))
+	    in_init_text(addr))
 		return 1;
 	return 0;
 }
@@ -94,8 +85,7 @@ int notrace core_kernel_text(unsigned long addr)
  */
 int core_kernel_data(unsigned long addr)
 {
-	if (addr >= (unsigned long)_sdata &&
-	    addr < (unsigned long)_edata)
+	if (memory_contains(_sdata, _edata, (void *)addr, 0))
 		return 1;
 	return 0;
 }
@@ -120,7 +110,7 @@ int __kernel_text_address(unsigned long addr)
 	 * Since we are after the module-symbols check, there's
 	 * no danger of address overlap:
 	 */
-	if (init_kernel_text(addr))
+	if (in_init_text(addr))
 		return 1;
 	return 0;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 127e7cfafa55..b1443e845dbd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -51,17 +51,9 @@ extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned long kallsyms_markers[] __weak;
 
-static inline int is_kernel_inittext(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sinittext
-	    && addr <= (unsigned long)_einittext)
-		return 1;
-	return 0;
-}
-
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) ||
+	if (in_core_text(addr) ||
 	    arch_is_kernel_text(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
@@ -79,7 +71,7 @@ static int is_ksym_addr(unsigned long addr)
 	if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
 		return is_kernel(addr);
 
-	return is_kernel_text(addr) || is_kernel_inittext(addr);
+	return is_kernel_text(addr) || in_init_text(addr);
 }
 
 /*
@@ -272,7 +264,7 @@ static unsigned long get_symbol_pos(unsigned long addr,
 
 	/* If we found no next symbol, we use the end of the section. */
 	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
+		if (in_init_text(addr))
 			symbol_end = (unsigned long)_einittext;
 		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
 			symbol_end = (unsigned long)_end;
