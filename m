Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdGPXAB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Jul 2017 19:00:01 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/8] x86/xen: Redefine XEN_ELFNOTE_INIT_P2M using PUD_SIZE * PTRS_PER_PUD
Date: Mon, 17 Jul 2017 01:59:49 +0300
Message-ID: <20170716225954.74185-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
References: <20170716225954.74185-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170716225949.gWwYSB2jQ2WTJmhvi2epQu2Vv3UzlWlHkX7R3bFVPmU@z>

XEN_ELFNOTE_INIT_P2M has to be 512GB for both 4- and 5-level paging.
(PUD_SIZE * PTRS_PER_PUD) would do this.

Unfortunately, we cannot use P4D_SIZE, which would fit here. With
current headers structure it cannot be used in assembly, if p4d
level is folded.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/xen/xen-head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 72a8e6adebe6..a7525e95d53f 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -58,7 +58,7 @@ ENTRY(hypercall_page)
 #else
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
 	/* Map the p2m table to a 512GB-aligned user address. */
-	ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad PGDIR_SIZE)
+	ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
 #endif
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
-- 
2.11.0
