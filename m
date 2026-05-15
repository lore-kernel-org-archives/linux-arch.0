Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45637BE8E
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833332; cv=none; b=MuYsRQ1rAehsqf8MUO9NGRv48EsV53zBET5QBDx2bUZoUA7Gz+ZA3cQV7XPbnxG60Fvm7PZWNr2NXhalvQoAlzy7unuZWiyz8cF1UklaScEps1wkDS43gYiGCCxjR0+NVTuxmu+o+P02AF7kUotnpE5yC5hS0fDU22Zu3kI0VQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833332; c=relaxed/simple;
	bh=3Wh0IBiFlKD/4dq6zqC312lxfPw3T3OXDjTOCXnAaIM=;
	h=Date:Message-Id:Mime-Version:References:In-Reply-To:Subject:From:
	 To:Content-Type:Cc; b=n2LzvS7riEUunKY5GDqCwjGr8RfZCdKH2aSajvQdSTeNYKSxtTKHT/Xe1HUk9TruJpWtckVKxKRXn/Bfvq67ZsGlBumzQzzn+Ej4Lb7UIWEJBRalJZ2kE1/8q5VjMkx6rQtm61P21Xfx3jf+Fok3O53iUykRkWc/9B6SkI6x8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NY+3dFg0; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NY+3dFg0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778833326; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/I1RhJJRl8LgLDwnRBLNgWvi4qB5F9lPUEH3scBIO9U=;
 b=NY+3dFg0p8H2udAxtk6wpcAH+UoszAVNuC79nSIc13C69Ck3iXoU2t+4s4uC0/6nuJ+2rS
 RZRasBqBp2iDgP0spE59BCmJw5quYEfyCnfcTGkn4q9q3KjUOxBT4t0+0XX4FxKFaz9Nts
 zgGMnZsoU59Ru6Zcgk6rw1tjKLvNiSefOAEC7fXLkofsVMGoIbMek8iWCczatn2/y+pGDe
 xPy0hy6Gtsv2Kjlp+8XrtA6py+m7/k0KpVEgffYIGQEVUEk7m18Rxbwu5TY0GxdMEUyXR5
 PzFKvPew7ORgwDcRsvDx+s8XYifDGgnlh9Nvtl5N3Cl0eVJ8pjDmUvguQQpmgQ==
Date: Fri, 15 May 2026 16:20:45 +0800
Message-Id: <20260515082045.63029-5-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
In-Reply-To: <20260515082045.63029-1-lizhe.67@bytedance.com>
Subject: [PATCH 4/4] mm: use arch store helpers in zone-device template copies
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a06d7ab+377879+vger.kernel.org+lizhe.67@bytedance.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <arnd@arndb.de>, <rppt@kernel.org>, 
	<akpm@linux-foundation.org>, <david@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>

The template-based fast path still leaves the actual copy sequence up to
the compiler. On x86-64 that can easily degrade back into a runtime copy
loop in the hot path, which leaves performance on the table.

Introduce arch_optimize_store_u64() and arch_optimize_store_drain(),
with a generic fallback and an x86-64 MOVNTI/SFENCE implementation, and
use them in the template copy path. Also open-code the word-at-a-time
copy so the compiler emits fixed-offset stores for the hot path instead
of a runtime loop.

On x86-64, MOVNTI is a better fit for this write-once, streaming
initialization pattern than normal cached stores. It reduces the
write-allocate traffic and cache pollution that a regular store sequence
would otherwise generate while filling large ranges of struct page.

Refresh the PFN-dependent section bits and page->virtual state in the
reusable template before each copy, instead of patching the destination
page afterwards. This keeps the hot path as a fixed-offset store
sequence and avoids post-copy normal stores to cachelines that were
just written with non-temporal stores.

Because non-temporal stores are not ordered against later normal stores,
drain outstanding stores before memmap_init_compound() updates compound
heads and before memmap_init_zone_device() returns.

Disable the x86-64 override under KASAN or KMSAN so those builds keep
their instrumented stores through the generic fallback.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.1-rc3):
  First binding for nd_pmem driver: 1486 ms
  Average of subsequent rebinds: 273.52 ms

  First binding for dax_pmem driver: 1515 ms
  Average of subsequent rebinds: 313.45 ms

With this patch:
  First binding for nd_pmem driver: 1272 ms
  Average of subsequent rebinds: 104.59 ms

  First binding for dax_pmem driver: 1286 ms
  Average of subsequent rebinds: 116.93 ms

This reduces the average rebind time by about 61.8% for nd_pmem and
62.7% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/struct_page_init.h | 28 ++++++++
 include/asm-generic/Kbuild              |  1 +
 include/asm-generic/struct_page_init.h  | 17 +++++
 mm/mm_init.c                            | 89 +++++++++++++++++++++----
 4 files changed, 122 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/struct_page_init.h
 create mode 100644 include/asm-generic/struct_page_init.h

diff --git a/arch/x86/include/asm/struct_page_init.h b/arch/x86/include/asm/struct_page_init.h
new file mode 100644
index 000000000000..de8b4eab44de
--- /dev/null
+++ b/arch/x86/include/asm/struct_page_init.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_STRUCT_PAGE_INIT_H
+#define _ASM_X86_STRUCT_PAGE_INIT_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/*
+ * x86-64 guarantees SSE2, so MOVNTI and SFENCE are always available there.
+ *
+ * KASAN/KMSAN rely on compiler-instrumented stores. Keep the x86 override
+ * disabled for those configs and fall back to plain stores instead.
+ */
+#if defined(CONFIG_X86_64) && !defined(CONFIG_KASAN) && !defined(CONFIG_KMSAN)
+static __always_inline void arch_optimize_store_u64(u64 *dst, u64 val)
+{
+	asm volatile("movnti %1, %0" : "=m"(*dst) : "r"(val));
+}
+
+static __always_inline void arch_optimize_store_drain(void)
+{
+	asm volatile("sfence" : : : "memory");
+}
+#else
+#include <asm-generic/struct_page_init.h>
+#endif
+
+#endif /* _ASM_X86_STRUCT_PAGE_INIT_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 2c53a1e0b760..3a493fed6803 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -65,3 +65,4 @@ mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
 mandatory-y += word-at-a-time.h
+mandatory-y += struct_page_init.h
diff --git a/include/asm-generic/struct_page_init.h b/include/asm-generic/struct_page_init.h
new file mode 100644
index 000000000000..45a722103a51
--- /dev/null
+++ b/include/asm-generic/struct_page_init.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_STRUCT_PAGE_INIT_H
+#define _ASM_GENERIC_STRUCT_PAGE_INIT_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+static __always_inline void arch_optimize_store_u64(u64 *dst, u64 val)
+{
+	*dst = val;
+}
+
+static __always_inline void arch_optimize_store_drain(void)
+{
+}
+
+#endif /* _ASM_GENERIC_STRUCT_PAGE_INIT_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5a9e6ecfa894..a3211666ccd4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -37,6 +37,7 @@
 #include "shuffle.h"
 
 #include <asm/setup.h>
+#include <asm/struct_page_init.h>
 
 #ifndef CONFIG_NUMA
 unsigned long max_mapnr;
@@ -1078,9 +1079,21 @@ static inline bool zone_device_page_init_optimization_enabled(void)
 	return !page_ref_tracepoint_active(page_ref_set);
 }
 
+/*
+ * The fast path copies struct page with fixed-offset u64 stores instead of
+ * a runtime loop. Keep that copy sequence in sync with the struct page
+ * layouts supported by this build.
+ *
+ * The sequence below requires struct page to be u64-aligned and currently
+ * handles layouts from 7 to 12 u64 words (56 to 96 bytes). If a future
+ * layout falls outside that range, fail the build so the store sequence is
+ * updated together with the layout change.
+ */
 static inline void struct_page_layout_check(void)
 {
 	BUILD_BUG_ON(sizeof(struct page) & (sizeof(u64) - 1));
+	BUILD_BUG_ON(sizeof(struct page) < 56);
+	BUILD_BUG_ON(sizeof(struct page) > 96);
 }
 
 static inline void init_template_head_page(struct page *template,
@@ -1108,30 +1121,67 @@ static inline void init_template_tail_page(struct page *template,
 }
 
 /*
- * Initialize parts that differ from the template
+ * 'template' is a reusable page prototype rather than a strictly immutable
+ * object. Most ZONE_DEVICE fields stay constant across the pages covered by
+ * the current template, but section bits and page->virtual may still depend
+ * on the PFN. Refresh those PFN-dependent fields in the template before
+ * copying it into @page.
  */
-static inline void generic_init_zone_device_page_finish(struct page *page,
-							unsigned long pfn)
+static inline void zone_device_page_update_template(struct page *template,
+						    unsigned long pfn)
 {
 #ifdef SECTION_IN_PAGE_FLAGS
-	set_page_section(page, pfn_to_section_nr(pfn));
+	set_page_section(template, pfn_to_section_nr(pfn));
 #endif
 #ifdef WANT_PAGE_VIRTUAL
 	if (!is_highmem_idx(ZONE_DEVICE))
-		set_page_address(page, __va(pfn << PAGE_SHIFT));
+		set_page_address(template, __va(pfn << PAGE_SHIFT));
 #endif
 }
 
 static void init_zone_device_page_from_template(struct page *page,
-		unsigned long pfn, const struct page *template)
+		unsigned long pfn, struct page *template)
 {
 	const u64 *src = (const u64 *)template;
 	u64 *dst = (u64 *)page;
-	unsigned int i;
 
-	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
-		dst[i] = src[i];
-	generic_init_zone_device_page_finish(page, pfn);
+	/*
+	 * 'template' carries the invariant portion of a ZONE_DEVICE struct
+	 * page. Update the PFN-dependent fields in place before copying it
+	 * to the destination page.
+	 */
+	zone_device_page_update_template(template, pfn);
+
+	/*
+	 * Keep the copy open-coded so the compiler emits fixed-offset stores
+	 * for the hot path instead of a runtime copy loop.
+	 */
+	switch (sizeof(struct page)) {
+	case 96:
+		arch_optimize_store_u64(&dst[11], src[11]);
+		fallthrough;
+	case 88:
+		arch_optimize_store_u64(&dst[10], src[10]);
+		fallthrough;
+	case 80:
+		arch_optimize_store_u64(&dst[9], src[9]);
+		fallthrough;
+	case 72:
+		arch_optimize_store_u64(&dst[8], src[8]);
+		fallthrough;
+	case 64:
+		arch_optimize_store_u64(&dst[7], src[7]);
+		fallthrough;
+	case 56:
+		arch_optimize_store_u64(&dst[6], src[6]);
+		arch_optimize_store_u64(&dst[5], src[5]);
+		arch_optimize_store_u64(&dst[4], src[4]);
+		arch_optimize_store_u64(&dst[3], src[3]);
+		arch_optimize_store_u64(&dst[2], src[2]);
+		arch_optimize_store_u64(&dst[1], src[1]);
+		arch_optimize_store_u64(&dst[0], src[0]);
+	}
+
 	zone_device_page_init_pageblock(page, pfn);
 }
 #else
@@ -1201,9 +1251,10 @@ static void __ref memmap_init_compound(struct page *head,
 	__SetPageHead(head);
 
 	/*
-	 * A tail template can be reused for all tail pages in the same compound page
-	 * because shared state for compound tails is pre-set by prep_compound_tail().
-	 * The per-page page->virtual and section in flags are fixed up after copying.
+	 * All tails of the same compound page share the state established by
+	 * prep_compound_tail(). Reuse one tail template for the whole range
+	 * and refresh only the PFN-dependent fields in that template before
+	 * each copy.
 	 */
 	if (use_template)
 		init_template_tail_page(&template, head_pfn + 1, zone_idx, nid,
@@ -1269,10 +1320,22 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		if (pfns_per_compound == 1)
 			continue;
 
+		/*
+		 * Compound-head setup immediately updates head->flags, so make
+		 * the template copy visible before entering memmap_init_compound().
+		 */
+		if (use_template)
+			arch_optimize_store_drain();
+
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
 				     compound_nr_pages(altmap, pgmap),
 				     use_template);
 	}
+	/*
+	 * Drain any remaining non-temporal stores before returning.
+	 */
+	if (use_template)
+		arch_optimize_store_drain();
 
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
-- 
2.20.1
