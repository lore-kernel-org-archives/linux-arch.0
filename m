Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439813AbfJRQar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:47 -0400
Date: Fri, 18 Oct 2019 16:30:32 -0000
From: "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/asm] x86/uaccess: Annotate local function
In-Reply-To: <20191011115108.12392-9-jslaby@suse.cz>
References: <20191011115108.12392-9-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623236.29376.16892257264383831942.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Message-ID: <20191018163032.PHybbPcB-h0M4HGOOItttaVIL70DAPdmQsRk5JuOcPM@z>

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     fa97220196fda2613a6226cc30b573bd8976e15b
Gitweb:        https://git.kernel.org/tip/fa97220196fda2613a6226cc30b573bd8976e15b
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:48 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:31:42 +02:00

x86/uaccess: Annotate local function

.Lcopy_user_handle_tail is a self-standing local function, annotate it
as such using SYM_CODE_START_LOCAL.

Again, no functional change, just documentation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-9-jslaby@suse.cz
---
 arch/x86/lib/copy_user_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 86976b5..4a12b3c 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -230,8 +230,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ALIGN;
-.Lcopy_user_handle_tail:
+SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
@@ -239,7 +238,7 @@ ALIGN;
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-END(.Lcopy_user_handle_tail)
+SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
