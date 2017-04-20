Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033096AbdDTQWf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Apr 2017 12:22:35 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 1/9] x86/asm: Fix comment in return_from_SYSCALL_64
Date: Thu, 20 Apr 2017 19:21:39 +0300
Message-ID: <20170420162147.86517-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170420162147.86517-1-kirill.shutemov@linux.intel.com>
References: <20170420162147.86517-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170420162139.rmpFZEWwcRPhFynjH8kXfwW0Yl9__uSzPCWHHjvduBk@z>

On x86-64 __VIRTUAL_MASK_SHIFT depends on paging mode now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/entry_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 607d72c4a485..edec30584eb8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -266,7 +266,8 @@ return_from_SYSCALL_64:
 	 * If width of "canonical tail" ever becomes variable, this will need
 	 * to be updated to remain correct on both old and new CPUs.
 	 *
-	 * Change top 16 bits to be the sign-extension of 47th bit
+	 * Change top bits to match most significant bit (47th or 56th bit
+	 * depending on paging mode) in the address.
 	 */
 	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
 	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
-- 
2.11.0
