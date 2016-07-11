Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34576 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbcGKUya (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jul 2016 16:54:30 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 13/32] x86/mm/64: In vmalloc_fault(), use CR3 instead of current->active_mm
Date: Mon, 11 Jul 2016 13:53:46 -0700
Message-ID: <3213d3f31959a6467b1feb80a384c1e11341b2be.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160711205346.u79LCqzRpcLH-wBOY60eLANIHdOwjT4bKWl3Tb4ASV0@z>

If we get a vmalloc fault while current->active_mm->pgd doesn't
match CR3, we'll crash without this change.  I've seen this failure
mode on heavily instrumented kernels with virtually mapped stacks.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7d1fa7cd2374..ca44e2e7fd00 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -439,7 +439,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	 * happen within a race in page table update. In the later
 	 * case just flush:
 	 */
-	pgd = pgd_offset(current->active_mm, address);
+	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(address);
 	pgd_ref = pgd_offset_k(address);
 	if (pgd_none(*pgd_ref))
 		return -1;
-- 
2.7.4

