Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18435 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbdC0Qaa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Mar 2017 12:30:30 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/8] x86/asm: Remove __VIRTUAL_MASK_SHIFT==47 assert
Date: Mon, 27 Mar 2017 19:29:19 +0300
Message-ID: <20170327162925.16092-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170327162919.1u1e1SQK_SNhrW3jfs0yPmnPyTZA_fU0B0TP93DX4y0@z>

We don't need the assert anymore. 17be0aec74fb ("x86/asm/entry/64:
Implement better check for canonical addresses") made canonical
address check generic wrt. address width.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/entry_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2b2a2948ffe..607d72c4a485 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -265,12 +265,9 @@ return_from_SYSCALL_64:
 	 *
 	 * If width of "canonical tail" ever becomes variable, this will need
 	 * to be updated to remain correct on both old and new CPUs.
+	 *
+	 * Change top 16 bits to be the sign-extension of 47th bit
 	 */
-	.ifne __VIRTUAL_MASK_SHIFT - 47
-	.error "virtual address width changed -- SYSRET checks need update"
-	.endif
-
-	/* Change top 16 bits to be the sign-extension of 47th bit */
 	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
 	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
 
-- 
2.11.0
