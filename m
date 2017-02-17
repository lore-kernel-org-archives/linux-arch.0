Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934272AbdBQOOF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Feb 2017 09:14:05 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 21/33] x86/asm: remove __VIRTUAL_MASK_SHIFT==47 assert
Date: Fri, 17 Feb 2017 17:13:16 +0300
Message-ID: <20170217141328.164563-22-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
References: <20170217141328.164563-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170217141316.s_3MBft4az9SmrtQt876HjbNX4i0OV8B3BmeJqpIq4g@z>

We don't need it anymore. 17be0aec74fb ("x86/asm/entry/64: Implement
better check for canonical addresses") made canonical address check
generic wrt. address width.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/entry/entry_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 044d18ebc43c..f07b4efb34d5 100644
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
