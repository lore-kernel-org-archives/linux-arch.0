From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 07/23] arm64: mte: Tags-aware copy_page() implementation
Date: Tue, 21 Apr 2020 15:25:47 +0100
Message-ID: <20200421142603.3894-8-catalin.marinas@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgDUO0Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:26:24 -0400
In-Reply-To: <20200421142603.3894-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When the Memory Tagging Extension is enabled, the tags need to be
preserved across page copy (e.g. for copy-on-write).

Introduce MTE-aware copy_page() which preserves the tags across page
copy.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/copy_page.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index e7a793961408..c3234175efe0 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -25,6 +25,29 @@ alternative_if ARM64_HAS_NO_HW_PREFETCH
 	prfm	pldl1strm, [x1, #384]
 alternative_else_nop_endif
 
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	2f
+alternative_else_nop_endif
+	/*
+	 * Copy tags if MTE has been enabled.
+	 */
+	mov	x2, x0
+	mov	x3, x1
+
+	multitag_transfer_size x7, x5
+1:
+	ldgm	x4, [x3]
+	stgm	x4, [x2]
+
+	add	x2, x2, x7
+	add	x3, x3, x7
+
+	tst	x2, #(PAGE_SIZE - 1)
+	b.ne	1b
+2:
+#endif
+
 	ldp	x2, x3, [x1]
 	ldp	x4, x5, [x1, #16]
 	ldp	x6, x7, [x1, #32]
