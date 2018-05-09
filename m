Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:36038 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbeEIHvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 03:51:06 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] x86: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:49:34 +0900
Message-ID: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20180509074934.4x1Vt_aP9mSScpYjCSskLWjAD9F9WgKaW5yHNfdmf0Y@z>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for x86-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 795f3a8..5e1458f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -117,11 +117,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
+		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
+		__entry_trampoline_end = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
-- 
2.7.4
