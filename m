Return-Path: <SRS0=VhQ8=BK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGaXIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 19:08:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A2C0617A5
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so18117035plk.1
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 30/36] x86/build: Assert for unwanted sections
Date: Fri, 31 Jul 2020 16:08:14 -0700
Message-ID: <20200731230820.1742553-31-keescook@chromium.org>
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200731230814.e1_nP3M8HWEOSJU1bv8CKBeUCrBqL5Eio7iFfa5SFy0@z>

In preparation for warning on orphan sections, enforce other
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7faffe7414d6..d8792f9c536f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -415,6 +415,15 @@ SECTIONS
 
 	DISCARDS
 
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got (NOLOAD) : {
+		*(.got) *(.igot.*)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
 	/*
 	 * Make sure that the .got.plt is either completely empty or it
 	 * contains only the lazy dispatch entries.
@@ -427,6 +436,21 @@ SECTIONS
 	       SIZEOF(.got.plt) == 0xc,
 #endif
 	       "Unexpected GOT/PLT entries detected!")
+
+	.plt (NOLOAD) : {
+		*(.plt) *(.plt.*) *(.iplt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	/* ld.lld does not like .rel* sections being made "NOLOAD". */
+	.rel.dyn : {
+		*(.rel.*) *(.rel_*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
 #ifdef CONFIG_X86_32
-- 
2.25.1
